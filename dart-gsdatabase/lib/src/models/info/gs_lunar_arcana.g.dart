// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_lunar_arcana.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GsLunarArcana extends _GsLunarArcana {
  @override
  final String id;
  @override
  final String name;
  @override
  final int number;
  @override
  final String image;
  @override
  final String description;
  @override
  final String version;

  /// Creates a new [GsLunarArcana] instance.
  GsLunarArcana({
    required this.id,
    required this.name,
    required this.number,
    required this.image,
    required this.description,
    required this.version,
  });

  /// Creates a new [GsLunarArcana] instance from the given map.
  GsLunarArcana.fromJson(JsonMap m)
    : id = m['id'] as String? ?? '',
      name = m['name'] as String? ?? '',
      number = m['number'] as int? ?? 0,
      image = m['image'] as String? ?? '',
      description = m['desc'] as String? ?? '',
      version = m['version'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GsLunarArcana copyWith({
    String? id,
    String? name,
    int? number,
    String? image,
    String? description,
    String? version,
  }) {
    return GsLunarArcana(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      image: image ?? this.image,
      description: description ?? this.description,
      version: version ?? this.version,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'image': image,
      'desc': description,
      'version': version,
    };
  }
}
