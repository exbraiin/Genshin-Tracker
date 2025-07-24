import 'package:yaml/yaml.dart';

class AssetConfig {
  final String path;
  final List<AssetClass> classes;
  AssetConfig(this.path, this.classes);
}

class AssetClass {
  final String name;
  final List<String> paths;
  AssetClass(this.name, this.paths);
}

List<AssetConfig> parseAssetsConfig(YamlList list) {
  return list.map((item) {
    final classes = (item['classes'] as YamlList).map((item) {
      final paths = (item['paths'] as YamlList).cast<String>();
      return AssetClass(item['name'], paths);
    }).toList();
    return AssetConfig(item['path'], classes);
  }).toList();
}

typedef LangConfig = ({String src, String dst});

LangConfig parseLangConfig(YamlMap map) {
  return (src: map['src'], dst: map['dst']);
}
