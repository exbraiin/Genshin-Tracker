import 'package:gsdatabase/src/enums/ge_enum.dart';

enum GeSereniteaSetType implements GeEnum {
  none('none'),
  indoor('indoor'),
  outdoor('outdoor');

  @override
  final String id;
  const GeSereniteaSetType(this.id);
}
