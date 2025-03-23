import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:data_editor/db/external/gs_ambr/src/import_api.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:http/http.dart' as http;

class GsEnka {
  static final i = GsEnka._();

  final characters = <GsEnkaChar>[];
  GsEnka._();

  Future<void> load() async {
    if (characters.isNotEmpty) return;
    const url = 'https://raw.githubusercontent.com/EnkaNetwork'
        '/API-docs/master/store/characters.json';

    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final chars = json.entries
        .map((e) => GsEnkaChar.fromJson({'id': e.key, ...e.value}))
        .distinctBy((e) => e.id)
        .where((e) => !e.id.contains('-'))
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.icon.isNotEmpty ? 0 : 1)
        .toList();
    characters.addAll(chars);
  }
}

class GsEnkaChar {
  final String id;
  final String icon;
  final int rarity;
  final GeElementType element;

  GsEnkaChar.fromJson(Map<String, dynamic> map)
      : id = map['id'] as String? ?? '',
        icon = (map['SideIconName'] ?? '').isNotEmpty
            ? 'https://enka.network/ui/${map['SideIconName']}.png'
            : '',
        rarity = ImportUtils.rarityNameToLevel(map['QualityType']),
        element = ImportUtils.elementNameToType(map['Element']);
}
