// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_furniture_chest.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiFurnitureChestCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiFurnitureChest(...).copyWith(id: 12, name: "My name")
  /// ```
  GiFurnitureChest call({String id});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiFurnitureChest.copyWith(...)`.
class _$GiFurnitureChestCWProxyImpl implements _$GiFurnitureChestCWProxy {
  const _$GiFurnitureChestCWProxyImpl(this._value);

  final GiFurnitureChest _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiFurnitureChest(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiFurnitureChest call({Object? id = const $CopyWithPlaceholder()}) {
    return GiFurnitureChest(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $GiFurnitureChestCopyWith on GiFurnitureChest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiFurnitureChest.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiFurnitureChestCWProxy get copyWith => _$GiFurnitureChestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiFurnitureChest _$GiFurnitureChestFromJson(Map<String, dynamic> json) =>
    GiFurnitureChest(id: json['id'] as String? ?? '');

Map<String, dynamic> _$GiFurnitureChestToJson(GiFurnitureChest instance) =>
    <String, dynamic>{'id': instance.id};
