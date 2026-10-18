import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeRecipeEffectType implements GeEnum {
  none('none'),
  recoveryHPAll('recoveryHPAll'),
  recoveryHP('recoveryHP'),
  revive('revive'),
  atkBoost('atkBoost'),
  staminaIncrease('staminaIncrease'),
  staminaReduction('staminaReduction'),
  atkCritBoost('atkCritBoost'),
  defBoost('defBoost'),
  adventure('adventure'),
  special('special');

  @override
  final String id;
  const GeRecipeEffectType(this.id);
}
