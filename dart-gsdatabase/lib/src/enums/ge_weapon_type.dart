import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeWeaponType implements GeEnum {
  none('none'),
  bow('bow'),
  sword('sword'),
  polearm('polearm'),
  catalyst('catalyst'),
  claymore('claymore');

  @override
  final String id;
  const GeWeaponType(this.id);
}
