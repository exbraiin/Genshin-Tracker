import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeEventType implements GeEnum {
  none('none'),
  quest('quest'),
  event('event'),
  login('login'),
  flagship('flagship'),
  permanent('permanent');

  @override
  final String id;
  const GeEventType(this.id);
}
