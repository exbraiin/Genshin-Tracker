// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_character.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GsCharacter extends _GsCharacter {
  @override
  final String id;
  @override
  final String enkaId;
  @override
  final String name;
  @override
  final String namecardId;
  @override
  final String title;
  @override
  final int rarity;
  @override
  final GeRegionType region;
  @override
  final GeWeaponType weapon;
  @override
  final GeElementType element;
  @override
  final String version;
  @override
  final GeItemSourceType source;
  @override
  final String description;
  @override
  final String constellation;
  @override
  final String affiliation;
  @override
  final String specialDish;
  @override
  final DateTime birthday;
  @override
  final DateTime releaseDate;
  @override
  final String image;
  @override
  final String fullImage;
  @override
  final String constellationImage;
  @override
  final String gemMaterial;
  @override
  final String bossMaterial;
  @override
  final String commonMaterial;
  @override
  final String regionMaterial;
  @override
  final String talentMaterial;
  @override
  final String weeklyMaterial;
  @override
  final GeCharacterAscStatType ascStatType;
  @override
  final int ascHpValue;
  @override
  final int ascAtkValue;
  @override
  final int ascDefValue;
  @override
  final double ascStatValue;
  @override
  final int talentAConstellation;
  @override
  final int talentEConstellation;
  @override
  final int talentQConstellation;

  /// Creates a new [GsCharacter] instance.
  GsCharacter({
    required this.id,
    required this.enkaId,
    required this.name,
    required this.namecardId,
    required this.title,
    required this.rarity,
    required this.region,
    required this.weapon,
    required this.element,
    required this.version,
    required this.source,
    required this.description,
    required this.constellation,
    required this.affiliation,
    required this.specialDish,
    required this.birthday,
    required this.releaseDate,
    required this.image,
    required this.fullImage,
    required this.constellationImage,
    required this.gemMaterial,
    required this.bossMaterial,
    required this.commonMaterial,
    required this.regionMaterial,
    required this.talentMaterial,
    required this.weeklyMaterial,
    required this.ascStatType,
    required this.ascHpValue,
    required this.ascAtkValue,
    required this.ascDefValue,
    required this.ascStatValue,
    this.talentAConstellation = -1,
    this.talentEConstellation = -1,
    this.talentQConstellation = -1,
  });

  /// Creates a new [GsCharacter] instance from the given map.
  GsCharacter.fromJson(JsonMap m)
      : id = m['id'] as String? ?? '',
        enkaId = m['enka_id'] as String? ?? '',
        name = m['name'] as String? ?? '',
        namecardId = m['namecard_id'] as String? ?? '',
        title = m['title'] as String? ?? '',
        rarity = m['rarity'] as int? ?? 0,
        region = GeRegionType.values.fromId(m['region']),
        weapon = GeWeaponType.values.fromId(m['weapon']),
        element = GeElementType.values.fromId(m['element']),
        version = m['version'] as String? ?? '',
        source = GeItemSourceType.values.fromId(m['source']),
        description = m['description'] as String? ?? '',
        constellation = m['constellation'] as String? ?? '',
        affiliation = m['affiliation'] as String? ?? '',
        specialDish = m['special_dish'] as String? ?? '',
        birthday = DateTime.tryParse(m['birthday'].toString()) ?? DateTime(0),
        releaseDate =
            DateTime.tryParse(m['release_date'].toString()) ?? DateTime(0),
        image = m['image'] as String? ?? '',
        fullImage = m['full_image'] as String? ?? '',
        constellationImage = m['constellation_image'] as String? ?? '',
        gemMaterial = m['mat_gem'] as String? ?? '',
        bossMaterial = m['mat_boss'] as String? ?? '',
        commonMaterial = m['mat_common'] as String? ?? '',
        regionMaterial = m['mat_region'] as String? ?? '',
        talentMaterial = m['mat_talent'] as String? ?? '',
        weeklyMaterial = m['mat_weekly'] as String? ?? '',
        ascStatType = GeCharacterAscStatType.values.fromId(m['asc_stat_type']),
        ascHpValue = m['asc_hp_value'] as int? ?? 0,
        ascAtkValue = m['asc_atk_value'] as int? ?? 0,
        ascDefValue = m['asc_def_value'] as int? ?? 0,
        ascStatValue = m['asc_stat_value'] as double? ?? 0,
        talentAConstellation = m['tal_a_const'] as int? ?? -1,
        talentEConstellation = m['tal_e_const'] as int? ?? -1,
        talentQConstellation = m['tal_q_const'] as int? ?? -1;

  /// Copies this model with the given parameters.
  @override
  GsCharacter copyWith({
    String? id,
    String? enkaId,
    String? name,
    String? namecardId,
    String? title,
    int? rarity,
    GeRegionType? region,
    GeWeaponType? weapon,
    GeElementType? element,
    String? version,
    GeItemSourceType? source,
    String? description,
    String? constellation,
    String? affiliation,
    String? specialDish,
    DateTime? birthday,
    DateTime? releaseDate,
    String? image,
    String? fullImage,
    String? constellationImage,
    String? gemMaterial,
    String? bossMaterial,
    String? commonMaterial,
    String? regionMaterial,
    String? talentMaterial,
    String? weeklyMaterial,
    GeCharacterAscStatType? ascStatType,
    int? ascHpValue,
    int? ascAtkValue,
    int? ascDefValue,
    double? ascStatValue,
    int? talentAConstellation,
    int? talentEConstellation,
    int? talentQConstellation,
  }) {
    return GsCharacter(
      id: id ?? this.id,
      enkaId: enkaId ?? this.enkaId,
      name: name ?? this.name,
      namecardId: namecardId ?? this.namecardId,
      title: title ?? this.title,
      rarity: rarity ?? this.rarity,
      region: region ?? this.region,
      weapon: weapon ?? this.weapon,
      element: element ?? this.element,
      version: version ?? this.version,
      source: source ?? this.source,
      description: description ?? this.description,
      constellation: constellation ?? this.constellation,
      affiliation: affiliation ?? this.affiliation,
      specialDish: specialDish ?? this.specialDish,
      birthday: birthday ?? this.birthday,
      releaseDate: releaseDate ?? this.releaseDate,
      image: image ?? this.image,
      fullImage: fullImage ?? this.fullImage,
      constellationImage: constellationImage ?? this.constellationImage,
      gemMaterial: gemMaterial ?? this.gemMaterial,
      bossMaterial: bossMaterial ?? this.bossMaterial,
      commonMaterial: commonMaterial ?? this.commonMaterial,
      regionMaterial: regionMaterial ?? this.regionMaterial,
      talentMaterial: talentMaterial ?? this.talentMaterial,
      weeklyMaterial: weeklyMaterial ?? this.weeklyMaterial,
      ascStatType: ascStatType ?? this.ascStatType,
      ascHpValue: ascHpValue ?? this.ascHpValue,
      ascAtkValue: ascAtkValue ?? this.ascAtkValue,
      ascDefValue: ascDefValue ?? this.ascDefValue,
      ascStatValue: ascStatValue ?? this.ascStatValue,
      talentAConstellation: talentAConstellation ?? this.talentAConstellation,
      talentEConstellation: talentEConstellation ?? this.talentEConstellation,
      talentQConstellation: talentQConstellation ?? this.talentQConstellation,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'enka_id': enkaId,
      'name': name,
      'namecard_id': namecardId,
      'title': title,
      'rarity': rarity,
      'region': region.id,
      'weapon': weapon.id,
      'element': element.id,
      'version': version,
      'source': source.id,
      'description': description,
      'constellation': constellation,
      'affiliation': affiliation,
      'special_dish': specialDish,
      'birthday': birthday.toString(),
      'release_date': releaseDate.toString(),
      'image': image,
      'full_image': fullImage,
      'constellation_image': constellationImage,
      'mat_gem': gemMaterial,
      'mat_boss': bossMaterial,
      'mat_common': commonMaterial,
      'mat_region': regionMaterial,
      'mat_talent': talentMaterial,
      'mat_weekly': weeklyMaterial,
      'asc_stat_type': ascStatType.id,
      'asc_hp_value': ascHpValue,
      'asc_atk_value': ascAtkValue,
      'asc_def_value': ascDefValue,
      'asc_stat_value': ascStatValue,
      'tal_a_const': talentAConstellation,
      'tal_e_const': talentEConstellation,
      'tal_q_const': talentQConstellation,
    };
  }
}
