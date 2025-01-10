import 'package:gsdatabase/src/enums/ge_enum.dart';

enum GeRecipeType implements GeEnum {
  none('none'),
  event('event'),
  permanent('permanent');

  @override
  final String id;
  const GeRecipeType(this.id);
}
