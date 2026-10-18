// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_material.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsMaterialCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsMaterial(...).copyWith(id: 12, name: "My name")
  /// ```
  GsMaterial call({
    String id,
    String version,
    String name,
    String desc,
    int rarity,
    GeMaterialType group,
    String image,
    GeRegionType region,
    int subgroup,
    bool ingredient,
    List<GeWeekdayType> weekdays,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsMaterial.copyWith(...)`.
class _$GsMaterialCWProxyImpl implements _$GsMaterialCWProxy {
  const _$GsMaterialCWProxyImpl(this._value);

  final GsMaterial _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsMaterial(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsMaterial call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? desc = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? group = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? region = const $CopyWithPlaceholder(),
    Object? subgroup = const $CopyWithPlaceholder(),
    Object? ingredient = const $CopyWithPlaceholder(),
    Object? weekdays = const $CopyWithPlaceholder(),
  }) {
    return GsMaterial(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      version: version == const $CopyWithPlaceholder() || version == null
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      desc: desc == const $CopyWithPlaceholder() || desc == null
          ? _value.desc
          // ignore: cast_nullable_to_non_nullable
          : desc as String,
      rarity: rarity == const $CopyWithPlaceholder() || rarity == null
          ? _value.rarity
          // ignore: cast_nullable_to_non_nullable
          : rarity as int,
      group: group == const $CopyWithPlaceholder() || group == null
          ? _value.group
          // ignore: cast_nullable_to_non_nullable
          : group as GeMaterialType,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      region: region == const $CopyWithPlaceholder() || region == null
          ? _value.region
          // ignore: cast_nullable_to_non_nullable
          : region as GeRegionType,
      subgroup: subgroup == const $CopyWithPlaceholder() || subgroup == null
          ? _value.subgroup
          // ignore: cast_nullable_to_non_nullable
          : subgroup as int,
      ingredient:
          ingredient == const $CopyWithPlaceholder() || ingredient == null
          ? _value.ingredient
          // ignore: cast_nullable_to_non_nullable
          : ingredient as bool,
      weekdays: weekdays == const $CopyWithPlaceholder() || weekdays == null
          ? _value.weekdays
          // ignore: cast_nullable_to_non_nullable
          : weekdays as List<GeWeekdayType>,
    );
  }
}

extension $GsMaterialCopyWith on GsMaterial {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsMaterial.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsMaterialCWProxy get copyWith => _$GsMaterialCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsMaterial _$GsMaterialFromJson(Map<String, dynamic> json) => GsMaterial(
  id: json['id'] as String? ?? '',
  version: json['version'] as String? ?? '',
  name: json['name'] as String? ?? '',
  desc: json['desc'] as String? ?? '',
  rarity: (json['rarity'] as num?)?.toInt() ?? 0,
  group:
      $enumDecodeNullable(
        _$GeMaterialTypeEnumMap,
        json['group'],
        unknownValue: GeMaterialType.none,
      ) ??
      GeMaterialType.none,
  image: json['image'] as String? ?? '',
  region:
      $enumDecodeNullable(
        _$GeRegionTypeEnumMap,
        json['region'],
        unknownValue: GeRegionType.none,
      ) ??
      GeRegionType.none,
  subgroup: (json['subgroup'] as num?)?.toInt() ?? 0,
  ingredient: json['ingredient'] as bool? ?? false,
  weekdays:
      (json['weekdays'] as List<dynamic>?)
          ?.map(
            (e) => $enumDecode(
              _$GeWeekdayTypeEnumMap,
              e,
              unknownValue: GeWeekdayType.sunday,
            ),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$GsMaterialToJson(
  GsMaterial instance,
) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'name': instance.name,
  'desc': instance.desc,
  'rarity': instance.rarity,
  'group': _$GeMaterialTypeEnumMap[instance.group]!,
  'image': instance.image,
  'region': _$GeRegionTypeEnumMap[instance.region]!,
  'subgroup': instance.subgroup,
  'ingredient': instance.ingredient,
  'weekdays': instance.weekdays.map((e) => _$GeWeekdayTypeEnumMap[e]!).toList(),
};

const _$GeMaterialTypeEnumMap = {
  GeMaterialType.none: 'none',
  GeMaterialType.oculi: 'oculi',
  GeMaterialType.ascensionGems: 'ascension_gems',
  GeMaterialType.forging: 'forging',
  GeMaterialType.furnishing: 'furnishing',
  GeMaterialType.normalDrops: 'normal_drops',
  GeMaterialType.eliteDrops: 'elite_drops',
  GeMaterialType.normalBossDrops: 'normal_boss_drops',
  GeMaterialType.weeklyBossDrops: 'weekly_boss_drops',
  GeMaterialType.regionMaterials: 'region_materials',
  GeMaterialType.talentMaterials: 'talent_materials',
  GeMaterialType.weaponMaterials: 'weapon_materials',
};

const _$GeRegionTypeEnumMap = {
  GeRegionType.none: 'none',
  GeRegionType.mondstadt: 'mondstadt',
  GeRegionType.liyue: 'liyue',
  GeRegionType.inazuma: 'inazuma',
  GeRegionType.sumeru: 'sumeru',
  GeRegionType.fontaine: 'fontaine',
  GeRegionType.natlan: 'natlan',
  GeRegionType.nodkrai: 'nodkrai',
  GeRegionType.snezhnaya: 'snezhnaya',
};

const _$GeWeekdayTypeEnumMap = {
  GeWeekdayType.sunday: 'Sunday',
  GeWeekdayType.monday: 'Monday',
  GeWeekdayType.tuesday: 'Tuesday',
  GeWeekdayType.wednesday: 'Wednesday',
  GeWeekdayType.thursday: 'Thursday',
  GeWeekdayType.friday: 'Friday',
  GeWeekdayType.saturday: 'Saturday',
};
