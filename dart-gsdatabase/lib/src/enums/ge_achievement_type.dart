import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeAchievementType implements GeEnum {
  none('none'),
  exploration('exploration'),
  quest('quest'),
  commission('commission'),
  boss('boss');

  @override
  final String id;
  const GeAchievementType(this.id);
}
