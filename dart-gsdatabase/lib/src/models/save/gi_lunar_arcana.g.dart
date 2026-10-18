// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_lunar_arcana.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiLunarArcanaCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiLunarArcana(...).copyWith(id: 12, name: "My name")
  /// ```
  GiLunarArcana call({String id});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiLunarArcana.copyWith(...)`.
class _$GiLunarArcanaCWProxyImpl implements _$GiLunarArcanaCWProxy {
  const _$GiLunarArcanaCWProxyImpl(this._value);

  final GiLunarArcana _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiLunarArcana(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiLunarArcana call({Object? id = const $CopyWithPlaceholder()}) {
    return GiLunarArcana(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $GiLunarArcanaCopyWith on GiLunarArcana {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiLunarArcana.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiLunarArcanaCWProxy get copyWith => _$GiLunarArcanaCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiLunarArcana _$GiLunarArcanaFromJson(Map<String, dynamic> json) =>
    GiLunarArcana(id: json['id'] as String? ?? '');

Map<String, dynamic> _$GiLunarArcanaToJson(GiLunarArcana instance) =>
    <String, dynamic>{'id': instance.id};
