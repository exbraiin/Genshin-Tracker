// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_version.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsVersionCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsVersion(...).copyWith(id: 12, name: "My name")
  /// ```
  GsVersion call({
    String id,
    String label,
    String name,
    String image,
    DateTime releaseDate,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsVersion.copyWith(...)`.
class _$GsVersionCWProxyImpl implements _$GsVersionCWProxy {
  const _$GsVersionCWProxyImpl(this._value);

  final GsVersion _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsVersion(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsVersion call({
    Object? id = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? releaseDate = const $CopyWithPlaceholder(),
  }) {
    return GsVersion(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      label: label == const $CopyWithPlaceholder() || label == null
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      releaseDate:
          releaseDate == const $CopyWithPlaceholder() || releaseDate == null
          ? _value.releaseDate
          // ignore: cast_nullable_to_non_nullable
          : releaseDate as DateTime,
    );
  }
}

extension $GsVersionCopyWith on GsVersion {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsVersion.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsVersionCWProxy get copyWith => _$GsVersionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsVersion _$GsVersionFromJson(Map<String, dynamic> json) => GsVersion(
  id: json['id'] as String? ?? '',
  label: json['label'] as String? ?? '',
  name: json['name'] as String? ?? '',
  image: json['image'] as String? ?? '',
  releaseDate: modelDateFromJson(json['releaseDate']),
);

Map<String, dynamic> _$GsVersionToJson(GsVersion instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'name': instance.name,
  'image': instance.image,
  'releaseDate': modelDateToJson(instance.releaseDate),
};
