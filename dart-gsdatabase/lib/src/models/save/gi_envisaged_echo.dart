import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_envisaged_echo.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiEnvisagedEcho({@override final String id = ''})
    extends GsModel<GiEnvisagedEcho> {
  static const kTableKey = 'echoes';

  factory GiEnvisagedEcho.fromJson(JsonMap json) =>
      _$GiEnvisagedEchoFromJson(json);

  @override
  JsonMap toJson() => _$GiEnvisagedEchoToJson(this);
}
