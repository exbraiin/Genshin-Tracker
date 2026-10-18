import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeSereniteaSetType implements GeEnum {
  none('none'),
  indoor('indoor'),
  outdoor('outdoor');

  @override
  final String id;
  const GeSereniteaSetType(this.id);
}
