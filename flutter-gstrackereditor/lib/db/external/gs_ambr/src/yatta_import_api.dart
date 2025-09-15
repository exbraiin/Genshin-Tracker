import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:data_editor/db/database.dart';
import 'package:data_editor/db/external/gs_ambr/src/import_api.dart';
import 'package:data_editor/style/utils.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';

final class YattaImporter implements ImportApi {
  static const _kBaseUrl = 'https://gi.yatta.top';
  static final i = YattaImporter._();

  @override
  final icon = Image.network('https://ambr.top/favicon.ico');
  @override
  final name = 'Yatta';

  final _cache = ImportCache(_kBaseUrl);
  YattaImporter._();

  Future<JsonMap> _fetchPage(
    String endpoint, {
    bool isStatic = false,
    bool useCache = true,
  }) async {
    final url = isStatic ? '/api/v2/static/$endpoint' : '/api/v2/en/$endpoint';
    final page = await _cache.fetchPage(url, useCache: useCache);
    return page.getJsonMap('data');
  }

  @override
  Future<List<ImportItem>> fetchArtifacts() async {
    const url = '$_kBaseUrl/assets/UI/reliquary';
    final data = await _fetchPage('reliquary');
    final items = data.getJsonMap('items');
    return items.values.cast<JsonMap>().map((m) {
      final levels = (m['levelList'] as List? ?? []).cast<int>();
      final icon = '$url/${m['icon']}.png';
      return ImportItem(m['id'].toString(), m['name'], icon, levels.max() ?? 0);
    }).toList();
  }

  @override
  Future<GsArtifact> fetchArtifact(String id, [GsArtifact? other]) async {
    final data = await _fetchPage('reliquary/$id');
    final level = data.getIntList('levelList').max() ?? 0;

    final pieces = (data['suit'] as JsonMap).entries.map((item) {
      final data = item.value as JsonMap;
      final type = switch (item.key) {
        'EQUIP_BRACER' => GeArtifactPieceType.flowerOfLife,
        'EQUIP_NECKLACE' => GeArtifactPieceType.plumeOfDeath,
        'EQUIP_SHOES' => GeArtifactPieceType.sandsOfEon,
        'EQUIP_RING' => GeArtifactPieceType.gobletOfEonothem,
        'EQUIP_DRESS' => GeArtifactPieceType.circletOfLogos,
        _ => GeArtifactPieceType.flowerOfLife,
      };

      final fall = other?.pieces.firstOrNullWhere((e) => e.id == id);

      return GsArtifactPiece(
        id: type.id,
        type: type,
        name: data.getString('name'),
        icon: fall?.icon ?? '',
        desc: data.getString('description'),
      );
    }).toList();

    final affixes = data['affixList'] as JsonMap;
    final effects = affixes.entries
        .sortedBy((entry) => entry.key)
        .map((e) => e.value.toString());

    final name = data.getString('name');
    return GsArtifact(
      id: name.toDbId(),
      name: name,
      region: other?.region ?? GeRegionType.none,
      version: other?.version ?? '',
      rarity: level,
      pc1: effects.length == 1 ? effects.first : '',
      pc2: effects.length == 2 ? effects.first : '',
      pc4: effects.length == 2 ? effects.second : '',
      domain: other?.domain ?? '',
      pieces: pieces,
    );
  }

  @override
  Future<List<ImportItem>> fetchCharacters() async {
    const url = '$_kBaseUrl/assets/UI';
    final data = await _fetchPage('avatar');
    final items = data['items'] as Map<String, dynamic>;

    return items.values.cast<JsonMap>().map((m) {
      final icon = '$url/${m['icon']}.png';
      return ImportItem(
        m['id'].toString(),
        m.getString('name'),
        icon,
        m.getInt('rank'),
      );
    }).toList();
  }

