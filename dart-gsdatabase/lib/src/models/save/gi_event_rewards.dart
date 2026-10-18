import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_event_rewards.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiEventRewards({
  @override final String id = '',
  final List<String> obtainedWeapons = const [],
  final List<String> obtainedCharacters = const [],
}) extends GsModel<GiEventRewards> {
  static const kTableKey = 'event_rewards';

  factory GiEventRewards.fromJson(JsonMap json) =>
      _$GiEventRewardsFromJson(json);

  @override
  JsonMap toJson() => _$GiEventRewardsToJson(this);
}
