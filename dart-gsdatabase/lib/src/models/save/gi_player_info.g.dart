// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_player_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiPlayerInfoCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiPlayerInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  GiPlayerInfo call({
    String id,
    String uid,
    String avatarId,
    String nickname,
    String signature,
    int level,
    int worldLevel,
    int namecardId,
    int achievements,
    int towerFloor,
    int towerChamber,
    int towerStars,
    int theaterAct,
    int theaterMode,
    int theaterStars,
    int stygianIndex,
    int stygianSeconds,
    Map<String, int> avatars,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiPlayerInfo.copyWith(...)`.
class _$GiPlayerInfoCWProxyImpl implements _$GiPlayerInfoCWProxy {
  const _$GiPlayerInfoCWProxyImpl(this._value);

  final GiPlayerInfo _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiPlayerInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiPlayerInfo call({
    Object? id = const $CopyWithPlaceholder(),
    Object? uid = const $CopyWithPlaceholder(),
    Object? avatarId = const $CopyWithPlaceholder(),
    Object? nickname = const $CopyWithPlaceholder(),
    Object? signature = const $CopyWithPlaceholder(),
    Object? level = const $CopyWithPlaceholder(),
    Object? worldLevel = const $CopyWithPlaceholder(),
    Object? namecardId = const $CopyWithPlaceholder(),
    Object? achievements = const $CopyWithPlaceholder(),
    Object? towerFloor = const $CopyWithPlaceholder(),
    Object? towerChamber = const $CopyWithPlaceholder(),
    Object? towerStars = const $CopyWithPlaceholder(),
    Object? theaterAct = const $CopyWithPlaceholder(),
    Object? theaterMode = const $CopyWithPlaceholder(),
    Object? theaterStars = const $CopyWithPlaceholder(),
    Object? stygianIndex = const $CopyWithPlaceholder(),
    Object? stygianSeconds = const $CopyWithPlaceholder(),
    Object? avatars = const $CopyWithPlaceholder(),
  }) {
    return GiPlayerInfo(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      uid: uid == const $CopyWithPlaceholder() || uid == null
          ? _value.uid
          // ignore: cast_nullable_to_non_nullable
          : uid as String,
      avatarId: avatarId == const $CopyWithPlaceholder() || avatarId == null
          ? _value.avatarId
          // ignore: cast_nullable_to_non_nullable
          : avatarId as String,
      nickname: nickname == const $CopyWithPlaceholder() || nickname == null
          ? _value.nickname
          // ignore: cast_nullable_to_non_nullable
          : nickname as String,
      signature: signature == const $CopyWithPlaceholder() || signature == null
          ? _value.signature
          // ignore: cast_nullable_to_non_nullable
          : signature as String,
      level: level == const $CopyWithPlaceholder() || level == null
          ? _value.level
          // ignore: cast_nullable_to_non_nullable
          : level as int,
      worldLevel:
          worldLevel == const $CopyWithPlaceholder() || worldLevel == null
          ? _value.worldLevel
          // ignore: cast_nullable_to_non_nullable
          : worldLevel as int,
      namecardId:
          namecardId == const $CopyWithPlaceholder() || namecardId == null
          ? _value.namecardId
          // ignore: cast_nullable_to_non_nullable
          : namecardId as int,
      achievements:
          achievements == const $CopyWithPlaceholder() || achievements == null
          ? _value.achievements
          // ignore: cast_nullable_to_non_nullable
          : achievements as int,
      towerFloor:
          towerFloor == const $CopyWithPlaceholder() || towerFloor == null
          ? _value.towerFloor
          // ignore: cast_nullable_to_non_nullable
          : towerFloor as int,
      towerChamber:
          towerChamber == const $CopyWithPlaceholder() || towerChamber == null
          ? _value.towerChamber
          // ignore: cast_nullable_to_non_nullable
          : towerChamber as int,
      towerStars:
          towerStars == const $CopyWithPlaceholder() || towerStars == null
          ? _value.towerStars
          // ignore: cast_nullable_to_non_nullable
          : towerStars as int,
      theaterAct:
          theaterAct == const $CopyWithPlaceholder() || theaterAct == null
          ? _value.theaterAct
          // ignore: cast_nullable_to_non_nullable
          : theaterAct as int,
      theaterMode:
          theaterMode == const $CopyWithPlaceholder() || theaterMode == null
          ? _value.theaterMode
          // ignore: cast_nullable_to_non_nullable
          : theaterMode as int,
      theaterStars:
          theaterStars == const $CopyWithPlaceholder() || theaterStars == null
          ? _value.theaterStars
          // ignore: cast_nullable_to_non_nullable
          : theaterStars as int,
      stygianIndex:
          stygianIndex == const $CopyWithPlaceholder() || stygianIndex == null
          ? _value.stygianIndex
          // ignore: cast_nullable_to_non_nullable
          : stygianIndex as int,
      stygianSeconds:
          stygianSeconds == const $CopyWithPlaceholder() ||
              stygianSeconds == null
          ? _value.stygianSeconds
          // ignore: cast_nullable_to_non_nullable
          : stygianSeconds as int,
      avatars: avatars == const $CopyWithPlaceholder() || avatars == null
          ? _value.avatars
          // ignore: cast_nullable_to_non_nullable
          : avatars as Map<String, int>,
    );
  }
}

extension $GiPlayerInfoCopyWith on GiPlayerInfo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiPlayerInfo.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiPlayerInfoCWProxy get copyWith => _$GiPlayerInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiPlayerInfo _$GiPlayerInfoFromJson(Map<String, dynamic> json) => GiPlayerInfo(
  id: json['id'] as String? ?? '',
  uid: json['uid'] as String? ?? '',
  avatarId: json['avatarId'] as String? ?? '',
  nickname: json['nickname'] as String? ?? '',
  signature: json['signature'] as String? ?? '',
  level: (json['level'] as num?)?.toInt() ?? 0,
  worldLevel: (json['worldLevel'] as num?)?.toInt() ?? 0,
  namecardId: (json['namecardId'] as num?)?.toInt() ?? 0,
  achievements: (json['achievements'] as num?)?.toInt() ?? 0,
  towerFloor: (json['towerFloor'] as num?)?.toInt() ?? 0,
  towerChamber: (json['towerChamber'] as num?)?.toInt() ?? 0,
  towerStars: (json['towerStars'] as num?)?.toInt() ?? 0,
  theaterAct: (json['theaterAct'] as num?)?.toInt() ?? 0,
  theaterMode: (json['theaterMode'] as num?)?.toInt() ?? 0,
  theaterStars: (json['theaterStars'] as num?)?.toInt() ?? 0,
  stygianIndex: (json['stygianIndex'] as num?)?.toInt() ?? 0,
  stygianSeconds: (json['stygianSeconds'] as num?)?.toInt() ?? 0,
  avatars:
      (json['avatars'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
);

Map<String, dynamic> _$GiPlayerInfoToJson(GiPlayerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'avatarId': instance.avatarId,
      'nickname': instance.nickname,
      'signature': instance.signature,
      'level': instance.level,
      'worldLevel': instance.worldLevel,
      'namecardId': instance.namecardId,
      'achievements': instance.achievements,
      'towerFloor': instance.towerFloor,
      'towerChamber': instance.towerChamber,
      'towerStars': instance.towerStars,
      'theaterAct': instance.theaterAct,
      'theaterMode': instance.theaterMode,
      'theaterStars': instance.theaterStars,
      'stygianIndex': instance.stygianIndex,
      'stygianSeconds': instance.stygianSeconds,
      'avatars': instance.avatars,
    };
