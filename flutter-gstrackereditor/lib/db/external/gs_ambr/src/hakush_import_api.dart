import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:data_editor/db/database.dart';
import 'package:data_editor/db/external/gs_ambr/src/import_api.dart';
import 'package:data_editor/style/utils.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';

final class HakushImportApi implements ImportApi {
  static const _kBaseUrl = 'https://api.hakush.in';
  static final i = HakushImportApi._();

  @override
  final icon = Image.network('https://hakush.in/apple-touch-icon.png');
  @override
  final name = 'Hakush';

  final _cache = ImportCache(_kBaseUrl);
  HakushImportApi._();

  Future<JsonMap> _fetchPage(String endpoint, {bool useCache = true}) async {
    return _cache.fetchPage(endpoint, useCache: useCache);
  }

  @override
  Future<GsArtifact> fetchArtifact(String id, [GsArtifact? other]) async {
    final json = await _fetchPage('/gi/data/en/artifact/$id.json');
    final pieces = json.getJsonMap('Parts').mapEntries((entry) {
      final map = entry.value as JsonMap? ?? const {};
      final type = switch (entry.key) {
        'EQUIP_BRACER' => GeArtifactPieceType.flowerOfLife,
        'EQUIP_NECKLACE' => GeArtifactPieceType.plumeOfDeath,
        'EQUIP_RING' => GeArtifactPieceType.sandsOfEon,
        'EQUIP_SHOES' => GeArtifactPieceType.gobletOfEonothem,
        'EQUIP_DRESS' => GeArtifactPieceType.circletOfLogos,
        _ => GeArtifactPieceType.flowerOfLife,
      };
      final otherPiece = other?.pieces.firstOrNullWhere((e) => e.type == type);
      return GsArtifactPiece(
        id: type.id,
        name: map.getString('Name'),
        desc: map.getString('Desc'),
        icon: otherPiece?.icon ?? '',
        type: type,
      );
    }).toList();

    final affix = json
        .getJsonMapList('Affix')
        .sortedBy((e) => e.getInt('level'))
        .map((e) => (name: e.getString('Name'), desc: e.getString('Desc')))
        .toList();

    final singleAffix = affix.length < 2;
    final name = affix.firstOrNull?.name ?? '';
    final rank = json.getIntList('Rank').max() ?? 0;

    return (other ?? GsArtifact.fromJson(const {})).copyWith(
      id: name.toDbId(),
      name: name,
      region: null,
      version: null,
      rarity: rank,
      pc1: singleAffix ? affix.firstOrNull?.desc : null,
      pc2: !singleAffix ? affix.firstOrNull?.desc : null,
      pc4: !singleAffix ? affix.lastOrNull?.desc : null,
      domain: null,
      pieces: pieces,
    );
  }

  @override
  Future<List<ImportItem>> fetchArtifacts() async {
    final json = await _fetchPage('/gi/data/artifact.json');
    return json.mapEntries((entry) {
      final map = entry.value as JsonMap;
      final icon = 'https://api.hakush.in/gi/UI/${map.getString('icon')}.webp';
      final level = map.getIntList('rank').max() ?? 0;

      final set =
          map.getJsonMap('set').values.firstOrNull as JsonMap? ?? const {};
      final name = set.getJsonMap('name').getString('EN');

      return ImportItem(entry.key, name, icon, level);
    }).toList();
  }

  @override
  Future<GsCharacter> fetchCharacter(String id, [GsCharacter? other]) async {
    final json = await _fetchPage('/gi/data/en/character/$id.json');

    final name = json.getStringOrNull('Name');
    final desc = json.getStringOrNull('Desc');
    final info = json.getJsonMap('CharaInfo');
    final rarity = ImportUtils.rarityNameToLevel(
      json.getString('Rarity'),
      other?.rarity,
    );

    final title = info.getString('Title');
    final native = info.getString('Native');
    final weapon = json.getString('Weapon');
    final weaponType = switch (weapon) {
      'WEAPON_BOW' => GeWeaponType.bow,
      'WEAPON_SWORD_ONE_HAND' => GeWeaponType.sword,
      'WEAPON_POLE' => GeWeaponType.polearm,
      'WEAPON_CATALYST' => GeWeaponType.catalyst,
      'WEAPON_CLAYMORE' => GeWeaponType.claymore,
      _ => GeWeaponType.none,
    };
    final region = info.getString('Region');
    final regionType = switch (region) {
      'ASSOC_TYPE_MONDSTADT' => GeRegionType.mondstadt,
      'ASSOC_TYPE_LIYUE' => GeRegionType.liyue,
      'ASSOC_TYPE_INAZUMA' => GeRegionType.inazuma,
      'ASSOC_TYPE_SUMERU' => GeRegionType.sumeru,
      'ASSOC_TYPE_FONTAINE' => GeRegionType.fontaine,
      'ASSOC_TYPE_NATLAN' => GeRegionType.natlan,
      'ASSOC_TYPE_FATUI' => GeRegionType.snezhnaya,
      _ => GeRegionType.none,
    };
    final elementId = info.getString('Vision').toLowerCase();
    final elementType = GeElementType.values.fromId(elementId);
    final constellation = info.getString('Constellation');
    final birth = info.getIntList('Birth');
    final birthday = birth.length > 1 ? DateTime(0, birth[0], birth[1]) : null;
    final release = DateTime.tryParse(info.getString('ReleaseDate'));
    final food = info.getJsonMap('SpecialFood').getString('Name');
    final foodDish = Database.i.of<GsRecipe>().getItem(food.toDbId())?.id;
    final namecard = info.getJsonMap('Namecard').getString('Name');
    final namecardId = namecard.isEmpty ? null : namecard.toDbId();
    final materials = json.getJsonMap('Materials');
    final infoMats = Database.i.of<GsMaterial>();
    final mats = [
      ...(materials.getList('Talents').firstOrNull as List? ?? []),
      (materials.getList('Ascensions').firstOrNull as JsonMap? ?? const {}),
    ]
        .expand((e) => (e as JsonMap? ?? {}).getJsonMapList('Mats'))
        .map((e) => e.getString('Name'))
        .map((e) => infoMats.getItem(e.toDbId()))
        .whereNotNull()
        .distinctBy((e) => e.id)
        .sortedBy((e) => e.rarity)
        .toList();

    String? getMaterial(GeMaterialType type, [GeMaterialType? type1]) {
      return mats
          .firstOrNullWhere((e) => e.group == type || e.group == type1)
          ?.id;
    }

    return (other ?? GsCharacter.fromJson(const {})).copyWith(
      id: name?.toDbId(),
      enkaId: id,
      name: name,
      namecardId: namecardId,
      title: title,
      rarity: rarity,
      region: regionType,
      weapon: weaponType,
      element: elementType,
      // version
      // source
      description: desc,
      constellation: constellation,
      affiliation: native,
      specialDish: foodDish,
      birthday: birthday,
      releaseDate: release,
      gemMaterial: getMaterial(GeMaterialType.ascensionGems),
      bossMaterial: getMaterial(
        GeMaterialType.normalBossDrops,
      ),
      commonMaterial: getMaterial(
        GeMaterialType.normalDrops,
        GeMaterialType.eliteDrops,
      ),
      regionMaterial: getMaterial(GeMaterialType.regionMaterials),
      talentMaterial: getMaterial(GeMaterialType.talentMaterials),
      weeklyMaterial: getMaterial(GeMaterialType.weeklyBossDrops),
      // ascStatType
      // ascHpValue
      // ascAtkValue
      // ascDefValue
      // ascStatValue
    );
  }

