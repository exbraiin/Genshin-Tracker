// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_envisaged_echo.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsEnvisagedEchoCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsEnvisagedEcho(...).copyWith(id: 12, name: "My name")
  /// ```
  GsEnvisagedEcho call({
    String id,
    String version,
    String name,
    String description,
    String character,
    int rarity,
    String icon,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsEnvisagedEcho.copyWith(...)`.
class _$GsEnvisagedEchoCWProxyImpl implements _$GsEnvisagedEchoCWProxy {
  const _$GsEnvisagedEchoCWProxyImpl(this._value);

  final GsEnvisagedEcho _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsEnvisagedEcho(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsEnvisagedEcho call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? character = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? icon = const $CopyWithPlaceholder(),
  }) {
    return GsEnvisagedEcho(
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
      description:
          description == const $CopyWithPlaceholder() || description == null
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      character: character == const $CopyWithPlaceholder() || character == null
          ? _value.character
          // ignore: cast_nullable_to_non_nullable
          : character as String,
      rarity: rarity == const $CopyWithPlaceholder() || rarity == null
          ? _value.rarity
          // ignore: cast_nullable_to_non_nullable
          : rarity as int,
      icon: icon == const $CopyWithPlaceholder() || icon == null
          ? _value.icon
          // ignore: cast_nullable_to_non_nullable
          : icon as String,
    );
  }
}

extension $GsEnvisagedEchoCopyWith on GsEnvisagedEcho {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsEnvisagedEcho.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsEnvisagedEchoCWProxy get copyWith => _$GsEnvisagedEchoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsEnvisagedEcho _$GsEnvisagedEchoFromJson(Map<String, dynamic> json) =>
    GsEnvisagedEcho(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      character: json['character'] as String? ?? '',
      rarity: (json['rarity'] as num?)?.toInt() ?? 0,
      icon: json['icon'] as String? ?? '',
    );

Map<String, dynamic> _$GsEnvisagedEchoToJson(GsEnvisagedEcho instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'description': instance.description,
      'character': instance.character,
      'rarity': instance.rarity,
      'icon': instance.icon,
    };
