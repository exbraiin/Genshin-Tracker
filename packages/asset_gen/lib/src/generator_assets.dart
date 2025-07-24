import 'dart:convert';
import 'dart:io';

import 'package:asset_gen/src/asset_gen_base.dart';
import 'package:asset_gen/src/utils.dart';
import 'package:dartx/dartx_io.dart';

Future<void> generateAssets(List<AssetConfig> configs) async {
  final missing = <String>{};

  for (final config in configs) {
    final buffer = StringBuffer()..writeGenHeader();

    for (final aClass in config.classes) {
      buffer.writeln(await _assetsClass(aClass.name, aClass.paths));
      missing.addAll(await _assetsMissing(aClass.paths));
    }
    final fileOut = File(config.path);
    if (!await fileOut.parent.exists()) {
      await fileOut.parent.create(recursive: true);
    }
    await fileOut.writeAsString(buffer.toString());
  }

  if (missing.isNotEmpty) {
    final buffer = StringBuffer();
    buffer.writeln('---------------------------------');
    buffer.writeln('${missing.length} missing graphics');
    buffer.writeln('---------------------------------');
    buffer.write(missing.join('\n'));
    print(buffer);
  }
}

Future<String> _assetsClass(String name, Iterable<String> paths) async {
  final buffer = StringBuffer();
  buffer.writeln('/// $name');
  buffer.writeln('abstract final class ${_toVarName(name).capitalize()} {');
  final amount = <String, int>{};
  final files = await _listFiles(paths);
  final filesToWrite = files
      .where((e) => !e.contains('.0x'))
      .sortedBy((e) => File(e).nameWithoutExtension);
  for (final path in filesToWrite) {
    final file = File(path);
    final fieldName = _toVarName(file.nameWithoutExtension);
    var field = fieldName;
    final count = amount[fieldName] ??= 0;
    if (count != 0) field = '$field$count';
    amount[fieldName] = amount[fieldName]! + 1;
    if (path != filesToWrite.first) buffer.writeln();
    buffer.writeln('  /// ${file.name}');
    final ms = await _lottieMilliseconds(file);
    if (ms != null) {
      buffer.writeln('  static const $field = (');
      buffer.writeln('    asset: \'$path\',');
      buffer.writeln('    duration: Duration(milliseconds: $ms),');
      buffer.writeln('  );');
    } else {
      buffer.writeln('  static const $field = \'$path\';');
    }
  }
  buffer.writeln('}');
  return buffer.toString();
}

Future<Iterable<String>> _assetsMissing(Iterable<String> paths) async {
  // https://docs.flutter.dev/ui/assets/assets-and-images#resolution-aware
  const rsls = ['2.0x', '3.0x'];
  // https://api.flutter.dev/flutter/widgets/Image-class.html
  // JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, and WBMP
  const imgs = ['.jpeg', '.png', '.gif', '.webp', '.bmp', '.wbmp'];

  final list = await _listFiles(paths);
  final missing = <String>{};
  for (final path in list) {
    if (path.contains('.0x')) continue;
    final file = File(path);
    if (!imgs.contains(file.extension.toLowerCase())) continue;
    for (final vr in rsls) {
      final f = File('${file.parent.path}/$vr/${file.name}');
      if (!await f.exists()) missing.add(f.path);
    }
  }
  return missing;
}

Future<Iterable<String>> _listFiles(Iterable<String> allPaths) async {
  final paths = <String>{};
  for (final path in allPaths) {
    final asFile = File(path);
    if (await asFile.exists()) {
      paths.add(normalizePath(path));
      continue;
    }

    final segments = normalizePath(path).split('/');
    final folder = segments.takeWhile((e) => !e.contains('*'));
    final parent = Directory(folder.join('/'));
    if (await parent.exists()) {
      final recursive =
          folder.length < segments.length && segments[folder.length] == '**';
      final inFolder = await parent.list(recursive: recursive).toList();

      final source = path
          .replaceAll('/', '\\/')
          .replaceAll('.', '\\.')
          .replaceAll('**', '.+')
          .replaceAll('*', '.+');
      final regex = RegExp(source);

      final selected = inFolder
          .whereType<File>()
          .map((file) => normalizePath(file.path))
          .where(regex.hasMatch);
      paths.addAll(selected);
    }
  }
  return paths;
}

String _toVarName(String word) {
  bool isChar(int v) => v.between(65, 90) || v.between(97, 122);
  bool isNum(int v) => v.between(48, 57);
  final words = '${isChar(word.runes.first) ? '' : 'asset_'}$word'
      .runes
      .map((e) => isChar(e) || isNum(e) ? String.fromCharCode(e) : '_')
      .join()
      .split('_')
      .where((e) => e.isNotEmpty);
  return '${words.first}${words.skip(1).map((w) => w.capitalize()).join()}'
      .decapitalize();
}

Future<int?> _lottieMilliseconds(File file) async {
  if (file.extension != '.json') return null;
  final content = await file.readAsString();
  final lottie = jsonDecode(content) as Map<String, dynamic>;
  late final ip = lottie['ip'] as num?;
  late final op = lottie['op'] as num?;
  late final fr = lottie['fr'] as num?;
  if (ip == null || op == null || fr == null) return null;
  return ((op - ip) / fr * 1000).floor();
}
