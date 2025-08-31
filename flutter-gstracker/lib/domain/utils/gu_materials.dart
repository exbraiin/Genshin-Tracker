import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/src/iterable_ext.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/utils/gs_collections.dart';

final class GuMaterials {
  final GuCollections _items;
  const GuMaterials(this._items);

  Iterable<GsMaterial> getGroupMaterials(GsMaterial material) {
    return _items.inMaterials.items
        .where((element) {
          return element.group == material.group &&
              element.region == material.region &&
              element.subgroup == material.subgroup;
        })
        .sortedBy((element) => element.rarity);
  }

  Iterable<GsMaterial> getGroupMaterialsById(String id) {
    final material = _items.inMaterials.getItem(id);
    if (material == null) return [];
    return getGroupMaterials(material);
  }

  /// Gets the character missing ascension materials
  Map<GsMaterial, int> getCharAscensionMissing(
    GsCharacter info,
    GiCharacter save, [
    int maxAscension = 6,
  ]) {
    final list = <(GsMaterial, int)>[];

    final ascension = save.ascension.clamp(0, 6);
    for (var i = ascension + 1; i <= maxAscension; ++i) {
      final items = getCharAscension(info, i);
      list.addAll(items.entries.map((e) => (e.key, e.value)));
    }

    return list
        .groupBy((e) => e.$1.id)
        .values
        .toMap((e) => e.first.$1, (e) => e.sumBy((n) => n.$2));
  }

  /// Gets the character missing talent materials
  Map<GsMaterial, int> getCharTalentsMissing(
    GsCharacter info,
    GiCharacter save, [
    int maxTalent = 10,
  ]) {
    final list = <(GsMaterial, int)>[];

    const kMaxTalLevel = 10;
    void sumTalMaterials(int talent) {
      final tal = talent.clamp(0, kMaxTalLevel) + 1;
      for (var i = tal; i <= maxTalent; ++i) {
        final items = getCharTalent(info, i);
        list.addAll(items.entries.map((e) => (e.key, e.value)));
      }
    }

    sumTalMaterials(save.talent1);
    sumTalMaterials(save.talent2);
    sumTalMaterials(save.talent3);

    return list
        .groupBy((e) => e.$1.id)
        .values
        .toMap((e) => e.first.$1, (e) => e.sumBy((n) => n.$2));
  }

  /// Gets the character missing ascension and talent materials
  Map<GsMaterial, int> getAllCharMissing(
    GsCharacter info,
    GiCharacter save, {
    int maxTalent = 10,
    int maxAscension = 6,
  }) {
    final list = [
      ...getCharAscensionMissing(info, save, maxAscension).entries,
      ...getCharTalentsMissing(info, save, maxTalent).entries,
    ];

    return list
        .groupBy((e) => e.key.id)
        .values
        .toMap((e) => e.first.key, (e) => e.sumBy((n) => n.value));
  }

  /// Gets all weapon ascension materials at level.
  Map<GsMaterial, int> getWeaponAscensionById(String id, [int? level]) {
    final info = _items.inWeapons.getItem(id);
    if (info == null) return const {};
    return getWeaponAscension(info, level);
  }

  /// Gets all weapon ascension materials at level.
  Map<GsMaterial, int> getWeaponAscension(GsWeapon info, [int? level]) {
    return _getMaterials<WeaponAsc>(
      WeaponAsc.values[info.rarity - 1],
      {
        'mora': (i) => i.moraAmount,
        info.matElite: (i) => i.eliteAmount,
        info.matCommon: (i) => i.commonAmount,
        info.matWeapon: (i) => i.weaponAmount,
      },
      {
        info.matElite: (i) => i.eliteIndex,
        info.matCommon: (i) => i.commonIndex,
        info.matWeapon: (i) => i.weaponIndex,
      },
      level,
    );
  }

  /// Gets all character ascension materials at level.
  /// * Level should be null or between [2, 10]
  Map<GsMaterial, int> getCharAscensionById(String id, [int? level]) {
    final info = _items.inCharacters.getItem(id);
    if (info == null) return const {};
    return getCharAscension(info, level);
  }

  /// Gets all character ascension materials at level.
  /// * Level should be null or between [2, 10]
  Map<GsMaterial, int> getCharAscension(GsCharacter info, [int? level]) {
    return _getMaterials<CharacterAsc>(
      CharacterAsc.values,
      {
        'mora': (i) => i.moraAmount,
        info.gemMaterial: (i) => i.gemAmount,
        info.bossMaterial: (i) => i.bossAmount,
        info.regionMaterial: (i) => i.regionAmount,
        info.commonMaterial: (i) => i.commonAmount,
      },
      {
        info.gemMaterial: (i) => i.gemIndex,
        info.commonMaterial: (i) => i.commonIndex,
      },
      level,
    );
  }

