// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_event.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GsEvent extends _GsEvent {
  @override
  final String id;
  @override
  final String name;
  @override
  final GeEventType type;
  @override
  final String image;
  @override
  final String version;
  @override
  final DateTime dateStart;
  @override
  final DateTime dateEnd;
  @override
  final List<String> rewardsWeapons;
  @override
  final List<String> rewardsCharacters;

  /// Creates a new [GsEvent] instance.
  GsEvent({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.version,
    required this.dateStart,
    required this.dateEnd,
    required this.rewardsWeapons,
    required this.rewardsCharacters,
  });

  /// Creates a new [GsEvent] instance from the given map.
  GsEvent.fromJson(JsonMap m)
    : id = m['id'] as String? ?? '',
      name = m['name'] as String? ?? '',
      type = GeEventType.values.fromId(m['type']),
      image = m['image'] as String? ?? '',
      version = m['version'] as String? ?? '',
      dateStart = DateTime.tryParse(m['date_start'].toString()) ?? DateTime(0),
      dateEnd = DateTime.tryParse(m['date_end'].toString()) ?? DateTime(0),
      rewardsWeapons = (m['rewards_weapons'] as List? ?? const [])
          .cast<String>(),
      rewardsCharacters = (m['rewards_characters'] as List? ?? const [])
          .cast<String>();

  /// Copies this model with the given parameters.
  @override
  GsEvent copyWith({
    String? id,
    String? name,
    GeEventType? type,
    String? image,
    String? version,
    DateTime? dateStart,
    DateTime? dateEnd,
    List<String>? rewardsWeapons,
    List<String>? rewardsCharacters,
  }) {
    return GsEvent(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      image: image ?? this.image,
      version: version ?? this.version,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      rewardsWeapons: rewardsWeapons ?? this.rewardsWeapons,
      rewardsCharacters: rewardsCharacters ?? this.rewardsCharacters,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.id,
      'image': image,
      'version': version,
      'date_start': dateStart.toString(),
      'date_end': dateEnd.toString(),
      'rewards_weapons': rewardsWeapons,
      'rewards_characters': rewardsCharacters,
    };
  }
}
