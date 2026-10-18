import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeGenderType implements GeEnum {
  none('none'),
  male('male'),
  female('female');

  @override
  final String id;
  const GeGenderType(this.id);
}
