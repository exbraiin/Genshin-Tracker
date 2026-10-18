import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeWeekdayType implements GeEnum {
  sunday('Sunday'),
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday');

  @override
  final String id;
  const GeWeekdayType(this.id);
}
