import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_thespian_trick.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiThespianTrick({@override final String id = ''})
    extends GsModel<GiThespianTrick> {
  static const kTableKey = 'thespian';

  factory GiThespianTrick.fromJson(JsonMap json) =>
      _$GiThespianTrickFromJson(json);

  @override
  JsonMap toMap() => _$GiThespianTrickToJson(this);
}