  @override
  Future<GsCharacter> fetchCharacter(String id, [GsCharacter? other]) async {
    final data = await _fetchPage('avatar/$id');
    final name = data.getString('name');

    final fetter = data.getJsonMap('fetter');
    final info = data.getJsonMap('other');

    final props = [
      'FIGHT_PROP_BASE_HP',
      'FIGHT_PROP_BASE_DEFENSE',
      'FIGHT_PROP_BASE_ATTACK',
    ];
    final prop = data
        .getJsonMap('upgrade')
        .getJsonMapList('promote')
        .expand((e) => e.getJsonMap('addProps').keys)
        .toSet()
        .firstWhere((e) => !props.contains(e));

    final element = switch (data.getString('element')) {
      'Wind' => GeElementType.anemo,
      'Rock' => GeElementType.geo,
      'Electric' => GeElementType.electro,
      'Grass' => GeElementType.dendro,
      'Water' => GeElementType.hydro,
      'Fire' => GeElementType.pyro,
      'Ice' => GeElementType.cryo,
      _ => GeElementType.none,
    };
    final weapon = switch (data.getString('weaponType')) {
      'WEAPON_SWORD_ONE_HAND' => GeWeaponType.sword,
      'WEAPON_CATALYST' => GeWeaponType.catalyst,
      'WEAPON_CLAYMORE' => GeWeaponType.claymore,
      'WEAPON_BOW' => GeWeaponType.bow,
      'WEAPON_POLE' => GeWeaponType.polearm,
      _ => GeWeaponType.none,
    };
    final region = switch (data.getString('region')) {
      'MONDSTADT' => GeRegionType.mondstadt,
      'LIYUE' => GeRegionType.liyue,
      'INAZUMA' => GeRegionType.inazuma,
      'SUMERU' => GeRegionType.sumeru,
      'FONTAINE' => GeRegionType.fontaine,
      'NATLAN' => GeRegionType.natlan,
      'FATUI' => GeRegionType.snezhnaya,
      'RANGER' => GeRegionType.none,
      'MAINACTOR' => GeRegionType.none,
      _ => GeRegionType.none,
    };
    final ascStat = switch (prop) {
      'FIGHT_PROP_CRITICAL_HURT' => GeCharacterAscStatType.critDmg,
      'FIGHT_PROP_HEAL_ADD' => GeCharacterAscStatType.healing,
      'FIGHT_PROP_ATTACK_PERCENT' => GeCharacterAscStatType.atkPercent,
      'FIGHT_PROP_ELEMENT_MASTERY' => GeCharacterAscStatType.elementalMastery,
      'FIGHT_PROP_HP_PERCENT' => GeCharacterAscStatType.hpPercent,
      'FIGHT_PROP_CHARGE_EFFICIENCY' => GeCharacterAscStatType.energyRecharge,
      'FIGHT_PROP_CRITICAL' => GeCharacterAscStatType.critRate,
      'FIGHT_PROP_PHYSICAL_ADD_HURT' => GeCharacterAscStatType.physicalDmg,
      'FIGHT_PROP_ELEC_ADD_HURT' => GeCharacterAscStatType.electroDmgBonus,
      'FIGHT_PROP_ROCK_ADD_HURT' => GeCharacterAscStatType.geoDmgBonus,
      'FIGHT_PROP_FIRE_ADD_HURT' => GeCharacterAscStatType.pyroDmgBonus,
      'FIGHT_PROP_WATER_ADD_HURT' => GeCharacterAscStatType.hydroDmgBonus,
      'FIGHT_PROP_DEFENSE_PERCENT' => GeCharacterAscStatType.defPercent,
      'FIGHT_PROP_ICE_ADD_HURT' => GeCharacterAscStatType.cryoDmgBonus,
      'FIGHT_PROP_WIND_ADD_HURT' => GeCharacterAscStatType.anemoDmgBonus,
      'FIGHT_PROP_GRASS_ADD_HURT' => GeCharacterAscStatType.dendroDmgBonus,
      _ => GeCharacterAscStatType.none,
    };

    final ms = data.getInt('release');
    var release = DateTime.fromMillisecondsSinceEpoch(ms * 1000);
    if (other != null && other.releaseDate.year != 0) {
      release = other.releaseDate;
    }

    final t = data.getIntList('birthday');
    final birthday = t.length > 1
        ? DateTime(0, t.first, t.second)
        : DateTime(0, 1, 1);

    final matNames = data
        .getJsonMap('items')
        .values
        .cast<JsonMap>()
        .map((e) => e.getString('name'));
    final mats = Database.i.of<GsMaterial>().items.where(
      (e) => matNames.contains(e.name),
    );

    String getMat(GeMaterialType type) {
      final found = mats
          .where((e) => e.group == type)
          .sortedBy((e) => e.rarity)
          .firstOrNull
          ?.id;
      late final fallback = switch (type) {
        GeMaterialType.none => '',
        GeMaterialType.oculi => '',
        GeMaterialType.ascensionGems => other?.gemMaterial,
        GeMaterialType.forging => '',
        GeMaterialType.furnishing => '',
        GeMaterialType.normalDrops => other?.commonMaterial,
        GeMaterialType.eliteDrops => '',
        GeMaterialType.normalBossDrops => other?.bossMaterial,
        GeMaterialType.weeklyBossDrops => other?.weeklyMaterial,
        GeMaterialType.regionMaterials => other?.regionMaterial,
        GeMaterialType.talentMaterials => other?.talentMaterial,
        GeMaterialType.weaponMaterials => '',
      };
      return found ?? fallback ?? '';
    }

    final curves = await CharacterCurves.instance;

    T getStatValue<T extends num>(String stat) {
      late final value = curves.getStatValue(data, stat, 90);

      double doubleValue() {
        final v = value?.toDouble() ?? 0.0;
        if (stat == 'FIGHT_PROP_ELEMENT_MASTERY') {
          return v.roundToDouble();
        }
        return double.parse((v * 100).toStringAsFixed(1));
      }

      final match = switch (T) {
        const (int) => value?.toInt() ?? 0,
        const (double) => doubleValue(),
        _ => 0,
      };
      return match as T;
    }

    return GsCharacter(
      id: name.toDbId(),
      enkaId: id,
      name: name,
      namecardId: info.getJsonMap('nameCard').getString('name').toDbId(),
      title: fetter.getString('title'),
      rarity: data.getInt('rank'),
      region: region,
      weapon: weapon,
      element: element,
      version: other?.version ?? '',
      source: other?.source ?? GeItemSourceType.none,
      description: fetter.getString('detail'),
      constellation: fetter.getString('constellation'),
      affiliation: fetter.getString('native'),
      specialDish: other != null && other.specialDish.isNotEmpty
          ? other.specialDish
          : info.getJsonMap('specialFood').getString('name').toDbId(),
      birthday: birthday,
      releaseDate: release,
      image: other?.image ?? '',
      fullImage: other?.fullImage ?? '',
      constellationImage: other?.constellationImage ?? '',
      gemMaterial: getMat(GeMaterialType.ascensionGems),
      bossMaterial: getMat(GeMaterialType.normalBossDrops),
      commonMaterial: getMat(GeMaterialType.normalDrops),
      regionMaterial: getMat(GeMaterialType.regionMaterials),
      talentMaterial: getMat(GeMaterialType.talentMaterials),
      weeklyMaterial: getMat(GeMaterialType.weeklyBossDrops),
      ascStatType: ascStat,
      ascHpValue: getStatValue<int>('FIGHT_PROP_BASE_HP'),
      ascAtkValue: getStatValue<int>('FIGHT_PROP_BASE_ATTACK'),
      ascDefValue: getStatValue<int>('FIGHT_PROP_BASE_DEFENSE'),
      ascStatValue: getStatValue<double>(prop),
      talentAConstellation: other?.talentAConstellation ?? 0,
      talentEConstellation: other?.talentEConstellation ?? 0,
      talentQConstellation: other?.talentQConstellation ?? 0,
    );
  }

