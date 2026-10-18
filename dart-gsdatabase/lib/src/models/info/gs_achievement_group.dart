import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_achievement_group.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsAchievementGroup({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final String icon = '',
  final String namecard = '',
  final int order = 0,
  final int rewards = 0,
  final int achievements = 0,
}) extends GsModel<GsAchievementGroup> with GsVersionable {
  static const kTableKey = 'achievement_categories';

  factory GsAchievementGroup.fromJson(JsonMap json) =>
      _$GsAchievementGroupFromJson(json);

  @override
  JsonMap toMap() => _$GsAchievementGroupToJson(this);
}
