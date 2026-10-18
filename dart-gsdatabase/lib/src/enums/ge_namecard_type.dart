import 'package:gsdatabase/src/enums/ge_enum.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'id')
enum GeNamecardType implements GeEnum {
  none('none'),
  achievement('achievement'),
  battlepass('battlepass'),
  character('character'),
  defaults('default'),
  event('event'),
  offering('offering'),
  reputation('reputation');

  @override
  final String id;
  const GeNamecardType(this.id);
}
