import 'dart:io';

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
