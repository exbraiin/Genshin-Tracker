// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_battlepass.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsBattlepassCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsBattlepass(...).copyWith(id: 12, name: "My name")
  /// ```
  GsBattlepass call({
    String id,
    String version,
    String name,
    String image,
    String namecardId,
    DateTime dateStart,
    DateTime dateEnd,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsBattlepass.copyWith(...)`.
class _$GsBattlepassCWProxyImpl implements _$GsBattlepassCWProxy {
  const _$GsBattlepassCWProxyImpl(this._value);

  final GsBattlepass _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsBattlepass(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsBattlepass call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? namecardId = const $CopyWithPlaceholder(),
    Object? dateStart = const $CopyWithPlaceholder(),
    Object? dateEnd = const $CopyWithPlaceholder(),
  }) {
    return GsBattlepass(
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
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      namecardId:
          namecardId == const $CopyWithPlaceholder() || namecardId == null
          ? _value.namecardId
          // ignore: cast_nullable_to_non_nullable
          : namecardId as String,
      dateStart: dateStart == const $CopyWithPlaceholder() || dateStart == null
          ? _value.dateStart
          // ignore: cast_nullable_to_non_nullable
          : dateStart as DateTime,
      dateEnd: dateEnd == const $CopyWithPlaceholder() || dateEnd == null
          ? _value.dateEnd
          // ignore: cast_nullable_to_non_nullable
          : dateEnd as DateTime,
    );
  }
}

extension $GsBattlepassCopyWith on GsBattlepass {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsBattlepass.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsBattlepassCWProxy get copyWith => _$GsBattlepassCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsBattlepass _$GsBattlepassFromJson(Map<String, dynamic> json) => GsBattlepass(
  id: json['id'] as String? ?? '',
  version: json['version'] as String? ?? '',
  name: json['name'] as String? ?? '',
  image: json['image'] as String? ?? '',
  namecardId: json['namecardId'] as String? ?? '',
  dateStart: modelDateFromJson(json['dateStart']),
  dateEnd: modelDateFromJson(json['dateEnd']),
);

Map<String, dynamic> _$GsBattlepassToJson(GsBattlepass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'image': instance.image,
      'namecardId': instance.namecardId,
      'dateStart': modelDateToJson(instance.dateStart),
      'dateEnd': modelDateToJson(instance.dateEnd),
    };
