import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_achievement_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_achievement.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsAchievement({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final String group = '',
  final bool hidden = false,
  @JsonKey(unknownEnumValue: GeAchievementType.none)
  final GeAchievementType type = GeAchievementType.none,
  final List<GsAchievementPhase> phases = const [],
}) extends GsModel<GsAchievement> with GsVersionable {
  static const kTableKey = 'achievements';

  factory GsAchievement.fromJson(JsonMap json) => _$GsAchievementFromJson(json);

  @override
  JsonMap toJson() => _$GsAchievementToJson(this);

  @override
  Iterable<Comparable Function(GsAchievement e)> get sorters => [
    (e) => e.version,
  ];
}

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsAchievementPhase({
  @override final String id = '',
  final String desc = '',
  final int reward = 0,
}) extends GsModel<GsAchievementPhase> {
  factory GsAchievementPhase.fromJson(JsonMap json) =>
      _$GsAchievementPhaseFromJson(json);

  @override
  JsonMap toJson() => _$GsAchievementPhaseToJson(this);
}
