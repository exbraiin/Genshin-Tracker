// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_furniture_chest.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiFurnitureChest extends _GiFurnitureChest {
  @override
  final String id;

  /// Creates a new [GiFurnitureChest] instance.
  GiFurnitureChest({
    required this.id,
  });

  /// Creates a new [GiFurnitureChest] instance from the given map.
  GiFurnitureChest.fromJson(JsonMap m) : id = m['id'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GiFurnitureChest copyWith({
    String? id,
  }) {
    return GiFurnitureChest(
      id: id ?? this.id,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
    };
  }
}
