import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_item_source_type.dart';
import 'package:gsdatabase/src/enums/ge_weapon_asc_stat_type.dart';
import 'package:gsdatabase/src/enums/ge_weapon_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_weapon.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsWeapon({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final int rarity = 0,
  final String image = '',
  final String imageAsc = '',
  @JsonKey(unknownEnumValue: GeWeaponType.none)
  final GeWeaponType type = GeWeaponType.none,
  @JsonKey(unknownEnumValue: GeWeaponAscStatType.none)
  final GeWeaponAscStatType statType = GeWeaponAscStatType.none,
  final String desc = '',
  @JsonKey(unknownEnumValue: GeItemSourceType.none)
  final GeItemSourceType source = GeItemSourceType.none,
  final String effectName = '',
  final String effectDesc = '',
  final String matWeapon = '',
  final String matCommon = '',
  final String matElite = '',
  final int ascAtkValue = 0,
  final double ascStatValue = 0,
}) extends GsModel<GsWeapon> with GsVersionable {
  static const kTableKey = 'weapons';

  factory GsWeapon.fromJson(JsonMap json) => _$GsWeaponFromJson(json);

  @override
  JsonMap toJson() => _$GsWeaponToJson(this);

  @override
  Iterable<Comparable Function(GsWeapon e)> get sorters => [(e) => e.rarity];
}
