// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_furniture_chest.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsFurnitureChestCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsFurnitureChest(...).copyWith(id: 12, name: "My name")
  /// ```
  GsFurnitureChest call({
    String id,
    String version,
    String name,
    GeSereniteaSetType type,
    String image,
    int rarity,
    int energy,
    GeRegionType region,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsFurnitureChest.copyWith(...)`.
class _$GsFurnitureChestCWProxyImpl implements _$GsFurnitureChestCWProxy {
  const _$GsFurnitureChestCWProxyImpl(this._value);

  final GsFurnitureChest _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsFurnitureChest(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsFurnitureChest call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? energy = const $CopyWithPlaceholder(),
    Object? region = const $CopyWithPlaceholder(),
  }) {
    return GsFurnitureChest(
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
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeSereniteaSetType,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      rarity: rarity == const $CopyWithPlaceholder() || rarity == null
          ? _value.rarity
          // ignore: cast_nullable_to_non_nullable
          : rarity as int,
      energy: energy == const $CopyWithPlaceholder() || energy == null
          ? _value.energy
          // ignore: cast_nullable_to_non_nullable
          : energy as int,
      region: region == const $CopyWithPlaceholder() || region == null
          ? _value.region
          // ignore: cast_nullable_to_non_nullable
          : region as GeRegionType,
    );
  }
}

extension $GsFurnitureChestCopyWith on GsFurnitureChest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsFurnitureChest.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsFurnitureChestCWProxy get copyWith => _$GsFurnitureChestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsFurnitureChest _$GsFurnitureChestFromJson(Map<String, dynamic> json) =>
    GsFurnitureChest(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      name: json['name'] as String? ?? '',
      type:
          $enumDecodeNullable(
            _$GeSereniteaSetTypeEnumMap,
            json['type'],
            unknownValue: GeSereniteaSetType.none,
          ) ??
          GeSereniteaSetType.none,
      image: json['image'] as String? ?? '',
      rarity: (json['rarity'] as num?)?.toInt() ?? 0,
      energy: (json['energy'] as num?)?.toInt() ?? 0,
      region:
          $enumDecodeNullable(
            _$GeRegionTypeEnumMap,
            json['region'],
            unknownValue: GeRegionType.none,
          ) ??
          GeRegionType.none,
    );

Map<String, dynamic> _$GsFurnitureChestToJson(GsFurnitureChest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'type': _$GeSereniteaSetTypeEnumMap[instance.type]!,
      'image': instance.image,
      'rarity': instance.rarity,
      'energy': instance.energy,
      'region': _$GeRegionTypeEnumMap[instance.region]!,
    };

const _$GeSereniteaSetTypeEnumMap = {
  GeSereniteaSetType.none: 'none',
  GeSereniteaSetType.indoor: 'indoor',
  GeSereniteaSetType.outdoor: 'outdoor',
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