  @override
  Future<List<ImportItem>> fetchNamecards() async {
    const url = '$_kBaseUrl/assets/UI/namecard';
    final data = await _fetchPage('namecard');
    final items = data['items'] as Map<String, dynamic>;

    return items.values.map((m) {
      return ImportItem(
        m['id'].toString(),
        m['name'],
        '$url/${m['icon']}.png',
        m['rank'],
      );
    }).toList();
  }

  @override
  Future<GsNamecard> fetchNamecard(String id, [GsNamecard? other]) async {
    final data = await _fetchPage('namecard/$id');

    final name = data.getString('name');
    final rank = data.getInt('rank');

    final type = switch (data['type']) {
      'other' => GeNamecardType.none,
      'battlePass' => GeNamecardType.battlepass,
      'bond' => GeNamecardType.character,
      'achievement' => GeNamecardType.achievement,
      'reputation' => GeNamecardType.reputation,
      'event' => GeNamecardType.event,
      _ => GeNamecardType.none,
    };

    return GsNamecard(
      id: name.toDbId(),
      name: name,
      rarity: rank,
      type: type,
      version: other?.version ?? '',
      image: other?.image ?? '',
      fullImage: other?.fullImage ?? '',
      desc: data.getString('description').replaceAll('Namecard style.\n', ''),
    );
  }

