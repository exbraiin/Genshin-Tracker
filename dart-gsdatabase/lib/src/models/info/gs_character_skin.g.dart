// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_character_skin.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsCharacterSkinCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsCharacterSkin(...).copyWith(id: 12, name: "My name")
  /// ```
  GsCharacterSkin call({
    String id,
    String version,
    int rarity,
    String name,
    String image,
    String character,
    String sideImage,
    String fullImage,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsCharacterSkin.copyWith(...)`.
class _$GsCharacterSkinCWProxyImpl implements _$GsCharacterSkinCWProxy {
  const _$GsCharacterSkinCWProxyImpl(this._value);

  final GsCharacterSkin _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsCharacterSkin(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsCharacterSkin call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? character = const $CopyWithPlaceholder(),
    Object? sideImage = const $CopyWithPlaceholder(),
    Object? fullImage = const $CopyWithPlaceholder(),
  }) {
    return GsCharacterSkin(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      version: version == const $CopyWithPlaceholder() || version == null
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as String,
      rarity: rarity == const $CopyWithPlaceholder() || rarity == null
          ? _value.rarity
          // ignore: cast_nullable_to_non_nullable
          : rarity as int,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      character: character == const $CopyWithPlaceholder() || character == null
          ? _value.character
          // ignore: cast_nullable_to_non_nullable
          : character as String,
      sideImage: sideImage == const $CopyWithPlaceholder() || sideImage == null
          ? _value.sideImage
          // ignore: cast_nullable_to_non_nullable
          : sideImage as String,
      fullImage: fullImage == const $CopyWithPlaceholder() || fullImage == null
          ? _value.fullImage
          // ignore: cast_nullable_to_non_nullable
          : fullImage as String,
    );
  }
}

extension $GsCharacterSkinCopyWith on GsCharacterSkin {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsCharacterSkin.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsCharacterSkinCWProxy get copyWith => _$GsCharacterSkinCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsCharacterSkin _$GsCharacterSkinFromJson(Map<String, dynamic> json) =>
    GsCharacterSkin(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      rarity: (json['rarity'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      character: json['character'] as String? ?? '',
      sideImage: json['sideImage'] as String? ?? '',
      fullImage: json['fullImage'] as String? ?? '',
    );

Map<String, dynamic> _$GsCharacterSkinToJson(GsCharacterSkin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'rarity': instance.rarity,
      'name': instance.name,
      'image': instance.image,
      'character': instance.character,
      'sideImage': instance.sideImage,
      'fullImage': instance.fullImage,
    };
