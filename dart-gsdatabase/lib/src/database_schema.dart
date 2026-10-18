import 'package:gsdatabase/src/models/gs_model.dart';

// Version 0 is the original, unversioned database format.
const kCurrentDatabaseSchemaVersion = 1;
const kSchemaVersionKey = 'schemaVersion';

/// Returns a migrated copy without changing the supplied database.
/// Missing schema versions identify the original version 0 format.
JsonMap infoDatabaseMigrator(JsonMap json) =>
    _migrateDatabase(json, _kInfoVersion0Keys);

/// Returns a migrated copy of a save database without changing the input.
JsonMap saveDatabaseMigrator(JsonMap json) =>
    _migrateDatabase(json, _kSaveVersion0Keys);

JsonMap _migrateDatabase(
  JsonMap json,
  Map<String, Map<String, String>> tables,
) {
  final version = json.containsKey(kSchemaVersionKey)
      ? json[kSchemaVersionKey]
      : 0;
  if (version is! int || version < 0) {
    throw FormatException('Invalid database schemaVersion: $version');
  }
  if (version > kCurrentDatabaseSchemaVersion) {
    throw FormatException('Unsupported database schemaVersion: $version');
  }

  final migrated = Map<String, dynamic>.from(json);
  if (version == 0) {
    for (final table in tables.entries) {
      if (!migrated.containsKey(table.key)) continue;
      final records = migrated[table.key];
      if (records is! Map<String, dynamic>) {
        throw FormatException('Invalid collection: ${table.key}');
      }
      migrated[table.key] = records.map((id, value) {
        if (value is! Map<String, dynamic>) {
          throw FormatException('Invalid record: ${table.key}.$id');
        }
        final record = Map<String, dynamic>.from(value);
        for (final field in table.value.entries) {
          if (!record.containsKey(field.key)) continue;
          if (record.containsKey(field.value)) {
            throw FormatException(
              'Conflicting keys in ${table.key}.$id: '
              '${field.key} and ${field.value}',
            );
          }
          record[field.value] = record.remove(field.key);
        }
        return MapEntry(id, record);
      });
    }
  }
  migrated[kSchemaVersionKey] = kCurrentDatabaseSchemaVersion;
  return migrated;
}

const _kInfoVersion0Keys = <String, Map<String, String>>{
  'artifacts': {
    '1pc': 'pc1',
    '2pc': 'pc2',
    '4pc': 'pc4',
    'list_pieces': 'pieces',
  },
  'banners': {
    'date_start': 'dateStart',
    'date_end': 'dateEnd',
    'feature_4': 'feature4',
    'feature_5': 'feature5',
  },
  'battlepass': {
    'namecard_id': 'namecardId',
    'date_start': 'dateStart',
    'date_end': 'dateEnd',
  },
  'characters': {
    'enka_id': 'enkaId',
    'namecard_id': 'namecardId',
    'special_dish': 'specialDish',
    'release_date': 'releaseDate',
    'full_image': 'fullImage',
    'constellation_image': 'constellationImage',
    'mat_gem': 'gemMaterial',
    'mat_boss': 'bossMaterial',
    'mat_common': 'commonMaterial',
    'mat_region': 'regionMaterial',
    'mat_talent': 'talentMaterial',
    'mat_weekly': 'weeklyMaterial',
    'asc_stat_type': 'ascStatType',
    'asc_hp_value': 'ascHpValue',
    'asc_atk_value': 'ascAtkValue',
    'asc_def_value': 'ascDefValue',
    'asc_stat_value': 'ascStatValue',
    'tal_a_const': 'talentAConstellation',
    'tal_e_const': 'talentEConstellation',
    'tal_q_const': 'talentQConstellation',
  },
  'characters_outfits': {'side_image': 'sideImage', 'full_image': 'fullImage'},
  'echos': {'desc': 'description'},
  'events': {
    'date_start': 'dateStart',
    'date_end': 'dateEnd',
    'rewards_other': 'rewardsOther',
    'rewards_weapons': 'rewardsWeapons',
    'rewards_characters': 'rewardsCharacters',
  },
  'lunar_arcana': {'desc': 'description'},
  'namecards': {'full_image': 'fullImage'},
  'recipes': {
    'effect_desc': 'effectDesc',
    'base_recipe': 'baseRecipe',
    'list_ingredients': 'ingredients',
  },
  'spincrystals': {'image_source': 'imageSource'},
  'versions': {'release_date': 'releaseDate'},
  'weapons': {
    'image_asc': 'imageAsc',
    'stat_type': 'statType',
    'effect_name': 'effectName',
    'effect_desc': 'effectDesc',
    'mat_weapon': 'matWeapon',
    'mat_common': 'matCommon',
    'mat_elite': 'matElite',
    'asc_atk_value': 'ascAtkValue',
    'asc_stat_value': 'ascStatValue',
  },
};

const _kSaveVersion0Keys = <String, Map<String, String>>{
  'account': {
    'mon_thu_char': 'monThuChar',
    'tue_fri_char': 'tueFriChar',
    'wed_sat_char': 'wedSatChar',
  },
  'event_rewards': {
    'obtained_weapons': 'obtainedWeapons',
    'obtained_characters': 'obtainedCharacters',
  },
  'user_configs': {
    'avatar_id': 'avatarId',
    'world_level': 'worldLevel',
    'namecard': 'namecardId',
    'tower_floor': 'towerFloor',
    'tower_chamber': 'towerChamber',
    'tower_stars': 'towerStars',
    'theater_act': 'theaterAct',
    'theater_mode': 'theaterMode',
    'theater_stars': 'theaterStars',
    'stygian_index': 'stygianIndex',
    'stygian_seconds': 'stygianSeconds',
  },
  'wishes': {'item': 'itemId', 'banner': 'bannerId'},
};
