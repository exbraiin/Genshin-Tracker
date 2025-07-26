import 'dart:io';

import 'package:args/args.dart';
import 'package:asset_gen/src/asset_gen_base.dart';
import 'package:asset_gen/src/generator_assets.dart';
import 'package:asset_gen/src/generator_localization.dart';
import 'package:yaml/yaml.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addFlag(
      'example',
      abbr: 'e',
      help: 'Generates a tasks_example.yaml file',
      negatable: false,
    )
    ..addFlag(
      'generate',
      abbr: 'g',
      help: 'Generates the assets ".dart" files',
      negatable: false,
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Shows help',
      negatable: false,
    )
    ..addFlag(
      'missing',
      abbr: 'm',
      help: 'Shows missing assets',
      negatable: false,
    )
    ..addOption(
      'tasks',
      abbr: 't',
      help: 'The path for the assets.yaml file',
    );
  final args = parser.parse(arguments);

  if (args.flag('help')) {
    print(parser.usage);
    return;
  }

  if (args.flag('example')) {
    final buffer = StringBuffer()
      ..writeln('assets:')
      ..writeln('  - path: lib/theme/assets.g.dart')
      ..writeln('    classes:')
      ..writeln('      - name: Assets')
      ..writeln('        paths:')
      ..writeln('          - assets/**/*.png')
      ..writeln()
      ..writeln('localization:')
      ..writeln('  dst: lib/lang/keys.g.dart')
      ..writeln('  src: assets/lang/en.json');
    await File('tasks_example.yaml').writeAsString(buffer.toString());
  }

  if (args.flag('generate')) {
    final path = args.option('tasks') ?? 'assets.yaml';
    final yamlContent = await File(path).readAsString();
    final yamlMap = loadYaml(yamlContent) as YamlMap?;
    if (yamlMap == null) return;

    final assetYaml = yamlMap['assets'] as YamlList?;
    if (assetYaml != null) {
      print('Generating Assets');
      final showMissing = args.flag('missing');
      final assetConfig = parseAssetsConfig(assetYaml);
      await generateAssets(assetConfig, !showMissing);
    }

    final langYaml = yamlMap['localization'] as YamlMap?;
    if (langYaml != null) {
      print('Generating Localization');
      final langConfig = parseLangConfig(langYaml);
      await generateLocalization(langConfig);
    }
    print('Assets & Localization complete!');
  }
}
