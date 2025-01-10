import 'package:gsdatabase/src/enums/ge_enum.dart';

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
