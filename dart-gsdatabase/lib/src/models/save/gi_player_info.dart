import 'package:gsdatabase/src/models/gs_model.dart';

part 'gi_player_info.g.dart';

@BuilderGenerator()
abstract class _GiPlayerInfo extends GsModel<GiPlayerInfo> {
  @BuilderWire('uid')
  String get uid;
  @BuilderWire('avatar_id')
  String get avatarId;
  @BuilderWire('nickname')
  String get nickname;
  @BuilderWire('signature')
  String get signature;
  @BuilderWire('level')
  int get level;
  @BuilderWire('world_level')
  int get worldLevel;
  @BuilderWire('namecard')
  int get namecardId;
  @BuilderWire('achievements')
  int get achievements;
  @BuilderWire('tower_floor')
  int get towerFloor;
  @BuilderWire('tower_chamber')
  int get towerChamber;
  @BuilderWire('tower_stars')
  int get towerStars;
  @BuilderWire('theater_act')
  int get theaterAct;
  @BuilderWire('theater_mode')
  int get theaterMode;
  @BuilderWire('theater_stars')
  int get theaterStars;
  @BuilderWire('stygian_index')
  int get stygianIndex;
  @BuilderWire('stygian_seconds')
  int get stygianSeconds;
  @BuilderWire('avatars')
  Map<String, int> get avatars;
}
