// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_serenitea_set.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsSereniteaSetCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsSereniteaSet(...).copyWith(id: 12, name: "My name")
  /// ```
  GsSereniteaSet call({
    String id,
    String version,
    String name,
    GeSereniteaSetType category,
    String image,
    int rarity,
    int energy,
    List<String> chars,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsSereniteaSet.copyWith(...)`.
class _$GsSereniteaSetCWProxyImpl implements _$GsSereniteaSetCWProxy {
  const _$GsSereniteaSetCWProxyImpl(this._value);

  final GsSereniteaSet _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsSereniteaSet(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsSereniteaSet call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? energy = const $CopyWithPlaceholder(),
    Object? chars = const $CopyWithPlaceholder(),
  }) {
    return GsSereniteaSet(
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
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as GeSereniteaSetType,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      rarity: rarity == const $CopyWithPlaceholder() || rarity == null
          ? _value.rarity
          // ignore: cast_nullable_to_non_nullable
          : rarity as int,
      energy: energy == const $CopyWithPlaceholder() || energy == null
          ? _value.energy
          // ignore: cast_nullable_to_non_nullable
          : energy as int,
      chars: chars == const $CopyWithPlaceholder() || chars == null
          ? _value.chars
          // ignore: cast_nullable_to_non_nullable
          : chars as List<String>,
    );
  }
}

extension $GsSereniteaSetCopyWith on GsSereniteaSet {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsSereniteaSet.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsSereniteaSetCWProxy get copyWith => _$GsSereniteaSetCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsSereniteaSet _$GsSereniteaSetFromJson(Map<String, dynamic> json) =>
    GsSereniteaSet(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category:
          $enumDecodeNullable(
            _$GeSereniteaSetTypeEnumMap,
            json['category'],
            unknownValue: GeSereniteaSetType.none,
          ) ??
          GeSereniteaSetType.none,
      image: json['image'] as String? ?? '',
      rarity: (json['rarity'] as num?)?.toInt() ?? 0,
      energy: (json['energy'] as num?)?.toInt() ?? 0,
      chars:
          (json['chars'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$GsSereniteaSetToJson(GsSereniteaSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'category': _$GeSereniteaSetTypeEnumMap[instance.category]!,
      'image': instance.image,
      'rarity': instance.rarity,
      'energy': instance.energy,
      'chars': instance.chars,
    };

const _$GeSereniteaSetTypeEnumMap = {
  GeSereniteaSetType.none: 'none',
  GeSereniteaSetType.indoor: 'indoor',
  GeSereniteaSetType.outdoor: 'outdoor',
};