  /// Gets all character talent materials.
  /// * Returns materials for all 3 talents.
  Map<GsMaterial, int> getAllCharTalentsById(String id) {
    final info = _items.inCharacters.getItem(id);
    if (info == null) return const {};
    return getCharTalent(info).map((k, v) => MapEntry(k, v * 3));
  }

  /// Gets all character talent materials.
  /// * Returns materials for all 3 talents.
  Map<GsMaterial, int> getAllCharTalents(GsCharacter info) {
    return getCharTalent(info).map((k, v) => MapEntry(k, v * 3));
  }

  /// Gets all character talent materials at level.
  /// * Level should be null or between [2, 10]
  Map<GsMaterial, int> getCharTalentById(String id, [int? level]) {
    final info = _items.inCharacters.getItem(id);
    if (info == null) return const {};
    return getCharTalent(info, level);
  }

  /// Gets all character talent materials at level.
  /// * Level should be null or between [2, 10]
  Map<GsMaterial, int> getCharTalent(GsCharacter info, [int? level]) {
    if (level != null) level -= 2;

    return _getMaterials<CharacterTal>(
      CharacterTal.values,
      {
        'mora': (i) => i.moraAmount,
        'crown_of_insight': (i) => i.crownAmount,
        info.commonMaterial: (i) => i.commonAmount,
        info.talentMaterial: (i) => i.talentAmount,
        info.weeklyMaterial: (i) => i.weeklyAmount,
      },
      {
        info.commonMaterial: (i) => i.commonIndex,
        info.talentMaterial: (i) => i.talentIndex,
      },
      level,
    );
  }

  Map<GsMaterial, int> _getMaterials<T extends _MatValues>(
    List<T> items,
    Map<String, int Function(T i)> amounts,
    Map<String, int Function(T i)> indexes, [
    int? level,
  ]) {
    if (level != null) {
      final temp = items.elementAtOrNull(level);
      items = temp != null ? [temp] : [];
    }

    final listMats = amounts.keys.map(
      (k) => (key: k, value: getGroupMaterialsById(k)),
    );

    final total = <String, int>{};
    for (final item in items) {
      for (final entry in listMats) {
        final index = indexes[entry.key]?.call(item) ?? 0;
        final material =
            index == 0
                ? entry.value.firstOrNullWhere((e) => e.id == entry.key)
                : entry.value.elementAtOrNull(index);
        if (material == null) continue;
        final amount = amounts[entry.key]?.call(item) ?? 0;
        total[material.id] = (total[material.id] ?? 0) + amount;
      }
    }

    return total.entries
        .map((e) => (_items.inMaterials.getItem(e.key), e.value))
        .where((e) => e.$1 != null && e.$2 > 0)
        .toMap((e) => e.$1!, (e) => e.$2);
  }
}

extension GsMaterialExt on GsMaterial {
  bool get isFarmableToday {
    final today = GeWeekdayType.values.today;
    return today == GeWeekdayType.sunday ||
        weekdays.isEmpty ||
        weekdays.contains(today);
  }
}

abstract class _MatValues {}

class CharacterAsc implements _MatValues {
  static const values = [
    CharacterAsc(1, 0, 0, 0, 0, 0, 0, 0),
    CharacterAsc(20, 1, 0, 3, 3, 20000, 0, 0),
    CharacterAsc(40, 3, 2, 15, 10, 40000, 1, 0),
    CharacterAsc(50, 6, 4, 12, 20, 60000, 1, 1),
    CharacterAsc(60, 3, 8, 18, 30, 80000, 2, 1),
    CharacterAsc(70, 6, 12, 12, 45, 100000, 2, 2),
    CharacterAsc(80, 6, 20, 24, 60, 120000, 3, 2),
    CharacterAsc(90, 0, 0, 0, 0, 0, 0, 0),
  ];

  final int level;
  final int gemAmount;
  final int bossAmount;
  final int commonAmount;
  final int regionAmount;
  final int moraAmount;

  final int gemIndex;
  final int commonIndex;

  const CharacterAsc(
    this.level,
    this.gemAmount,
    this.bossAmount,
    this.commonAmount,
    this.regionAmount,
    this.moraAmount,
    this.gemIndex,
    this.commonIndex,
  );
}

