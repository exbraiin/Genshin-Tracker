// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_lunar_arcana.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsLunarArcanaCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsLunarArcana(...).copyWith(id: 12, name: "My name")
  /// ```
  GsLunarArcana call({
    String id,
    String version,
    String name,
    int number,
    String image,
    String description,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsLunarArcana.copyWith(...)`.
class _$GsLunarArcanaCWProxyImpl implements _$GsLunarArcanaCWProxy {
  const _$GsLunarArcanaCWProxyImpl(this._value);

  final GsLunarArcana _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsLunarArcana(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsLunarArcana call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
  }) {
    return GsLunarArcana(
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
      number: number == const $CopyWithPlaceholder() || number == null
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as int,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      description:
          description == const $CopyWithPlaceholder() || description == null
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
    );
  }
}

extension $GsLunarArcanaCopyWith on GsLunarArcana {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsLunarArcana.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsLunarArcanaCWProxy get copyWith => _$GsLunarArcanaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsLunarArcana _$GsLunarArcanaFromJson(Map<String, dynamic> json) =>
    GsLunarArcana(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      name: json['name'] as String? ?? '',
      number: (json['number'] as num?)?.toInt() ?? 0,
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$GsLunarArcanaToJson(GsLunarArcana instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'number': instance.number,
      'image': instance.image,
      'description': instance.description,
    };
