import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_furniture_chest.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiFurnitureChest({@override final String id = ''})
    extends GsModel<GiFurnitureChest> {
  static const kTableKey = 'remarkable_chests';

  factory GiFurnitureChest.fromJson(JsonMap json) =>
      _$GiFurnitureChestFromJson(json);

  @override
  JsonMap toMap() => _$GiFurnitureChestToJson(this);
}
