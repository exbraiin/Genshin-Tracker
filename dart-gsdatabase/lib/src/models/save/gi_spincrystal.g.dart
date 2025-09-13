// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_spincrystal.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiSpincrystal extends _GiSpincrystal {
  @override
  final String id;

  /// Creates a new [GiSpincrystal] instance.
  GiSpincrystal({required this.id});

  /// Creates a new [GiSpincrystal] instance from the given map.
  GiSpincrystal.fromJson(JsonMap m) : id = m['id'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GiSpincrystal copyWith({String? id}) {
    return GiSpincrystal(id: id ?? this.id);
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {'id': id};
  }
}
