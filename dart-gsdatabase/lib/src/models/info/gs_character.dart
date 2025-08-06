import 'package:gsdatabase/gsdatabase.dart';
import 'package:gsdatabase/src/models/gs_model.dart';

part 'gs_character.g.dart';

@BuilderGenerator()
abstract class _GsCharacter extends GsModel<GsCharacter> with GsVersionable {
  @BuilderWire('enka_id')
  String get enkaId;
  @BuilderWire('name')
  String get name;
  @BuilderWire('namecard_id')
  String get namecardId;
  @BuilderWire('title')
  String get title;
  @BuilderWire('rarity')
  int get rarity;
  @BuilderWire('region')
  GeRegionType get region;
  @BuilderWire('weapon')
  GeWeaponType get weapon;
  @BuilderWire('element')
  GeElementType get element;
  @override
  @BuilderWire('version')
  String get version;
  @BuilderWire('source')
  GeItemSourceType get source;
  @BuilderWire('description')
  String get description;
  @BuilderWire('constellation')
  String get constellation;
  @BuilderWire('affiliation')
  String get affiliation;
  @BuilderWire('special_dish')
  String get specialDish;
  @BuilderWire('birthday')
  DateTime get birthday;
  @BuilderWire('release_date')
  DateTime get releaseDate;
  @BuilderWire('image')
  String get image;
  @BuilderWire('full_image')
  String get fullImage;
  @BuilderWire('constellation_image')
  String get constellationImage;
  @BuilderWire('mat_gem')
  String get gemMaterial;
  @BuilderWire('mat_boss')
  String get bossMaterial;
  @BuilderWire('mat_common')
  String get commonMaterial;
  @BuilderWire('mat_region')
  String get regionMaterial;
  @BuilderWire('mat_talent')
  String get talentMaterial;
  @BuilderWire('mat_weekly')
  String get weeklyMaterial;
  @BuilderWire('asc_stat_type')
  GeCharacterAscStatType get ascStatType;
  @BuilderWire('asc_hp_value')
  int get ascHpValue;
  @BuilderWire('asc_atk_value')
  int get ascAtkValue;
  @BuilderWire('asc_def_value')
  int get ascDefValue;
  @BuilderWire('asc_stat_value')
  double get ascStatValue;
  @BuilderWire('tal_a_const', value: -1)
  int get talentAConstellation;
  @BuilderWire('tal_e_const', value: -1)
  int get talentEConstellation;
  @BuilderWire('tal_q_const', value: -1)
  int get talentQConstellation;

  @override
  Iterable<Comparable Function(GsCharacter e)> get sorters => [
        (e) => e.rarity,
      ];
}
