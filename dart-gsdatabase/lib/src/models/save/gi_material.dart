import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_material.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiMaterial({@override final String id = '', final int amount = 0})
    extends GsModel<GiMaterial> {
  static const kTableKey = 'materials';

  factory GiMaterial.fromJson(JsonMap json) => _$GiMaterialFromJson(json);

  @override
  JsonMap toJson() => _$GiMaterialToJson(this);
}