class CharacterTal implements _MatValues {
  static const values = [
    CharacterTal(0, 6, 3, 0, 0, 12500, 0, 0),
    CharacterTal(0, 3, 2, 0, 0, 17500, 1, 1),
    CharacterTal(0, 4, 4, 0, 0, 25000, 1, 1),
    CharacterTal(0, 6, 6, 0, 0, 30000, 1, 1),
    CharacterTal(0, 9, 9, 0, 0, 37500, 1, 1),
    CharacterTal(0, 4, 4, 1, 0, 120000, 2, 2),
    CharacterTal(0, 6, 6, 1, 0, 260000, 2, 2),
    CharacterTal(0, 9, 12, 2, 0, 450000, 2, 2),
    CharacterTal(0, 12, 16, 2, 1, 700000, 2, 2),
  ];

  final int level;
  final int commonAmount;
  final int talentAmount;
  final int weeklyAmount;
  final int crownAmount;
  final int moraAmount;

  final int commonIndex;
  final int talentIndex;

  const CharacterTal(
    this.level,
    this.commonAmount,
    this.talentAmount,
    this.weeklyAmount,
    this.crownAmount,
    this.moraAmount,
    this.commonIndex,
    this.talentIndex,
  );
}

class WeaponAsc implements _MatValues {
  static const values = [
    [
      WeaponAsc(1, 0, 0, 0, 0, 0, 0, 0),
      WeaponAsc(20, 0, 1, 1, 1, 0, 0, 0),
      WeaponAsc(40, 5000, 2, 4, 1, 0, 0, 1),
      WeaponAsc(50, 5000, 2, 2, 2, 1, 1, 1),
      WeaponAsc(60, 10000, 3, 4, 1, 1, 1, 2),
      WeaponAsc(70, 0, 0, 0, 0, 0, 0, 0),
    ],
    [
      WeaponAsc(1, 0, 0, 0, 0, 0, 0, 0),
      WeaponAsc(20, 5000, 1, 1, 1, 0, 0, 0),
      WeaponAsc(40, 5000, 4, 5, 1, 0, 0, 1),
      WeaponAsc(50, 10000, 3, 3, 3, 1, 1, 1),
      WeaponAsc(60, 15000, 4, 5, 1, 1, 1, 2),
      WeaponAsc(70, 0, 0, 0, 0, 0, 0, 0),
    ],
    [
      WeaponAsc(1, 0, 0, 0, 0, 0, 0, 0),
      WeaponAsc(20, 5000, 1, 2, 2, 0, 0, 0),
      WeaponAsc(40, 10000, 5, 8, 2, 0, 0, 1),
      WeaponAsc(50, 15000, 4, 4, 4, 1, 1, 1),
      WeaponAsc(60, 20000, 6, 8, 2, 1, 1, 2),
      WeaponAsc(70, 25000, 4, 6, 4, 2, 2, 2),
      WeaponAsc(80, 30000, 8, 12, 3, 2, 2, 3),
      WeaponAsc(90, 0, 0, 0, 0, 0, 0, 0),
    ],
    [
      WeaponAsc(1, 0, 0, 0, 0, 0, 0, 0),
      WeaponAsc(20, 5000, 2, 3, 3, 0, 0, 0),
      WeaponAsc(40, 15000, 8, 12, 3, 0, 0, 1),
      WeaponAsc(50, 20000, 6, 6, 6, 1, 1, 1),
      WeaponAsc(60, 30000, 9, 12, 3, 1, 1, 2),
      WeaponAsc(70, 35000, 6, 9, 6, 2, 2, 2),
      WeaponAsc(80, 45000, 12, 18, 4, 2, 2, 3),
      WeaponAsc(90, 0, 0, 0, 0, 0, 0, 0),
    ],
    [
      WeaponAsc(1, 0, 0, 0, 0, 0, 0, 0),
      WeaponAsc(20, 10000, 3, 5, 5, 0, 0, 0),
      WeaponAsc(40, 20000, 12, 18, 5, 0, 0, 1),
      WeaponAsc(50, 30000, 9, 9, 9, 1, 1, 1),
      WeaponAsc(60, 45000, 14, 18, 5, 1, 1, 2),
      WeaponAsc(70, 55000, 9, 14, 9, 2, 2, 2),
      WeaponAsc(80, 65000, 18, 27, 6, 2, 2, 3),
      WeaponAsc(90, 0, 0, 0, 0, 0, 0, 0),
    ],
  ];
  final int level;
  final int moraAmount;
  final int commonAmount;
  final int eliteAmount;
  final int weaponAmount;

  final int commonIndex;
  final int eliteIndex;
  final int weaponIndex;

  const WeaponAsc(
    this.level,
    this.moraAmount,
    this.commonAmount,
    this.eliteAmount,
    this.weaponAmount,
    this.eliteIndex,
    this.commonIndex,
    this.weaponIndex,
  );
}
