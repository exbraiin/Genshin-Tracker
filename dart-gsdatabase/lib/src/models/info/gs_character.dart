import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_character_asc_stat_type.dart';
import 'package:gsdatabase/src/enums/ge_element_type.dart';
import 'package:gsdatabase/src/enums/ge_item_source_type.dart';
import 'package:gsdatabase/src/enums/ge_region_type.dart';
import 'package:gsdatabase/src/enums/ge_weapon_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_character.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsCharacter({
  @override final String id = '',
  @override final String version = '',
  final String enkaId = '',
  final String name = '',
  final String namecardId = '',
  final String title = '',
  final int rarity = 0,
  @JsonKey(unknownEnumValue: GeRegionType.none)
  final GeRegionType region = GeRegionType.none,
  @JsonKey(unknownEnumValue: GeWeaponType.none)
  final GeWeaponType weapon = GeWeaponType.none,
  @JsonKey(unknownEnumValue: GeElementType.none)
  final GeElementType element = GeElementType.none,
  @JsonKey(unknownEnumValue: GeItemSourceType.none)
  final GeItemSourceType source = GeItemSourceType.none,
  final String description = '',
  final String constellation = '',
  final String affiliation = '',
  final String specialDish = '',
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime birthday,
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime releaseDate,
  final String image = '',
  final String fullImage = '',
  final String constellationImage = '',
  final String gemMaterial = '',
  final String bossMaterial = '',
  final String commonMaterial = '',
  final String regionMaterial = '',
  final String talentMaterial = '',
  final String weeklyMaterial = '',
  @JsonKey(unknownEnumValue: GeCharacterAscStatType.none)
  final GeCharacterAscStatType ascStatType = GeCharacterAscStatType.none,
  final int ascHpValue = 0,
  final int ascAtkValue = 0,
  final int ascDefValue = 0,
  final double ascStatValue = 0,
  final int talentAConstellation = -1,
  final int talentEConstellation = -1,
  final int talentQConstellation = -1,
}) extends GsModel<GsCharacter> with GsVersionable {
  static const kTableKey = 'characters';

  factory GsCharacter.fromJson(JsonMap json) => _$GsCharacterFromJson(json);

  @override
  JsonMap toJson() => _$GsCharacterToJson(this);

  @override
  Iterable<Comparable Function(GsCharacter e)> get sorters => [(e) => e.rarity];
}
