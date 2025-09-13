// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_weapon.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GsWeapon extends _GsWeapon {
  @override
  final String id;
  @override
  final String name;
  @override
  final int rarity;
  @override
  final String image;
  @override
  final String imageAsc;
  @override
  final GeWeaponType type;
  @override
  final GeWeaponAscStatType statType;
  @override
  final String desc;
  @override
  final String version;
  @override
  final GeItemSourceType source;
  @override
  final String effectName;
  @override
  final String effectDesc;
  @override
  final String matWeapon;
  @override
  final String matCommon;
  @override
  final String matElite;
  @override
  final int ascAtkValue;
  @override
  final double ascStatValue;

  /// Creates a new [GsWeapon] instance.
  GsWeapon({
    required this.id,
    required this.name,
    required this.rarity,
    required this.image,
    required this.imageAsc,
    required this.type,
    required this.statType,
    required this.desc,
    required this.version,
    required this.source,
    required this.effectName,
    required this.effectDesc,
    required this.matWeapon,
    required this.matCommon,
    required this.matElite,
    required this.ascAtkValue,
    required this.ascStatValue,
  });

  /// Creates a new [GsWeapon] instance from the given map.
  GsWeapon.fromJson(JsonMap m)
    : id = m['id'] as String? ?? '',
      name = m['name'] as String? ?? '',
      rarity = m['rarity'] as int? ?? 0,
      image = m['image'] as String? ?? '',
      imageAsc = m['image_asc'] as String? ?? '',
      type = GeWeaponType.values.fromId(m['type']),
      statType = GeWeaponAscStatType.values.fromId(m['stat_type']),
      desc = m['desc'] as String? ?? '',
      version = m['version'] as String? ?? '',
      source = GeItemSourceType.values.fromId(m['source']),
      effectName = m['effect_name'] as String? ?? '',
      effectDesc = m['effect_desc'] as String? ?? '',
      matWeapon = m['mat_weapon'] as String? ?? '',
      matCommon = m['mat_common'] as String? ?? '',
      matElite = m['mat_elite'] as String? ?? '',
      ascAtkValue = m['asc_atk_value'] as int? ?? 0,
      ascStatValue = m['asc_stat_value'] as double? ?? 0;

  /// Copies this model with the given parameters.
  @override
  GsWeapon copyWith({
    String? id,
    String? name,
    int? rarity,
    String? image,
    String? imageAsc,
    GeWeaponType? type,
    GeWeaponAscStatType? statType,
    String? desc,
    String? version,
    GeItemSourceType? source,
    String? effectName,
    String? effectDesc,
    String? matWeapon,
    String? matCommon,
    String? matElite,
    int? ascAtkValue,
    double? ascStatValue,
  }) {
    return GsWeapon(
      id: id ?? this.id,
      name: name ?? this.name,
      rarity: rarity ?? this.rarity,
      image: image ?? this.image,
      imageAsc: imageAsc ?? this.imageAsc,
      type: type ?? this.type,
      statType: statType ?? this.statType,
      desc: desc ?? this.desc,
      version: version ?? this.version,
      source: source ?? this.source,
      effectName: effectName ?? this.effectName,
      effectDesc: effectDesc ?? this.effectDesc,
      matWeapon: matWeapon ?? this.matWeapon,
      matCommon: matCommon ?? this.matCommon,
      matElite: matElite ?? this.matElite,
      ascAtkValue: ascAtkValue ?? this.ascAtkValue,
      ascStatValue: ascStatValue ?? this.ascStatValue,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'rarity': rarity,
      'image': image,
      'image_asc': imageAsc,
      'type': type.id,
      'stat_type': statType.id,
      'desc': desc,
      'version': version,
      'source': source.id,
      'effect_name': effectName,
      'effect_desc': effectDesc,
      'mat_weapon': matWeapon,
      'mat_common': matCommon,
      'mat_elite': matElite,
      'asc_atk_value': ascAtkValue,
      'asc_stat_value': ascStatValue,
    };
  }
}
