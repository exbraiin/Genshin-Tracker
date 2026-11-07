import 'dart:io';
import 'dart:math' as math;

import 'package:data_editor/db_ext/data_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

const _maxCachedImageEntries = 256;

class _ImageDimensions({
  required final DateTime modified,
  required final DateTime changed,
  required final int bytes,
  required final (int, int)? size,
}) {
  bool hasStat(FileStat stat) {
    return modified == stat.modified &&
        changed == stat.changed &&
        bytes == stat.size;
  }
}

final _dimensions = <String, _ImageDimensions>{};

GsValidLevel _validateImageFileSync(File? file, (int, int)? expectedSize) {
  if (file == null) return GsValidLevel.warn2;
  try {
    final stat = file.statSync();
    if (stat.type != FileSystemEntityType.file) return GsValidLevel.warn2;
    if (expectedSize == null) return GsValidLevel.good;

    final path = file.absolute.path;
    var cached = _dimensions[path];
    if (cached == null || !cached.hasStat(stat)) {
      final bytes = file.readAsBytesSync();
      final info = img.findDecoderForData(bytes)?.startDecode(bytes);
      cached = _ImageDimensions(
        modified: stat.modified,
        changed: stat.changed,
        bytes: stat.size,
        size: info == null ? null : (info.width, info.height),
      );
      if (_dimensions.length >= _maxCachedImageEntries) {
        _dimensions.remove(_dimensions.keys.first);
      }
      _dimensions[path] = cached;
    }
    if (cached.size == null) return GsValidLevel.error;
    return cached.size == expectedSize ? GsValidLevel.good : GsValidLevel.warn3;
  } catch (_) {
    return GsValidLevel.error;
  }
}

bool imageValidationInWorker = false;
Future<void> _queue = Future.value();
final _results =
    <(String, DateTime, DateTime, int, (int, int)?), Future<GsValidLevel>>{};

Future<GsValidLevel> validateImageFile(
  File? file,
  (int, int)? expectedSize,
) async {
  if (imageValidationInWorker) {
    return _validateImageFileSync(file, expectedSize);
  }
  if (file == null) return GsValidLevel.warn2;
  try {
    final stat = await file.stat();
    if (stat.type != FileSystemEntityType.file) return GsValidLevel.warn2;
    if (expectedSize == null) return GsValidLevel.good;
    final key = (
      file.absolute.path,
      stat.modified,
      stat.changed,
      stat.size,
      expectedSize,
    );
    final existing = _results[key];
    if (existing != null) return await existing;
    final result = _queue.then(
      (_) => compute(_validateImageRequest, (key.$1, expectedSize)),
    );
    _queue = result.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    if (_results.length >= _maxCachedImageEntries) {
      _results.remove(_results.keys.first);
    }
    _results[key] = result;
    return await result;
  } catch (_) {
    return GsValidLevel.error;
  }
}

GsValidLevel _validateImageRequest((String, (int, int)?) request) =>
    _validateImageFileSync(File(request.$1), request.$2);

Future<void> cutImageToExpectedSize(File? file, (int, int) expectedSize) async {
  if (file == null) return;
  final (width, height) = expectedSize;
  if (width <= 0 || height <= 0) {
    throw ArgumentError.value(expectedSize, 'expectedSize', 'Must be positive');
  }
  final bytes = await file.readAsBytes();
  final output = await compute(_fitImageToSize, (bytes, expectedSize));
  if (output == null) return;
  await file.writeAsBytes(output, flush: true);
  final path = file.absolute.path;
  _dimensions.remove(path);
  _results.removeWhere((key, _) => key.$1 == path);
}

List<int>? _fitImageToSize((Uint8List, (int, int)) request) {
  final decoded = img.decodeImage(request.$1);
  if (decoded == null) throw const FormatException('Cannot decode image');
  final source = img.bakeOrientation(decoded);
  final (width, height) = request.$2;
  if (source.width == width && source.height == height) return null;
  final scale = math.min(width / source.width, height / source.height);
  final resized = img.copyResize(
    source,
    width: (source.width * scale).round().clamp(1, width),
    height: (source.height * scale).round().clamp(1, height),
    interpolation: img.Interpolation.linear,
  );
  final canvas = img.Image(width: width, height: height, numChannels: 4);
  img.compositeImage(
    canvas,
    resized,
    dstX: (width - resized.width) ~/ 2,
    dstY: (height - resized.height) ~/ 2,
  );
  return img.encodePng(canvas);
}
