import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_achievement.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiAchievement({@override final String id = '', final int obtained = 0})
    extends GsModel<GiAchievement> {
  static const kTableKey = 'achievements';

  factory GiAchievement.fromJson(JsonMap json) => _$GiAchievementFromJson(json);

  @override
  JsonMap toMap() => _$GiAchievementToJson(this);
}