  @override
  Future<List<ImportItem>> fetchCharacters() async {
    final json = await _fetchPage('/gi/data/character.json');
    return json.mapEntries((entry) {
      final map = entry.value as JsonMap;
      final name = map.getString('EN');
      final icon = 'https://api.hakush.in/gi/UI/${map.getString('icon')}.webp';
      final level = switch (map.getString('rank')) {
        'QUALITY_ORANGE' || 'QUALITY_ORANGE_SP' => 5,
        'QUALITY_PURPLE' => 4,
        _ => 0,
      };
      return ImportItem(entry.key, name, icon, level);
    }).toList();
  }

  @override
  Future<GsNamecard> fetchNamecard(String id, [GsNamecard? other]) async {
    return (other ?? GsNamecard.fromJson(const {})).copyWith();
  }

  @override
  Future<List<ImportItem>> fetchNamecards() async {
    return [];
  }

  @override
  Future<GsRecipe> fetchRecipe(String id, [GsRecipe? other]) async {
    final json = await _cache.fetchPage('/gi/data/en/item/$id.json');

    final name = json.getString('Name');
    final desc = json.getString('Desc');
    final rank = json.getInt('Rank');
    final effectDesct = json.getString('Effect');

    return (other ?? GsRecipe.fromJson(const {})).copyWith(
      id: name.toDbId(),
      name: name,
      type: null,
      rarity: rank,
      version: null,
      image: null,
      effect: null,
      desc: desc,
      effectDesc: effectDesct,
      baseRecipe: null,
      ingredients: null,
    );
  }

  @override
  Future<List<ImportItem>> fetchRecipes() async {
    final json = await _cache.fetchPage('/gi/data/en/item.json');
    final items = json
        .mapEntries((entry) {
          final map = entry.value as JsonMap? ?? const {};
          final type = map.getString('Type');
          if (type != 'Food') return ImportItem('', '', '', -1);

          final name = map.getString('Name');
          final rank = map.getInt('Rank');
          final icon =
              'https://api.hakush.in/gi/UI/${map.getString('Icon')}.webp';

          return ImportItem(entry.key, name, icon, rank);
        })
        .where((e) => e.level >= 0)
        .toList();

    items.removeWhere((item) {
      const kDelicious = 'Delicious ';
      const kSuspicious = 'Suspicious ';
      late final subDelicious = item.name.substring(kDelicious.length);
      late final subSuspicious = item.name.substring(kSuspicious.length);

      return item.name.startsWith(kDelicious) &&
              items.any((e) => e.name == subDelicious) ||
          item.name.startsWith(kSuspicious) &&
              items.any((e) => e.name == subSuspicious);
    });

    return items;
  }

  @override
  Future<GsWeapon> fetchWeapon(String id, [GsWeapon? other]) async {
    // final json = await _cache.fetchPage('/weapon/$id/__data.json');
    return (other ?? GsWeapon.fromJson(const {})).copyWith();
  }

  @override
  Future<List<ImportItem>> fetchWeapons() async {
    final json = await _cache.fetchPage('/gi/data/weapon.json');
    return json.mapEntries((entry) {
      final map = entry.value as JsonMap? ?? const {};
      final name = map.getString('EN');
      final icon = 'https://api.hakush.in/gi/UI/${map.getString('icon')}.webp';
      final rank = map.getInt('rank');
      return ImportItem(entry.key, name, icon, rank);
    }).toList();
  }
}