  @override
  Future<List<ImportItem>> fetchRecipes() async {
    const url = '$_kBaseUrl/assets/UI';
    final data = await _fetchPage('food');
    final items = data['items'] as Map<String, dynamic>;

    return items.values.map((m) {
      return ImportItem(
        m['id'].toString(),
        m['name'],
        '$url/${m['icon']}.png',
        m['rank'],
      );
    }).toList();
  }

  @override
  Future<GsRecipe> fetchRecipe(String id, [GsRecipe? other]) async {
    final data = await _fetchPage('food/$id');
    final name = data.getString('name');

    final from = RegExp(r'<[^>]*>');
    final recipe = data.getJsonMap('recipe');
    final effectDesc = recipe
        .getJsonMap('effect')
        .values
        .cast<String>()
        .map((e) => e.replaceAll(from, ''))
        .join('\n');

    final effectIcon = recipe.getString('effectIcon');
    final effect = switch (effectIcon) {
      'UI_Buff_Item_Recovery_HpAdd' => GeRecipeEffectType.recoveryHP,
      'UI_Buff_Item_Recovery_Revive' => GeRecipeEffectType.revive,
      'UI_Buff_Item_Recovery_HpAddAll' => GeRecipeEffectType.recoveryHPAll,
      'UI_Buff_Item_Other_SPReduceConsume' =>
        GeRecipeEffectType.staminaReduction,
      'UI_Buff_Item_Atk_CritRate' => GeRecipeEffectType.atkCritBoost,
      'UI_Buff_Item_Def_Add' => GeRecipeEffectType.defBoost,
      'UI_Buff_Item_Other_SPAdd' => GeRecipeEffectType.staminaIncrease,
      'UI_Buff_Item_Atk_Add' => GeRecipeEffectType.atkBoost,
      'UI_Buff_Item_Climate_Heat' => GeRecipeEffectType.none,
      'UI_Buff_Item_SpecialEffect' => GeRecipeEffectType.none,
      _ => GeRecipeEffectType.none,
    };

    final mats = Database.i.of<GsMaterial>().items.where((e) => e.ingredient);

    final input = recipe.getJsonMap('input');
    final ingredients = input.values.cast<JsonMap>().map((e) {
      final name = e.getString('name');
      final amount = e.getInt('count');
      final mat = mats.firstOrNullWhere((m) => m.name == name);
      return GsIngredient(id: mat?.id ?? name.toDbId(), amount: amount);
    }).toList();

    return GsRecipe(
      id: name.toDbId(),
      name: name,
      type: GeRecipeType.none,
      rarity: data.getInt('rank'),
      version: other?.version ?? '',
      image: other?.image ?? '',
      effect: effect,
      desc: data.getString('description'),
      effectDesc: effectDesc,
      baseRecipe: other?.baseRecipe ?? '',
      ingredients: ingredients,
    );
  }

  @override
  Future<List<ImportItem>> fetchWeapons() async {
    const url = '$_kBaseUrl/assets/UI';
    final data = await _fetchPage('weapon');
    final items = data['items'] as Map<String, dynamic>;

    return items.values.map((m) {
      return ImportItem(
        m['id'].toString(),
        m['name'],
        '$url/${m['icon']}.png',
        m['rank'],
      );
    }).toList();
  }

