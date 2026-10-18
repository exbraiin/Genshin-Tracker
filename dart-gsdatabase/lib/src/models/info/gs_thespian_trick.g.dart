// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_thespian_trick.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsThespianTrickCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsThespianTrick(...).copyWith(id: 12, name: "My name")
  /// ```
  GsThespianTrick call({
    String id,
    String version,
    String name,
    int rarity,
    int season,
    String character,
    String image,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsThespianTrick.copyWith(...)`.
class _$GsThespianTrickCWProxyImpl implements _$GsThespianTrickCWProxy {
  const _$GsThespianTrickCWProxyImpl(this._value);

  final GsThespianTrick _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsThespianTrick(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsThespianTrick call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? season = const $CopyWithPlaceholder(),
    Object? character = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
  }) {
    return GsThespianTrick(
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
      season: season == const $CopyWithPlaceholder() || season == null
          ? _value.season
          // ignore: cast_nullable_to_non_nullable
          : season as int,
      character: character == const $CopyWithPlaceholder() || character == null
          ? _value.character
          // ignore: cast_nullable_to_non_nullable
          : character as String,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
    );
  }
}

extension $GsThespianTrickCopyWith on GsThespianTrick {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsThespianTrick.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsThespianTrickCWProxy get copyWith => _$GsThespianTrickCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsThespianTrick _$GsThespianTrickFromJson(Map<String, dynamic> json) =>
    GsThespianTrick(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      name: json['name'] as String? ?? '',
      rarity: (json['rarity'] as num?)?.toInt() ?? 0,
      season: (json['season'] as num?)?.toInt() ?? 0,
      character: json['character'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$GsThespianTrickToJson(GsThespianTrick instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'rarity': instance.rarity,
      'season': instance.season,
      'character': instance.character,
      'image': instance.image,
    };
