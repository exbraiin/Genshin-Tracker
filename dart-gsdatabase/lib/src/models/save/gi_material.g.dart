// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_material.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiMaterial extends _GiMaterial {
  @override
  final String id;
  @override
  final int amount;

  /// Creates a new [GiMaterial] instance.
  GiMaterial({required this.id, required this.amount});

  /// Creates a new [GiMaterial] instance from the given map.
  GiMaterial.fromJson(JsonMap m)
    : id = m['id'] as String? ?? '',
      amount = m['amount'] as int? ?? 0;

  /// Copies this model with the given parameters.
  @override
  GiMaterial copyWith({String? id, int? amount}) {
    return GiMaterial(id: id ?? this.id, amount: amount ?? this.amount);
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {'id': id, 'amount': amount};
  }
}
