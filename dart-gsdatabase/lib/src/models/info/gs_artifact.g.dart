// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_artifact.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsArtifactCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsArtifact(...).copyWith(id: 12, name: "My name")
  /// ```
  GsArtifact call({
    String id,
    String version,
    String name,
    GeRegionType region,
    int rarity,
    String pc1,
    String pc2,
    String pc4,
    String domain,
    List<GsArtifactPiece> pieces,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsArtifact.copyWith(...)`.
class _$GsArtifactCWProxyImpl implements _$GsArtifactCWProxy {
  const _$GsArtifactCWProxyImpl(this._value);

  final GsArtifact _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsArtifact(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsArtifact call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? region = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? pc1 = const $CopyWithPlaceholder(),
    Object? pc2 = const $CopyWithPlaceholder(),
    Object? pc4 = const $CopyWithPlaceholder(),
    Object? domain = const $CopyWithPlaceholder(),
    Object? pieces = const $CopyWithPlaceholder(),
  }) {
    return GsArtifact(
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
      region: region == const $CopyWithPlaceholder() || region == null
          ? _value.region
          // ignore: cast_nullable_to_non_nullable
          : region as GeRegionType,
      rarity: rarity == const $CopyWithPlaceholder() || rarity == null
          ? _value.rarity
          // ignore: cast_nullable_to_non_nullable
          : rarity as int,
      pc1: pc1 == const $CopyWithPlaceholder() || pc1 == null
          ? _value.pc1
          // ignore: cast_nullable_to_non_nullable
          : pc1 as String,
      pc2: pc2 == const $CopyWithPlaceholder() || pc2 == null
          ? _value.pc2
          // ignore: cast_nullable_to_non_nullable
          : pc2 as String,
      pc4: pc4 == const $CopyWithPlaceholder() || pc4 == null
          ? _value.pc4
          // ignore: cast_nullable_to_non_nullable
          : pc4 as String,
      domain: domain == const $CopyWithPlaceholder() || domain == null
          ? _value.domain
          // ignore: cast_nullable_to_non_nullable
          : domain as String,
      pieces: pieces == const $CopyWithPlaceholder() || pieces == null
          ? _value.pieces
          // ignore: cast_nullable_to_non_nullable
          : pieces as List<GsArtifactPiece>,
    );
  }
}

extension $GsArtifactCopyWith on GsArtifact {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsArtifact.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsArtifactCWProxy get copyWith => _$GsArtifactCWProxyImpl(this);
}

abstract class _$GsArtifactPieceCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsArtifactPiece(...).copyWith(id: 12, name: "My name")
  /// ```
  GsArtifactPiece call({
    String id,
    String name,
    String icon,
    String desc,
    GeArtifactPieceType type,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsArtifactPiece.copyWith(...)`.
class _$GsArtifactPieceCWProxyImpl implements _$GsArtifactPieceCWProxy {
  const _$GsArtifactPieceCWProxyImpl(this._value);

  final GsArtifactPiece _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsArtifactPiece(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsArtifactPiece call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? icon = const $CopyWithPlaceholder(),
    Object? desc = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return GsArtifactPiece(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      icon: icon == const $CopyWithPlaceholder() || icon == null
          ? _value.icon
          // ignore: cast_nullable_to_non_nullable
          : icon as String,
      desc: desc == const $CopyWithPlaceholder() || desc == null
          ? _value.desc
          // ignore: cast_nullable_to_non_nullable
          : desc as String,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeArtifactPieceType,
    );
  }
}

extension $GsArtifactPieceCopyWith on GsArtifactPiece {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsArtifactPiece.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsArtifactPieceCWProxy get copyWith => _$GsArtifactPieceCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsArtifact _$GsArtifactFromJson(Map<String, dynamic> json) => GsArtifact(
  id: json['id'] as String? ?? '',
  version: json['version'] as String? ?? '',
  name: json['name'] as String? ?? '',
  region:
      $enumDecodeNullable(
        _$GeRegionTypeEnumMap,
        json['region'],
        unknownValue: GeRegionType.none,
      ) ??
      GeRegionType.none,
  rarity: (json['rarity'] as num?)?.toInt() ?? 0,
  pc1: json['pc1'] as String? ?? '',
  pc2: json['pc2'] as String? ?? '',
  pc4: json['pc4'] as String? ?? '',
  domain: json['domain'] as String? ?? '',
  pieces:
      (json['pieces'] as List<dynamic>?)
          ?.map((e) => GsArtifactPiece.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GsArtifactToJson(GsArtifact instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'region': _$GeRegionTypeEnumMap[instance.region]!,
      'rarity': instance.rarity,
      'pc1': instance.pc1,
      'pc2': instance.pc2,
      'pc4': instance.pc4,
      'domain': instance.domain,
      'pieces': instance.pieces.map((e) => e.toJson()).toList(),
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

GsArtifactPiece _$GsArtifactPieceFromJson(Map<String, dynamic> json) =>
    GsArtifactPiece(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      type:
          $enumDecodeNullable(
            _$GeArtifactPieceTypeEnumMap,
            json['type'],
            unknownValue: GeArtifactPieceType.flowerOfLife,
          ) ??
          GeArtifactPieceType.flowerOfLife,
    );

Map<String, dynamic> _$GsArtifactPieceToJson(GsArtifactPiece instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'desc': instance.desc,
      'type': _$GeArtifactPieceTypeEnumMap[instance.type]!,
    };

const _$GeArtifactPieceTypeEnumMap = {
  GeArtifactPieceType.flowerOfLife: 'flower_of_life',
  GeArtifactPieceType.plumeOfDeath: 'plume_of_death',
  GeArtifactPieceType.sandsOfEon: 'sands_of_eon',
  GeArtifactPieceType.gobletOfEonothem: 'goblet_of_eonothem',
  GeArtifactPieceType.circletOfLogos: 'circlet_of_logos',
};
