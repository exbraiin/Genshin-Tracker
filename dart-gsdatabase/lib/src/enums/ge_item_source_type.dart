import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeItemSourceType implements GeEnum {
  none('none'),
  shop('shop'),
  event('event'),
  fishing('fishing'),
  forging('forging'),
  battlepass('battlepass'),
  exploration('exploration'),
  wishesStandard('wishes_standard'),
  wishesWeaponBanner('wishes_weapon_banner'),
  wishesCharacterBanner('wishes_character_banner');

  @override
  final String id;
  const GeItemSourceType(this.id);
}
