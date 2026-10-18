// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_achievement.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsAchievementCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsAchievement(...).copyWith(id: 12, name: "My name")
  /// ```
  GsAchievement call({
    String id,
    String version,
    String name,
    String group,
    bool hidden,
    GeAchievementType type,
    List<GsAchievementPhase> phases,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsAchievement.copyWith(...)`.
class _$GsAchievementCWProxyImpl implements _$GsAchievementCWProxy {
  const _$GsAchievementCWProxyImpl(this._value);

  final GsAchievement _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsAchievement(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsAchievement call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? group = const $CopyWithPlaceholder(),
    Object? hidden = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? phases = const $CopyWithPlaceholder(),
  }) {
    return GsAchievement(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      version: version == const $CopyWithPlaceholder() || version == null
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      group: group == const $CopyWithPlaceholder() || group == null
          ? _value.group
          // ignore: cast_nullable_to_non_nullable
          : group as String,
      hidden: hidden == const $CopyWithPlaceholder() || hidden == null
          ? _value.hidden
          // ignore: cast_nullable_to_non_nullable
          : hidden as bool,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeAchievementType,
      phases: phases == const $CopyWithPlaceholder() || phases == null
          ? _value.phases
          // ignore: cast_nullable_to_non_nullable
          : phases as List<GsAchievementPhase>,
    );
  }
}

extension $GsAchievementCopyWith on GsAchievement {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsAchievement.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsAchievementCWProxy get copyWith => _$GsAchievementCWProxyImpl(this);
}

abstract class _$GsAchievementPhaseCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsAchievementPhase(...).copyWith(id: 12, name: "My name")
  /// ```
  GsAchievementPhase call({String id, String desc, int reward});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsAchievementPhase.copyWith(...)`.
class _$GsAchievementPhaseCWProxyImpl implements _$GsAchievementPhaseCWProxy {
  const _$GsAchievementPhaseCWProxyImpl(this._value);

  final GsAchievementPhase _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsAchievementPhase(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsAchievementPhase call({
    Object? id = const $CopyWithPlaceholder(),
    Object? desc = const $CopyWithPlaceholder(),
    Object? reward = const $CopyWithPlaceholder(),
  }) {
    return GsAchievementPhase(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      desc: desc == const $CopyWithPlaceholder() || desc == null
          ? _value.desc
          // ignore: cast_nullable_to_non_nullable
          : desc as String,
      reward: reward == const $CopyWithPlaceholder() || reward == null
          ? _value.reward
          // ignore: cast_nullable_to_non_nullable
          : reward as int,
    );
  }
}

extension $GsAchievementPhaseCopyWith on GsAchievementPhase {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsAchievementPhase.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsAchievementPhaseCWProxy get copyWith =>
      _$GsAchievementPhaseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsAchievement _$GsAchievementFromJson(Map<String, dynamic> json) =>
    GsAchievement(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      name: json['name'] as String? ?? '',
      group: json['group'] as String? ?? '',
      hidden: json['hidden'] as bool? ?? false,
      type:
          $enumDecodeNullable(
            _$GeAchievementTypeEnumMap,
            json['type'],
            unknownValue: GeAchievementType.none,
          ) ??
          GeAchievementType.none,
      phases:
          (json['phases'] as List<dynamic>?)
              ?.map(
                (e) => GsAchievementPhase.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GsAchievementToJson(GsAchievement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'group': instance.group,
      'hidden': instance.hidden,
      'type': _$GeAchievementTypeEnumMap[instance.type]!,
      'phases': instance.phases.map((e) => e.toJson()).toList(),
    };

const _$GeAchievementTypeEnumMap = {
  GeAchievementType.none: 'none',
  GeAchievementType.exploration: 'exploration',
  GeAchievementType.quest: 'quest',
  GeAchievementType.commission: 'commission',
  GeAchievementType.boss: 'boss',
};

GsAchievementPhase _$GsAchievementPhaseFromJson(Map<String, dynamic> json) =>
    GsAchievementPhase(
      id: json['id'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      reward: (json['reward'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GsAchievementPhaseToJson(GsAchievementPhase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'desc': instance.desc,
      'reward': instance.reward,
    };
