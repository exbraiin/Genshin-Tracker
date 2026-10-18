// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_namecard.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsNamecardCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsNamecard(...).copyWith(id: 12, name: "My name")
  /// ```
  GsNamecard call({
    String id,
    String version,
    String name,
    int rarity,
    GeNamecardType type,
    String image,
    String fullImage,
    String desc,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsNamecard.copyWith(...)`.
class _$GsNamecardCWProxyImpl implements _$GsNamecardCWProxy {
  const _$GsNamecardCWProxyImpl(this._value);

  final GsNamecard _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsNamecard(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsNamecard call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? fullImage = const $CopyWithPlaceholder(),
    Object? desc = const $CopyWithPlaceholder(),
  }) {
    return GsNamecard(
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
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeNamecardType,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      fullImage: fullImage == const $CopyWithPlaceholder() || fullImage == null
          ? _value.fullImage
          // ignore: cast_nullable_to_non_nullable
          : fullImage as String,
      desc: desc == const $CopyWithPlaceholder() || desc == null
          ? _value.desc
          // ignore: cast_nullable_to_non_nullable
          : desc as String,
    );
  }
}

extension $GsNamecardCopyWith on GsNamecard {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsNamecard.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsNamecardCWProxy get copyWith => _$GsNamecardCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsNamecard _$GsNamecardFromJson(Map<String, dynamic> json) => GsNamecard(
  id: json['id'] as String? ?? '',
  version: json['version'] as String? ?? '',
  name: json['name'] as String? ?? '',
  rarity: (json['rarity'] as num?)?.toInt() ?? 0,
  type:
      $enumDecodeNullable(
        _$GeNamecardTypeEnumMap,
        json['type'],
        unknownValue: GeNamecardType.none,
      ) ??
      GeNamecardType.none,
  image: json['image'] as String? ?? '',
  fullImage: json['fullImage'] as String? ?? '',
  desc: json['desc'] as String? ?? '',
);

Map<String, dynamic> _$GsNamecardToJson(GsNamecard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'rarity': instance.rarity,
      'type': _$GeNamecardTypeEnumMap[instance.type]!,
      'image': instance.image,
      'fullImage': instance.fullImage,
      'desc': instance.desc,
    };

const _$GeNamecardTypeEnumMap = {
  GeNamecardType.none: 'none',
  GeNamecardType.achievement: 'achievement',
  GeNamecardType.battlepass: 'battlepass',
  GeNamecardType.character: 'character',
  GeNamecardType.defaults: 'default',
  GeNamecardType.event: 'event',
  GeNamecardType.offering: 'offering',
  GeNamecardType.reputation: 'reputation',
};