  @override
  Future<GsWeapon> fetchWeapon(String id, [GsWeapon? other]) async {
    final data = await _fetchPage('weapon/$id');
    final name = data.getString('name');

    final type = switch (data.getString('type')) {
      'Bow' => GeWeaponType.bow,
      'Sword' => GeWeaponType.sword,
      'Polearm' => GeWeaponType.polearm,
      'Catalyst' => GeWeaponType.catalyst,
      'Claymore' => GeWeaponType.claymore,
      _ => GeWeaponType.none,
    };

    final prop = data.getString('specialProp');
    final statType = switch (prop) {
      'FIGHT_PROP_ATTACK_PERCENT' => GeWeaponAscStatType.atkPercent,
      'FIGHT_PROP_CRITICAL_HURT' => GeWeaponAscStatType.critDmg,
      'FIGHT_PROP_DEFENSE_PERCENT' => GeWeaponAscStatType.defPercent,
      'FIGHT_PROP_ELEMENT_MASTERY' => GeWeaponAscStatType.elementalMastery,
      'FIGHT_PROP_CHARGE_EFFICIENCY' => GeWeaponAscStatType.energyRecharge,
      'FIGHT_PROP_HP_PERCENT' => GeWeaponAscStatType.hpPercent,
      'FIGHT_PROP_PHYSICAL_ADD_HURT' => GeWeaponAscStatType.physicalDmg,
      'FIGHT_PROP_CRITICAL' => GeWeaponAscStatType.critRate,
      _ => GeWeaponAscStatType.none,
    };

    final items = data
        .getJsonMap('items')
        .values
        .cast<JsonMap>()
        .map((e) => e.getString('name'));

    final mats = Database.i.of<GsMaterial>().items.where(
      (mat) => items.contains(mat.name),
    );

    final matWeapon = mats
        .where((e) => e.group == GeMaterialType.weaponMaterials)
        .sortedBy((e) => e.rarity)
        .firstOrNull
        ?.id;
    final matCommon = mats
        .where((e) => e.group == GeMaterialType.normalDrops)
        .sortedBy((e) => e.rarity)
        .firstOrNull
        ?.id;
    final matElite = mats
        .where((e) => e.group == GeMaterialType.eliteDrops)
        .sortedBy((e) => e.rarity)
        .firstOrNull
        ?.id;

    final effect =
        data.getJsonMap('affix').values.firstOrNull as JsonMap? ?? {};
    final effectName = effect.getString('name');
    final effectDescs = effect.getJsonMap('upgrade').values.cast<String>();

    List<String> findValues(String text) {
      var idx = 0;
      final values = <String>[];
      const tag1 = '<color', tag2 = '>', tag3 = '</color>';
      while (true) {
        final idx1 = text.indexOf(tag1, idx);
        if (idx1 == -1) break;
        final idx2 = text.indexOf(tag2, idx + tag1.length);
        if (idx2 == -1) break;
        final idx3 = text.indexOf(tag3, idx2 + tag2.length);
        if (idx3 == -1) break;
        values.add(text.substring(idx2 + tag2.length, idx3));
        idx = idx3 + tag3.length;
      }
      return values;
    }

    String replaceValues(String text, Map<int, List<String>> values) {
      var idx = 0;
      var ptr = 0;
      var res = '';
      const tag1 = '<color', tag2 = '>', tag3 = '</color>';
      while (true) {
        final idx1 = text.indexOf(tag1, idx);
        if (idx1 == -1) break;
        res += text.substring(idx, idx1);
        final idx2 = text.indexOf(tag2, idx + tag1.length);
        if (idx2 == -1) break;
        final idx3 = text.indexOf(tag3, idx2 + tag2.length);
        if (idx3 == -1) break;
        if (values.containsKey(ptr)) {
          res += '{${values[ptr++]?.join(',')}}';
        }
        idx = idx3 + tag3.length;
      }
      res += text.substring(idx);
      return res;
    }

    final vals = <int, List<String>>{};
    for (final desc in effectDescs) {
      final values = findValues(desc);
      for (var i = 0; i < values.length; ++i) {
        vals[i] ??= <String>[];
        vals[i]!.add(values[i]);
      }
    }

    final effectDesc = effectDescs.isNotEmpty
        ? replaceValues(effectDescs.first, vals)
        : '';

    final rank = data.getInt('rank');

    final curves = await WeaponCurves.instance;
    final l = rank.between(1, 2) ? 70 : 90;
    T getStatValue<T extends num>(String stat) {
      late final value = curves.getStatValue(data, stat, l);

      double doubleValue() {
        final v = value?.toDouble() ?? 0.0;
        if (stat == 'FIGHT_PROP_ELEMENT_MASTERY') {
          return v.roundToDouble();
        }
        return double.parse((v * 100).toStringAsFixed(1));
      }

      final match = switch (T) {
        const (int) => value?.toInt() ?? 0,
        const (double) => doubleValue(),
        _ => 0,
      };
      return match as T;
    }

    return GsWeapon(
      id: name.toDbId(),
      name: name,
      rarity: rank,
      image: other?.image ?? '',
      imageAsc: other?.imageAsc ?? '',
      type: type,
      statType: statType,
      ascAtkValue: getStatValue<int>('FIGHT_PROP_BASE_ATTACK'),
      ascStatValue: getStatValue<double>(prop),
      desc: data.getString('description'),
      version: other?.version ?? '',
      source: other?.source ?? GeItemSourceType.none,
      effectName: effectName,
      effectDesc: effectDesc,
      matWeapon: matWeapon ?? '',
      matCommon: matCommon ?? '',
      matElite: matElite ?? '',
    );
  }

