// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsEventCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  GsEvent call({
    String id,
    String version,
    String name,
    GeEventType type,
    String image,
    DateTime dateStart,
    DateTime dateEnd,
    String rewardsOther,
    List<String> rewardsWeapons,
    List<String> rewardsCharacters,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsEvent.copyWith(...)`.
class _$GsEventCWProxyImpl implements _$GsEventCWProxy {
  const _$GsEventCWProxyImpl(this._value);

  final GsEvent _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsEvent(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsEvent call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? dateStart = const $CopyWithPlaceholder(),
    Object? dateEnd = const $CopyWithPlaceholder(),
    Object? rewardsOther = const $CopyWithPlaceholder(),
    Object? rewardsWeapons = const $CopyWithPlaceholder(),
    Object? rewardsCharacters = const $CopyWithPlaceholder(),
  }) {
    return GsEvent(
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
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeEventType,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      dateStart: dateStart == const $CopyWithPlaceholder() || dateStart == null
          ? _value.dateStart
          // ignore: cast_nullable_to_non_nullable
          : dateStart as DateTime,
      dateEnd: dateEnd == const $CopyWithPlaceholder() || dateEnd == null
          ? _value.dateEnd
          // ignore: cast_nullable_to_non_nullable
          : dateEnd as DateTime,
      rewardsOther:
          rewardsOther == const $CopyWithPlaceholder() || rewardsOther == null
          ? _value.rewardsOther
          // ignore: cast_nullable_to_non_nullable
          : rewardsOther as String,
      rewardsWeapons:
          rewardsWeapons == const $CopyWithPlaceholder() ||
              rewardsWeapons == null
          ? _value.rewardsWeapons
          // ignore: cast_nullable_to_non_nullable
          : rewardsWeapons as List<String>,
      rewardsCharacters:
          rewardsCharacters == const $CopyWithPlaceholder() ||
              rewardsCharacters == null
          ? _value.rewardsCharacters
          // ignore: cast_nullable_to_non_nullable
          : rewardsCharacters as List<String>,
    );
  }
}

extension $GsEventCopyWith on GsEvent {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsEvent.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsEventCWProxy get copyWith => _$GsEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsEvent _$GsEventFromJson(Map<String, dynamic> json) => GsEvent(
  id: json['id'] as String? ?? '',
  version: json['version'] as String? ?? '',
  name: json['name'] as String? ?? '',
  type:
      $enumDecodeNullable(
        _$GeEventTypeEnumMap,
        json['type'],
        unknownValue: GeEventType.none,
      ) ??
      GeEventType.none,
  image: json['image'] as String? ?? '',
  dateStart: modelDateFromJson(json['dateStart']),
  dateEnd: modelDateFromJson(json['dateEnd']),
  rewardsOther: json['rewardsOther'] as String? ?? '',
  rewardsWeapons:
      (json['rewardsWeapons'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  rewardsCharacters:
      (json['rewardsCharacters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$GsEventToJson(GsEvent instance) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'name': instance.name,
  'type': _$GeEventTypeEnumMap[instance.type]!,
  'image': instance.image,
  'dateStart': modelDateToJson(instance.dateStart),
  'dateEnd': modelDateToJson(instance.dateEnd),
  'rewardsOther': instance.rewardsOther,
  'rewardsWeapons': instance.rewardsWeapons,
  'rewardsCharacters': instance.rewardsCharacters,
};

const _$GeEventTypeEnumMap = {
  GeEventType.none: 'none',
  GeEventType.quest: 'quest',
  GeEventType.event: 'event',
  GeEventType.login: 'login',
  GeEventType.flagship: 'flagship',
  GeEventType.permanent: 'permanent',
};
