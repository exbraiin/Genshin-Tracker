// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_weapon.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsWeaponCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsWeapon(...).copyWith(id: 12, name: "My name")
  /// ```
  GsWeapon call({
    String id,
    String version,
    String name,
    int rarity,
    String image,
    String imageAsc,
    GeWeaponType type,
    GeWeaponAscStatType statType,
    String desc,
    GeItemSourceType source,
    String effectName,
    String effectDesc,
    String matWeapon,
    String matCommon,
    String matElite,
    int ascAtkValue,
    double ascStatValue,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsWeapon.copyWith(...)`.
class _$GsWeaponCWProxyImpl implements _$GsWeaponCWProxy {
  const _$GsWeaponCWProxyImpl(this._value);

  final GsWeapon _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsWeapon(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsWeapon call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? imageAsc = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? statType = const $CopyWithPlaceholder(),
    Object? desc = const $CopyWithPlaceholder(),
    Object? source = const $CopyWithPlaceholder(),
    Object? effectName = const $CopyWithPlaceholder(),
    Object? effectDesc = const $CopyWithPlaceholder(),
    Object? matWeapon = const $CopyWithPlaceholder(),
    Object? matCommon = const $CopyWithPlaceholder(),
    Object? matElite = const $CopyWithPlaceholder(),
    Object? ascAtkValue = const $CopyWithPlaceholder(),
    Object? ascStatValue = const $CopyWithPlaceholder(),
  }) {
    return GsWeapon(
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
      rarity: rarity == const $CopyWithPlaceholder() || rarity == null
          ? _value.rarity
          // ignore: cast_nullable_to_non_nullable
          : rarity as int,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      imageAsc: imageAsc == const $CopyWithPlaceholder() || imageAsc == null
          ? _value.imageAsc
          // ignore: cast_nullable_to_non_nullable
          : imageAsc as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeWeaponType,
      statType: statType == const $CopyWithPlaceholder() || statType == null
          ? _value.statType
          // ignore: cast_nullable_to_non_nullable
          : statType as GeWeaponAscStatType,
      desc: desc == const $CopyWithPlaceholder() || desc == null
          ? _value.desc
          // ignore: cast_nullable_to_non_nullable
          : desc as String,
      source: source == const $CopyWithPlaceholder() || source == null
          ? _value.source
          // ignore: cast_nullable_to_non_nullable
          : source as GeItemSourceType,
      effectName:
          effectName == const $CopyWithPlaceholder() || effectName == null
          ? _value.effectName
          // ignore: cast_nullable_to_non_nullable
          : effectName as String,
      effectDesc:
          effectDesc == const $CopyWithPlaceholder() || effectDesc == null
          ? _value.effectDesc
          // ignore: cast_nullable_to_non_nullable
          : effectDesc as String,
      matWeapon: matWeapon == const $CopyWithPlaceholder() || matWeapon == null
          ? _value.matWeapon
          // ignore: cast_nullable_to_non_nullable
          : matWeapon as String,
      matCommon: matCommon == const $CopyWithPlaceholder() || matCommon == null
          ? _value.matCommon
          // ignore: cast_nullable_to_non_nullable
          : matCommon as String,
      matElite: matElite == const $CopyWithPlaceholder() || matElite == null
          ? _value.matElite
          // ignore: cast_nullable_to_non_nullable
          : matElite as String,
      ascAtkValue:
          ascAtkValue == const $CopyWithPlaceholder() || ascAtkValue == null
          ? _value.ascAtkValue
          // ignore: cast_nullable_to_non_nullable
          : ascAtkValue as int,
      ascStatValue:
          ascStatValue == const $CopyWithPlaceholder() || ascStatValue == null
          ? _value.ascStatValue
          // ignore: cast_nullable_to_non_nullable
          : ascStatValue as double,
    );
  }
}

extension $GsWeaponCopyWith on GsWeapon {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsWeapon.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsWeaponCWProxy get copyWith => _$GsWeaponCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsWeapon _$GsWeaponFromJson(Map<String, dynamic> json) => GsWeapon(
  id: json['id'] as String? ?? '',
  version: json['version'] as String? ?? '',
  name: json['name'] as String? ?? '',
  rarity: (json['rarity'] as num?)?.toInt() ?? 0,
  image: json['image'] as String? ?? '',
  imageAsc: json['imageAsc'] as String? ?? '',
  type:
      $enumDecodeNullable(
        _$GeWeaponTypeEnumMap,
        json['type'],
        unknownValue: GeWeaponType.none,
      ) ??
      GeWeaponType.none,
  statType:
      $enumDecodeNullable(
        _$GeWeaponAscStatTypeEnumMap,
        json['statType'],
        unknownValue: GeWeaponAscStatType.none,
      ) ??
      GeWeaponAscStatType.none,
  desc: json['desc'] as String? ?? '',
  source:
      $enumDecodeNullable(
        _$GeItemSourceTypeEnumMap,
        json['source'],
        unknownValue: GeItemSourceType.none,
      ) ??
      GeItemSourceType.none,
  effectName: json['effectName'] as String? ?? '',
  effectDesc: json['effectDesc'] as String? ?? '',
  matWeapon: json['matWeapon'] as String? ?? '',
  matCommon: json['matCommon'] as String? ?? '',
  matElite: json['matElite'] as String? ?? '',
  ascAtkValue: (json['ascAtkValue'] as num?)?.toInt() ?? 0,
  ascStatValue: (json['ascStatValue'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$GsWeaponToJson(GsWeapon instance) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'name': instance.name,
  'rarity': instance.rarity,
  'image': instance.image,
  'imageAsc': instance.imageAsc,
  'type': _$GeWeaponTypeEnumMap[instance.type]!,
  'statType': _$GeWeaponAscStatTypeEnumMap[instance.statType]!,
  'desc': instance.desc,
  'source': _$GeItemSourceTypeEnumMap[instance.source]!,
  'effectName': instance.effectName,
  'effectDesc': instance.effectDesc,
  'matWeapon': instance.matWeapon,
  'matCommon': instance.matCommon,
  'matElite': instance.matElite,
  'ascAtkValue': instance.ascAtkValue,
  'ascStatValue': instance.ascStatValue,
};

const _$GeWeaponTypeEnumMap = {
  GeWeaponType.none: 'none',
  GeWeaponType.bow: 'bow',
  GeWeaponType.sword: 'sword',
  GeWeaponType.polearm: 'polearm',
  GeWeaponType.catalyst: 'catalyst',
  GeWeaponType.claymore: 'claymore',
};

const _$GeWeaponAscStatTypeEnumMap = {
  GeWeaponAscStatType.none: 'none',
  GeWeaponAscStatType.hpPercent: 'hpPercent',
  GeWeaponAscStatType.elementalMastery: 'elementalMastery',
  GeWeaponAscStatType.atkPercent: 'atkPercent',
  GeWeaponAscStatType.critDmg: 'critDmg',
  GeWeaponAscStatType.energyRecharge: 'energyRecharge',
  GeWeaponAscStatType.physicalDmg: 'physicalDmg',
  GeWeaponAscStatType.critRate: 'critRate',
  GeWeaponAscStatType.defPercent: 'defPercent',
};

const _$GeItemSourceTypeEnumMap = {
  GeItemSourceType.none: 'none',
  GeItemSourceType.shop: 'shop',
  GeItemSourceType.event: 'event',
  GeItemSourceType.fishing: 'fishing',
  GeItemSourceType.forging: 'forging',
  GeItemSourceType.battlepass: 'battlepass',
  GeItemSourceType.exploration: 'exploration',
  GeItemSourceType.wishesStandard: 'wishes_standard',
  GeItemSourceType.wishesWeaponBanner: 'wishes_weapon_banner',
  GeItemSourceType.wishesCharacterBanner: 'wishes_character_banner',
};
