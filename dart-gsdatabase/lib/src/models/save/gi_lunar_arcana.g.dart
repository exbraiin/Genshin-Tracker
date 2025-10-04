// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_lunar_arcana.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiLunarArcana extends _GiLunarArcana {
  @override
  final String id;

  /// Creates a new [GiLunarArcana] instance.
  GiLunarArcana({required this.id});

  /// Creates a new [GiLunarArcana] instance from the given map.
  GiLunarArcana.fromJson(JsonMap m) : id = m['id'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GiLunarArcana copyWith({String? id}) {
    return GiLunarArcana(id: id ?? this.id);
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {'id': id};
  }
}