  @override
  Future<List<ImportItem>> fetchSereniteaSets() async {
    const url = '$_kBaseUrl/assets/UI';
    final data = await _fetchPage('furnitureSuite');
    final items = data['items'] as Map<String, dynamic>;

    return items.values
        .cast<JsonMap>()
        .where((e) => e.getList('types').contains('giftSet'))
        .map((e) {
          final id = e.getInt('id').toString();
          final name = e.getString('name');
          final icon = '$url/furnitureSuite/${e.getString('icon')}.png';
          final categories = e.getList('categories');
          final level = switch (categories) {
            _ when categories.contains('indoorSet') => 4,
            _ when categories.contains('outdoorSet') => 5,
            _ => 0,
          };
          return ImportItem(id, name, icon, level);
        })
        .toList();
  }

  @override
  Future<GsSereniteaSet> fetchSereniteaSet(
    String id, [
    GsSereniteaSet? other,
  ]) async {
    final data = await _fetchPage('furnitureSuite/$id');
    final name = data.getStringOrNull('name');
    final categories = data.getList('categories');
    final category = switch (categories) {
      _ when categories.contains('Indoor Set') => GeSereniteaSetType.indoor,
      _ when categories.contains('Outdoor Set') => GeSereniteaSetType.outdoor,
      _ => null,
    };

    return (other ?? GsSereniteaSet.fromJson({})).copyWith(
      id: name?.toDbId(),
      name: name,
      version: null,
      category: category,
      image: null,
      rarity: 4,
      energy: null,
      chars: null,
    );
  }

  @override
  Future<GsFurnitureChest> fetchFurniture(
    String id, [
    GsFurnitureChest? other,
  ]) async {
    final data = await _fetchPage('furniture/$id');
    final name = data.getString('name');
    return GsFurnitureChest(
      id: name.toDbId(),
      name: name,
      type: other?.type ?? GeSereniteaSetType.none,
      image: other?.image ?? '',
      rarity: data.getInt('rank'),
      energy: data.getInt('comfort'),
      region: other?.region ?? GeRegionType.none,
      version: other?.version ?? '',
    );
  }

  @override
  Future<List<ImportItem>> fetchFurnitures() async {
    final data = await _fetchPage('furniture');
    final items = data['items'] as Map<String, dynamic>;
    const url = '$_kBaseUrl/assets/UI';

    return items.values.cast<JsonMap>().map((e) {
      final categories = e.getList<String>('categories');
      final iconName = e.getString('icon');

      final icon = switch (true) {
        _ when categories.contains('companion') => '$url/$iconName.png',
        _ when categories.contains('animal') => '$url/monster/$iconName.png',
        _ => '$url/furniture/$iconName.png',
      };

      final id = e.getInt('id').toString();
      final name = e.getString('route');
      final level = e.getInt('rank');
      return ImportItem(id, name, icon, level);
    }).toList();
  }
}

class CharacterCurves {
  static Completer<CharacterCurves>? _completer;
  static Future<CharacterCurves> get instance async {
    if (_completer == null) {
      _completer = Completer();
      final data = CharacterCurves.fromJson(
        await YattaImporter.i._fetchPage('avatarCurve', isStatic: true),
      );
      _completer!.complete(data);
    }
    return _completer!.future;
  }

  final JsonMap _map;

  CharacterCurves.fromJson(JsonMap json) : _map = json;

