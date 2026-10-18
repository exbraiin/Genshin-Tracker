// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_banner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsBannerCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsBanner(...).copyWith(id: 12, name: "My name")
  /// ```
  GsBanner call({
    String id,
    String version,
    String name,
    String image,
    DateTime dateStart,
    DateTime dateEnd,
    GeBannerType type,
    int subtype,
    List<String> feature4,
    List<String> feature5,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsBanner.copyWith(...)`.
class _$GsBannerCWProxyImpl implements _$GsBannerCWProxy {
  const _$GsBannerCWProxyImpl(this._value);

  final GsBanner _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsBanner(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsBanner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? dateStart = const $CopyWithPlaceholder(),
    Object? dateEnd = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? subtype = const $CopyWithPlaceholder(),
    Object? feature4 = const $CopyWithPlaceholder(),
    Object? feature5 = const $CopyWithPlaceholder(),
  }) {
    return GsBanner(
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
      dateStart: dateStart == const $CopyWithPlaceholder() || dateStart == null
          ? _value.dateStart
          // ignore: cast_nullable_to_non_nullable
          : dateStart as DateTime,
      dateEnd: dateEnd == const $CopyWithPlaceholder() || dateEnd == null
          ? _value.dateEnd
          // ignore: cast_nullable_to_non_nullable
          : dateEnd as DateTime,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeBannerType,
      subtype: subtype == const $CopyWithPlaceholder() || subtype == null
          ? _value.subtype
          // ignore: cast_nullable_to_non_nullable
          : subtype as int,
      feature4: feature4 == const $CopyWithPlaceholder() || feature4 == null
          ? _value.feature4
          // ignore: cast_nullable_to_non_nullable
          : feature4 as List<String>,
      feature5: feature5 == const $CopyWithPlaceholder() || feature5 == null
          ? _value.feature5
          // ignore: cast_nullable_to_non_nullable
          : feature5 as List<String>,
    );
  }
}

extension $GsBannerCopyWith on GsBanner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsBanner.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsBannerCWProxy get copyWith => _$GsBannerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsBanner _$GsBannerFromJson(Map<String, dynamic> json) => GsBanner(
  id: json['id'] as String? ?? '',
  version: json['version'] as String? ?? '',
  name: json['name'] as String? ?? '',
  image: json['image'] as String? ?? '',
  dateStart: modelDateFromJson(json['dateStart']),
  dateEnd: modelDateFromJson(json['dateEnd']),
  type:
      $enumDecodeNullable(
        _$GeBannerTypeEnumMap,
        json['type'],
        unknownValue: GeBannerType.standard,
      ) ??
      GeBannerType.standard,
  subtype: (json['subtype'] as num?)?.toInt() ?? 0,
  feature4:
      (json['feature4'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  feature5:
      (json['feature5'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$GsBannerToJson(GsBanner instance) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'name': instance.name,
  'image': instance.image,
  'dateStart': modelDateToJson(instance.dateStart),
  'dateEnd': modelDateToJson(instance.dateEnd),
  'type': _$GeBannerTypeEnumMap[instance.type]!,
  'subtype': instance.subtype,
  'feature4': instance.feature4,
  'feature5': instance.feature5,
};

const _$GeBannerTypeEnumMap = {
  GeBannerType.standard: 'standard',
  GeBannerType.beginner: 'beginner',
  GeBannerType.character: 'character',
  GeBannerType.weapon: 'weapon',
  GeBannerType.chronicled: 'chronicled',
};
