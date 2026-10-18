import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_spincrystal.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiSpincrystal({@override final String id = ''})
    extends GsModel<GiSpincrystal> {
  static const kTableKey = 'spincrystals';

  factory GiSpincrystal.fromJson(JsonMap json) => _$GiSpincrystalFromJson(json);

  @override
  JsonMap toMap() => _$GiSpincrystalToJson(this);
}
