import 'dart:convert';
import 'dart:io';

import 'package:asset_gen/src/asset_gen_base.dart';
import 'package:asset_gen/src/utils.dart';
import 'package:dartx/dartx.dart';

Future<void> generateLocalization(LangConfig config) async {
  final content = await File(config.src).readAsString();
  final jsonMap = (jsonDecode(content) as Map).cast<String, String>();

  final buffer = StringBuffer()..writeGenHeader();
  buffer.writeln(_writeKeys(jsonMap));
  buffer.write(_writeDelegate(jsonMap));
  await File(config.dst).writeAsString(buffer.toString());
}

String _writeKeys(Map<String, String> json) {
  final buffer = StringBuffer();

  buffer.writeln('/// The localization keys');
  buffer.writeln('abstract final class LocalizationKeys {');

  var space = false;
  const plural = ['.zero', '.one', '.two', '.few', '.many'];
  for (final entry in json.entries) {
    if (plural.any((p) => entry.key.endsWith(p))) continue;

    final varName = _normalizeName(entry.key);
    if (space) buffer.writeln();
    buffer.writeln('  /// ${_normalizeDocs(entry.value)}');
    buffer.writeln('  static const $varName = \'${entry.key}\';');
    space = true;
  }

  buffer.writeln('}');
  return buffer.toString();
}

String _writeDelegate(Map<String, String> json) {
  final buffer = StringBuffer();

  const extra = '{int? howMany, Map<String, dynamic>? params}';
  buffer.writeln('/// The localization methods');
  buffer.writeln('class LocalizationMethods {');
  buffer.writeln('  /// The localization callback');
  buffer.writeln('  final String Function(String key, $extra) provider;');
  buffer.writeln();
  buffer.writeln('  /// Creates a new [LocalizationMethods] instance.');
  buffer.writeln('  LocalizationMethods(this.provider);');
  buffer.writeln();

  final regex = RegExp(r'(?<!\{)\{\w+\}(?!\})');
  const plural = ['.zero', '.one', '.two', '.few', '.many'];
  for (final entry in json.entries) {
    if (plural.any((p) => entry.key.endsWith(p))) continue;

    final matches = regex.allMatches(entry.value);
    final groups = matches
        .map((e) => e.input.substring(e.start, e.end))
        .map((e) => e.substring(1, e.length - 1))
        .toSet();

    final hasPlural = plural.any((p) => json.keys.contains('${entry.key}$p'));

    final fnName = _normalizeName(entry.key);
    final params = groups.map((e) => _normalizeName(e)).join(', ');
    buffer.writeln();
    buffer.writeln('  /// ${_normalizeDocs(entry.value)}');

    final (param, arg) = hasPlural
        ? (', {required int howMany}', ', howMany: howMany')
        : ('', '');
    final others = groups.map((e) => '\'$e\': ${_normalizeName(e)}').join(', ');
    final other = groups.isNotEmpty ? ', params: {$others}' : '';

    buffer.writeln('  String $fnName($params$param) {');
    final key = 'LocalizationKeys.${_normalizeName(entry.key)}';
    buffer.writeln('    return provider($key$arg$other);');
    buffer.writeln('  }');
  }

  buffer.writeln('}');
  return buffer.toString();
}

String _normalizeName(String word) {
  bool isChar(int v) => v.between(65, 90) || v.between(97, 122);
  bool isNum(int v) => v.between(48, 57);

  if (!isChar(word.runes.first)) word = 'key_$word';
  final codes = word.runes.map((e) => isChar(e) || isNum(e) ? e : 95);
  final words = String.fromCharCodes(codes);
  return words.split('_').map((e) => e.capitalize()).join().decapitalize();
}

String _normalizeDocs(String value) {
  value = value.replaceAll('\r', '\n').replaceAll('\n', ' ');
  return String.fromCharCodes(value.runes.take(100));
}
