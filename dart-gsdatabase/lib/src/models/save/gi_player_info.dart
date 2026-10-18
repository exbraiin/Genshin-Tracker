import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_player_info.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiPlayerInfo({
  @override final String id = '',
  final String uid = '',
  final String avatarId = '',
  final String nickname = '',
  final String signature = '',
  final int level = 0,
  final int worldLevel = 0,
  final int namecardId = 0,
  final int achievements = 0,
  final int towerFloor = 0,
  final int towerChamber = 0,
  final int towerStars = 0,
  final int theaterAct = 0,
  final int theaterMode = 0,
  final int theaterStars = 0,
  final int stygianIndex = 0,
  final int stygianSeconds = 0,
  final Map<String, int> avatars = const {},
}) extends GsModel<GiPlayerInfo> {
  static const kTableKey = 'user_configs';

  factory GiPlayerInfo.fromJson(JsonMap json) => _$GiPlayerInfoFromJson(json);

  @override
  JsonMap toMap() => _$GiPlayerInfoToJson(this);
}
