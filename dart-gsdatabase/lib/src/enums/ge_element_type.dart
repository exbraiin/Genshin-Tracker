import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeElementType implements GeEnum {
  none('none'),
  anemo('anemo'),
  geo('geo'),
  electro('electro'),
  dendro('dendro'),
  hydro('hydro'),
  pyro('pyro'),
  cryo('cryo');

  @override
  final String id;
  const GeElementType(this.id);
}
