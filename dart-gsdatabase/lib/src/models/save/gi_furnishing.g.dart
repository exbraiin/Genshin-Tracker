// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_furnishing.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiFurnishingCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiFurnishing(...).copyWith(id: 12, name: "My name")
  /// ```
  GiFurnishing call({String id, int amount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiFurnishing.copyWith(...)`.
class _$GiFurnishingCWProxyImpl implements _$GiFurnishingCWProxy {
  const _$GiFurnishingCWProxyImpl(this._value);

  final GiFurnishing _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiFurnishing(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiFurnishing call({
    Object? id = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
  }) {
    return GiFurnishing(
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

extension $GiFurnishingCopyWith on GiFurnishing {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiFurnishing.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiFurnishingCWProxy get copyWith => _$GiFurnishingCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiFurnishing _$GiFurnishingFromJson(Map<String, dynamic> json) => GiFurnishing(
  id: json['id'] as String? ?? '',
  amount: (json['amount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$GiFurnishingToJson(GiFurnishing instance) =>
    <String, dynamic>{'id': instance.id, 'amount': instance.amount};
