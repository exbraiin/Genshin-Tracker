import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeBannerType implements GeEnum {
  standard('standard'),
  beginner('beginner'),
  character('character'),
  weapon('weapon'),
  chronicled('chronicled');

  bool get isPermanent =>
      this == GeBannerType.standard || this == GeBannerType.beginner;

  @override
  final String id;
  const GeBannerType(this.id);
}
