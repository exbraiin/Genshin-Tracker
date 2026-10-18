// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_material.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiMaterialCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiMaterial(...).copyWith(id: 12, name: "My name")
  /// ```
  GiMaterial call({String id, int amount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiMaterial.copyWith(...)`.
class _$GiMaterialCWProxyImpl implements _$GiMaterialCWProxy {
  const _$GiMaterialCWProxyImpl(this._value);

  final GiMaterial _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiMaterial(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiMaterial call({
    Object? id = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
  }) {
    return GiMaterial(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
    );
  }
}

extension $GiMaterialCopyWith on GiMaterial {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiMaterial.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiMaterialCWProxy get copyWith => _$GiMaterialCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiMaterial _$GiMaterialFromJson(Map<String, dynamic> json) => GiMaterial(
  id: json['id'] as String? ?? '',
  amount: (json['amount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$GiMaterialToJson(GiMaterial instance) =>
    <String, dynamic>{'id': instance.id, 'amount': instance.amount};
