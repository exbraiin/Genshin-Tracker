// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_spincrystal.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiSpincrystalCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiSpincrystal(...).copyWith(id: 12, name: "My name")
  /// ```
  GiSpincrystal call({String id});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiSpincrystal.copyWith(...)`.
class _$GiSpincrystalCWProxyImpl implements _$GiSpincrystalCWProxy {
  const _$GiSpincrystalCWProxyImpl(this._value);

  final GiSpincrystal _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiSpincrystal(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiSpincrystal call({Object? id = const $CopyWithPlaceholder()}) {
    return GiSpincrystal(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $GiSpincrystalCopyWith on GiSpincrystal {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiSpincrystal.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiSpincrystalCWProxy get copyWith => _$GiSpincrystalCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiSpincrystal _$GiSpincrystalFromJson(Map<String, dynamic> json) =>
    GiSpincrystal(id: json['id'] as String? ?? '');

Map<String, dynamic> _$GiSpincrystalToJson(GiSpincrystal instance) =>
    <String, dynamic>{'id': instance.id};
