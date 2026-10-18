import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_envisaged_echo.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsEnvisagedEcho({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final String description = '',
  final String character = '',
  final int rarity = 0,
  final String icon = '',
}) extends GsModel<GsEnvisagedEcho> with GsVersionable {
  static const kTableKey = 'echos';

  factory GsEnvisagedEcho.fromJson(JsonMap json) =>
      _$GsEnvisagedEchoFromJson(json);

  @override
  JsonMap toJson() => _$GsEnvisagedEchoToJson(this);
}
