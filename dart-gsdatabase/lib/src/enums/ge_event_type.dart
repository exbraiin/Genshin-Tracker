import 'package:gsdatabase/src/enums/ge_enum.dart';

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
