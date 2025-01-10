// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_envisaged_echo.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GsEnvisagedEcho extends _GsEnvisagedEcho {
  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String character;
  @override
  final int rarity;
  @override
  final String icon;
  @override
  final String version;

  /// Creates a new [GsEnvisagedEcho] instance.
  GsEnvisagedEcho({
    required this.id,
    required this.name,
    required this.description,
    required this.character,
    required this.rarity,
    required this.icon,
    required this.version,
  });

  /// Creates a new [GsEnvisagedEcho] instance from the given map.
  GsEnvisagedEcho.fromJson(JsonMap m)
      : id = m['id'] as String? ?? '',
        name = m['name'] as String? ?? '',
        description = m['desc'] as String? ?? '',
        character = m['character'] as String? ?? '',
        rarity = m['rarity'] as int? ?? 0,
        icon = m['icon'] as String? ?? '',
        version = m['version'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GsEnvisagedEcho copyWith({
    String? id,
    String? name,
    String? description,
    String? character,
    int? rarity,
    String? icon,
    String? version,
  }) {
    return GsEnvisagedEcho(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      character: character ?? this.character,
      rarity: rarity ?? this.rarity,
      icon: icon ?? this.icon,
      version: version ?? this.version,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'desc': description,
      'character': character,
      'rarity': rarity,
      'icon': icon,
      'version': version,
    };
  }
}
