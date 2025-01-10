// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_envisaged_echo.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiEnvisagedEcho extends _GiEnvisagedEcho {
  @override
  final String id;

  /// Creates a new [GiEnvisagedEcho] instance.
  GiEnvisagedEcho({
    required this.id,
  });

  /// Creates a new [GiEnvisagedEcho] instance from the given map.
  GiEnvisagedEcho.fromJson(JsonMap m) : id = m['id'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GiEnvisagedEcho copyWith({
    String? id,
  }) {
    return GiEnvisagedEcho(
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
