// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_player_info.dart';

// **************************************************************************
// Generator: BuilderGeneratorGen
// **************************************************************************

class GiPlayerInfo extends _GiPlayerInfo {
  @override
  final String id;
  @override
  final String uid;
  @override
  final String avatarId;
  @override
  final String nickname;
  @override
  final String signature;
  @override
  final int level;
  @override
  final int worldLevel;
  @override
  final int namecardId;
  @override
  final int achievements;
  @override
  final int towerFloor;
  @override
  final int towerChamber;
  @override
  final int towerStars;
  @override
  final int theaterAct;
  @override
  final int theaterMode;
  @override
  final int theaterStars;
  @override
  final int stygianIndex;
  @override
  final int stygianSeconds;
  @override
  final Map<String, int> avatars;

  /// Creates a new [GiPlayerInfo] instance.
  GiPlayerInfo({
    required this.id,
    required this.uid,
    required this.avatarId,
    required this.nickname,
    required this.signature,
    required this.level,
    required this.worldLevel,
    required this.namecardId,
    required this.achievements,
    required this.towerFloor,
    required this.towerChamber,
    required this.towerStars,
    required this.theaterAct,
    required this.theaterMode,
    required this.theaterStars,
    required this.stygianIndex,
    required this.stygianSeconds,
    required this.avatars,
  });

  /// Creates a new [GiPlayerInfo] instance from the given map.
  GiPlayerInfo.fromJson(JsonMap m)
    : id = m['id'] as String? ?? '',
      uid = m['uid'] as String? ?? '',
      avatarId = m['avatar_id'] as String? ?? '',
      nickname = m['nickname'] as String? ?? '',
      signature = m['signature'] as String? ?? '',
      level = m['level'] as int? ?? 0,
      worldLevel = m['world_level'] as int? ?? 0,
      namecardId = m['namecard'] as int? ?? 0,
      achievements = m['achievements'] as int? ?? 0,
      towerFloor = m['tower_floor'] as int? ?? 0,
      towerChamber = m['tower_chamber'] as int? ?? 0,
      towerStars = m['tower_stars'] as int? ?? 0,
      theaterAct = m['theater_act'] as int? ?? 0,
      theaterMode = m['theater_mode'] as int? ?? 0,
      theaterStars = m['theater_stars'] as int? ?? 0,
      stygianIndex = m['stygian_index'] as int? ?? 0,
      stygianSeconds = m['stygian_seconds'] as int? ?? 0,
      avatars = (m['avatars'] as Map? ?? const {}).cast<String, int>();

  /// Copies this model with the given parameters.
  @override
  GiPlayerInfo copyWith({
    String? id,
    String? uid,
    String? avatarId,
    String? nickname,
    String? signature,
    int? level,
    int? worldLevel,
    int? namecardId,
    int? achievements,
    int? towerFloor,
    int? towerChamber,
    int? towerStars,
    int? theaterAct,
    int? theaterMode,
    int? theaterStars,
    int? stygianIndex,
    int? stygianSeconds,
    Map<String, int>? avatars,
  }) {
    return GiPlayerInfo(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      avatarId: avatarId ?? this.avatarId,
      nickname: nickname ?? this.nickname,
      signature: signature ?? this.signature,
      level: level ?? this.level,
      worldLevel: worldLevel ?? this.worldLevel,
      namecardId: namecardId ?? this.namecardId,
      achievements: achievements ?? this.achievements,
      towerFloor: towerFloor ?? this.towerFloor,
      towerChamber: towerChamber ?? this.towerChamber,
      towerStars: towerStars ?? this.towerStars,
      theaterAct: theaterAct ?? this.theaterAct,
      theaterMode: theaterMode ?? this.theaterMode,
      theaterStars: theaterStars ?? this.theaterStars,
      stygianIndex: stygianIndex ?? this.stygianIndex,
      stygianSeconds: stygianSeconds ?? this.stygianSeconds,
      avatars: avatars ?? this.avatars,
    );
  }

  /// Creates a [JsonMap] from this model.
  @override
  JsonMap toMap() {
    return {
      'id': id,
      'uid': uid,
      'avatar_id': avatarId,
      'nickname': nickname,
      'signature': signature,
      'level': level,
      'world_level': worldLevel,
      'namecard': namecardId,
      'achievements': achievements,
      'tower_floor': towerFloor,
      'tower_chamber': towerChamber,
      'tower_stars': towerStars,
      'theater_act': theaterAct,
      'theater_mode': theaterMode,
      'theater_stars': theaterStars,
      'stygian_index': stygianIndex,
      'stygian_seconds': stygianSeconds,
      'avatars': avatars,
    };
  }
}
