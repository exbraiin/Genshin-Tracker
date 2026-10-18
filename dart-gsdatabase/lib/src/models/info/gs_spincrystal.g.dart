// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_spincrystal.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsSpincrystalCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsSpincrystal(...).copyWith(id: 12, name: "My name")
  /// ```
  GsSpincrystal call({
    String id,
    String version,
    String name,
    int number,
    String source,
    String imageSource,
    GeRegionType region,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsSpincrystal.copyWith(...)`.
class _$GsSpincrystalCWProxyImpl implements _$GsSpincrystalCWProxy {
  const _$GsSpincrystalCWProxyImpl(this._value);

  final GsSpincrystal _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsSpincrystal(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsSpincrystal call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? number = const $CopyWithPlaceholder(),
    Object? source = const $CopyWithPlaceholder(),
    Object? imageSource = const $CopyWithPlaceholder(),
    Object? region = const $CopyWithPlaceholder(),
  }) {
    return GsSpincrystal(
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
      number: number == const $CopyWithPlaceholder() || number == null
          ? _value.number
          // ignore: cast_nullable_to_non_nullable
          : number as int,
      source: source == const $CopyWithPlaceholder() || source == null
          ? _value.source
          // ignore: cast_nullable_to_non_nullable
          : source as String,
      imageSource:
          imageSource == const $CopyWithPlaceholder() || imageSource == null
          ? _value.imageSource
          // ignore: cast_nullable_to_non_nullable
          : imageSource as String,
      region: region == const $CopyWithPlaceholder() || region == null
          ? _value.region
          // ignore: cast_nullable_to_non_nullable
          : region as GeRegionType,
    );
  }
}

extension $GsSpincrystalCopyWith on GsSpincrystal {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsSpincrystal.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsSpincrystalCWProxy get copyWith => _$GsSpincrystalCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsSpincrystal _$GsSpincrystalFromJson(Map<String, dynamic> json) =>
    GsSpincrystal(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      name: json['name'] as String? ?? '',
      number: (json['number'] as num?)?.toInt() ?? 0,
      source: json['source'] as String? ?? '',
      imageSource: json['imageSource'] as String? ?? '',
      region:
          $enumDecodeNullable(
            _$GeRegionTypeEnumMap,
            json['region'],
            unknownValue: GeRegionType.none,
          ) ??
          GeRegionType.none,
    );

Map<String, dynamic> _$GsSpincrystalToJson(GsSpincrystal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'number': instance.number,
      'source': instance.source,
      'imageSource': instance.imageSource,
      'region': _$GeRegionTypeEnumMap[instance.region]!,
    };

const _$GeRegionTypeEnumMap = {
  GeRegionType.none: 'none',
  GeRegionType.mondstadt: 'mondstadt',
  GeRegionType.liyue: 'liyue',
  GeRegionType.inazuma: 'inazuma',
  GeRegionType.sumeru: 'sumeru',
  GeRegionType.fontaine: 'fontaine',
  GeRegionType.natlan: 'natlan',
  GeRegionType.nodkrai: 'nodkrai',
  GeRegionType.snezhnaya: 'snezhnaya',
};
