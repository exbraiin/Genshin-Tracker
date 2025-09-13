// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_thespian_trick.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GsThespianTrick extends _GsThespianTrick {
  @override
  final String id;
  @override
  final String name;
  @override
  final int rarity;
  @override
  final int season;
  @override
  final String character;
  @override
  final String image;
  @override
  final String version;

  /// Creates a new [GsThespianTrick] instance.
  GsThespianTrick({
    required this.id,
    required this.name,
    required this.rarity,
    required this.season,
    required this.character,
    required this.image,
    required this.version,
  });

  /// Creates a new [GsThespianTrick] instance from the given map.
  GsThespianTrick.fromJson(JsonMap m)
    : id = m['id'] as String? ?? '',
      name = m['name'] as String? ?? '',
      rarity = m['rarity'] as int? ?? 0,
      season = m['season'] as int? ?? 0,
      character = m['character'] as String? ?? '',
      image = m['image'] as String? ?? '',
      version = m['version'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GsThespianTrick copyWith({
    String? id,
    String? name,
    int? rarity,
    int? season,
    String? character,
    String? image,
    String? version,
  }) {
    return GsThespianTrick(
      id: id ?? this.id,
      name: name ?? this.name,
      rarity: rarity ?? this.rarity,
      season: season ?? this.season,
      character: character ?? this.character,
      image: image ?? this.image,
      version: version ?? this.version,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'rarity': rarity,
      'season': season,
      'character': character,
      'image': image,
      'version': version,
    };
  }
}
