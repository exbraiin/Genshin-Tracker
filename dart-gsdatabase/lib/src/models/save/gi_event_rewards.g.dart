// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_event_rewards.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiEventRewards extends _GiEventRewards {
  @override
  final String id;
  @override
  final List<String> obtainedWeapons;
  @override
  final List<String> obtainedCharacters;

  /// Creates a new [GiEventRewards] instance.
  GiEventRewards({
    required this.id,
    required this.obtainedWeapons,
    required this.obtainedCharacters,
  });

  /// Creates a new [GiEventRewards] instance from the given map.
  GiEventRewards.fromJson(JsonMap m)
      : id = m['id'] as String? ?? '',
        obtainedWeapons =
            (m['obtained_weapons'] as List? ?? const []).cast<String>(),
        obtainedCharacters =
            (m['obtained_characters'] as List? ?? const []).cast<String>();

  /// Copies this model with the given parameters.
  @override
  GiEventRewards copyWith({
    String? id,
    List<String>? obtainedWeapons,
    List<String>? obtainedCharacters,
  }) {
    return GiEventRewards(
      id: id ?? this.id,
      obtainedWeapons: obtainedWeapons ?? this.obtainedWeapons,
      obtainedCharacters: obtainedCharacters ?? this.obtainedCharacters,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'obtained_weapons': obtainedWeapons,
      'obtained_characters': obtainedCharacters,
    };
  }
}
