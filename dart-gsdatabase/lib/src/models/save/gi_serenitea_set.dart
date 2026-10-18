import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_serenitea_set.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiSereniteaSet({
  @override final String id = '',
  final List<String> chars = const [],
}) extends GsModel<GiSereniteaSet> {
  static const kTableKey = 'serenitea_sets';

  factory GiSereniteaSet.fromJson(JsonMap json) =>
      _$GiSereniteaSetFromJson(json);

  @override
  JsonMap toJson() => _$GiSereniteaSetToJson(this);
}