  String getStatValues(JsonMap data, String statType) {
    final values = <(String, String)>[];
    const levels = [1, 20, 40, 50, 60, 70, 80, 90];

    const flatStats = [
      'FIGHT_PROP_BASE_HP',
      'FIGHT_PROP_BASE_ATTACK',
      'FIGHT_PROP_BASE_DEFENSE',
      'FIGHT_PROP_ELEMENT_MASTERY',
    ];
    final format = !flatStats.contains(statType)
        ? (double e) => '${(e * 100).toStringAsFixed(1)}%'
        : (double e) => '${e.round()}';

    for (final level in levels) {
      final a = getStatValue(data, statType, level);
      final b = getStatValue(data, statType, level, ascended: true);
      if (a == null || b == null) return '';
      values.add((format(a), format(b)));
    }
    return values
        .map((i) => i.$1 == i.$2 ? i.$1 : '${i.$1} → ${i.$2}')
        .join(', ');
  }

  double? getStatValue(
    JsonMap data,
    String statType,
    int level, {
    bool ascended = false,
  }) {
    if (level < 1 || level > 90) return null;

    late final upgrade = data.getJsonMap('upgrade');
    late final baseStats = upgrade.getJsonMapList('prop');
    late final stat = baseStats.firstOrNullWhere(
      (e) => e.getString('propType') == statType,
    );
    final initValue = switch (statType) {
      'FIGHT_PROP_CRITICAL_HURT' => 0.5,
      'FIGHT_PROP_CRITICAL' => 0.05,
      _ => stat?['initValue'] ?? 0.0,
    };

    if (initValue == null) return null;
    final promotes = upgrade.getJsonMapList('promote');
    final promo =
        promotes.firstOrNullWhere(
          (e) => ascended
              ? (e['unlockMaxLevel'] ?? 0) > level
              : (e['unlockMaxLevel'] ?? 0) >= level,
        ) ??
        promotes.lastOrNull;

    final curve = _map['$level']?['curveInfos']?[stat?['type']] as num?;
    final addStat = promo
        ?.getJsonMap('addProps')
        .entries
        .firstOrNullWhere((e) => e.key == statType);
    return initValue * (curve ?? 1) + (addStat?.value ?? 0);
  }
}

class WeaponCurves {
  static Completer<WeaponCurves>? _completer;
  static Future<WeaponCurves> get instance async {
    if (_completer == null) {
      _completer = Completer();
      final data = WeaponCurves.fromJson(
        await YattaImporter.i._fetchPage('weaponCurve', isStatic: true),
      );
      _completer!.complete(data);
    }
    return _completer!.future;
  }

  final JsonMap _map;

  WeaponCurves.fromJson(JsonMap json) : _map = json;

  String getStatValues(JsonMap data, String statType) {
    final values = <(String, String)>[];
    final levels = switch (data.getInt('rank')) {
      >= 1 && <= 2 => [1, 20, 40, 50, 60, 70],
      >= 3 && <= 5 => [1, 20, 40, 50, 60, 70, 80, 90],
      _ => [],
    };

    const flatStats = ['FIGHT_PROP_BASE_ATTACK', 'FIGHT_PROP_ELEMENT_MASTERY'];
    final format = !flatStats.contains(statType)
        ? (double e) => '${(e * 100).toStringAsFixed(1)}%'
        : (double e) => '${e.round()}';

    for (final level in levels) {
      final a = getStatValue(data, statType, level);
      final b = getStatValue(data, statType, level, ascended: true);
      if (a == null || b == null) return '';
      values.add((format(a), format(b)));
    }
    return values
        .map((i) => i.$1 == i.$2 ? i.$1 : '${i.$1} → ${i.$2}')
        .join(', ');
  }

  double? getStatValue(
    JsonMap data,
    String statType,
    int level, {
    bool ascended = false,
  }) {
    if (level < 1 || level > 90) return null;

    late final upgrade = data.getJsonMap('upgrade');
    late final props = upgrade.getJsonMapList('prop');
    late final stat = props.firstOrNullWhere((e) => e['propType'] == statType);
    final initValue = stat?['initValue'];

    if (initValue == null) return null;
    late final promotes = upgrade.getJsonMapList('promote');
    final promo =
        promotes.firstOrNullWhere(
          (e) => ascended
              ? (e['unlockMaxLevel'] ?? 0) > level
              : (e['unlockMaxLevel'] ?? 0) >= level,
        ) ??
        promotes.lastOrNull;

    final curve = _map['$level']?['curveInfos']?[stat?['type']] as num?;
    final addStat = promo
        ?.getJsonMap('addProps')
        .entries
        .firstOrNullWhere((e) => e.key == statType);
    return initValue * (curve ?? 1) + (addStat?.value ?? 0);
  }
}
