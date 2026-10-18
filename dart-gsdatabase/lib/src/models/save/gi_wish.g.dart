// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_wish.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiWishCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiWish(...).copyWith(id: 12, name: "My name")
  /// ```
  GiWish call({
    String id,
    int number,
    String itemId,
    String bannerId,
    DateTime date,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiWish.copyWith(...)`.
class _$GiWishCWProxyImpl implements _$GiWishCWProxy {
  const _$GiWishCWProxyImpl(this._value);

  final GiWish _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiWish(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiWish call({
    Object? id = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
    Object? itemId = const $CopyWithPlaceholder(),
    Object? bannerId = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
  }) {
    return GiWish(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      number: number == const $CopyWithPlaceholder() || number == null
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as int,
      itemId: itemId == const $CopyWithPlaceholder() || itemId == null
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String,
      bannerId: bannerId == const $CopyWithPlaceholder() || bannerId == null
          ? _value.bannerId
          // ignore: cast_nullable_to_non_nullable
          : bannerId as String,
      date: date == const $CopyWithPlaceholder() || date == null
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime,
    );
  }
}

extension $GiWishCopyWith on GiWish {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiWish.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiWishCWProxy get copyWith => _$GiWishCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiWish _$GiWishFromJson(Map<String, dynamic> json) => GiWish(
  id: json['id'] as String? ?? '',
  number: (json['number'] as num?)?.toInt() ?? 0,
  itemId: json['itemId'] as String? ?? '',
  bannerId: json['bannerId'] as String? ?? '',
  date: modelDateFromJson(json['date']),
);

Map<String, dynamic> _$GiWishToJson(GiWish instance) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'itemId': instance.itemId,
  'bannerId': instance.bannerId,
  'date': modelDateToJson(instance.date),
};
