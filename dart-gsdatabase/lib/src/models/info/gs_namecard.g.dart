// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_namecard.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GsNamecard extends _GsNamecard {
  @override
  final String id;
  @override
  final String name;
  @override
  final int rarity;
  @override
  final GeNamecardType type;
  @override
  final String version;
  @override
  final String image;
  @override
  final String fullImage;
  @override
  final String desc;

  /// Creates a new [GsNamecard] instance.
  GsNamecard({
    required this.id,
    required this.name,
    required this.rarity,
    required this.type,
    required this.version,
    required this.image,
    required this.fullImage,
    required this.desc,
  });

  /// Creates a new [GsNamecard] instance from the given map.
  GsNamecard.fromJson(JsonMap m)
      : id = m['id'] as String? ?? '',
        name = m['name'] as String? ?? '',
        rarity = m['rarity'] as int? ?? 0,
        type = GeNamecardType.values.fromId(m['type']),
        version = m['version'] as String? ?? '',
        image = m['image'] as String? ?? '',
        fullImage = m['full_image'] as String? ?? '',
        desc = m['desc'] as String? ?? '';

  /// Copies this model with the given parameters.
  @override
  GsNamecard copyWith({
    String? id,
    String? name,
    int? rarity,
    GeNamecardType? type,
    String? version,
    String? image,
    String? fullImage,
    String? desc,
  }) {
    return GsNamecard(
      id: id ?? this.id,
      name: name ?? this.name,
      rarity: rarity ?? this.rarity,
      type: type ?? this.type,
      version: version ?? this.version,
      image: image ?? this.image,
      fullImage: fullImage ?? this.fullImage,
      desc: desc ?? this.desc,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'name': name,
      'rarity': rarity,
      'type': type.id,
      'version': version,
      'image': image,
      'full_image': fullImage,
      'desc': desc,
    };
  }
}
