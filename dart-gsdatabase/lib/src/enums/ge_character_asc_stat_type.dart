import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeCharacterAscStatType implements GeEnum {
  none('none'),
  anemoDmgBonus('anemoDmgBonus'),
  geoDmgBonus('geoDmgBonus'),
  electroDmgBonus('electroDmgBonus'),
  dendroDmgBonus('dendroDmgBonus'),
  hydroDmgBonus('hydroDmgBonus'),
  pyroDmgBonus('pyroDmgBonus'),
  cryoDmgBonus('cryoDmgBonus'),
  hpPercent('hpPercent'),
  atkPercent('atkPercent'),
  defPercent('defPercent'),
  critDmg('critDmg'),
  critRate('critRate'),
  healing('healing'),
  physicalDmg('physicalDmg'),
  energyRecharge('energyRecharge'),
  elementalMastery('elementalMastery');

  @override
  final String id;
  const GeCharacterAscStatType(this.id);
}
