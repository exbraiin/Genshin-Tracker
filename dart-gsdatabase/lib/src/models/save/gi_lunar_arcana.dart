import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_lunar_arcana.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiLunarArcana({@override final String id = ''})
    extends GsModel<GiLunarArcana> {
  static const kTableKey = 'lunar_arcana';

  factory GiLunarArcana.fromJson(JsonMap json) => _$GiLunarArcanaFromJson(json);

  @override
  JsonMap toJson() => _$GiLunarArcanaToJson(this);
}
