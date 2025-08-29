import 'package:gsdatabase/src/enums/ge_enum.dart';

enum GeRegionType implements GeEnum {
  none('none'),
  mondstadt('mondstadt'),
  liyue('liyue'),
  inazuma('inazuma'),
  sumeru('sumeru'),
  fontaine('fontaine'),
  natlan('natlan'),
  nodkrai('nodkrai'),
  snezhnaya('snezhnaya');

  @override
  final String id;
  const GeRegionType(this.id);
}
