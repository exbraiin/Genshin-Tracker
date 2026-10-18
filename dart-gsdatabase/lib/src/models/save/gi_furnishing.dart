import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_furnishing.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiFurnishing({@override final String id = '', final int amount = 0})
    extends GsModel<GiFurnishing> {
  static const kTableKey = 'furnishing';

  factory GiFurnishing.fromJson(JsonMap json) => _$GiFurnishingFromJson(json);

  @override
  JsonMap toJson() => _$GiFurnishingToJson(this);
}
