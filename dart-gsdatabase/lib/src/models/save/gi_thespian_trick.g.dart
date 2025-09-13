// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_thespian_trick.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiThespianTrick extends _GiThespianTrick {
  @override
  final String id;

  /// Creates a new [GiThespianTrick] instance.
  GiThespianTrick({required this.id});

  /// Creates a new [GiThespianTrick] instance from the given map.
  GiThespianTrick.fromJson(JsonMap m) : id = m['id'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GiThespianTrick copyWith({String? id}) {
    return GiThespianTrick(id: id ?? this.id);
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {'id': id};
  }
}
