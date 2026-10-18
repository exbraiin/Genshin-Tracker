import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeRecipeType implements GeEnum {
  none('none'),
  event('event'),
  permanent('permanent');

  @override
  final String id;
  const GeRecipeType(this.id);
}
