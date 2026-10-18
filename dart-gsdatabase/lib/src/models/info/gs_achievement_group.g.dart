// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_achievement_group.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsAchievementGroupCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsAchievementGroup(...).copyWith(id: 12, name: "My name")
  /// ```
  GsAchievementGroup call({
    String id,
    String version,
    String name,
    String icon,
    String namecard,
    int order,
    int rewards,
    int achievements,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsAchievementGroup.copyWith(...)`.
class _$GsAchievementGroupCWProxyImpl implements _$GsAchievementGroupCWProxy {
  const _$GsAchievementGroupCWProxyImpl(this._value);

  final GsAchievementGroup _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsAchievementGroup(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsAchievementGroup call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? icon = const $CopyWithPlaceholder(),
    Object? namecard = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
    Object? rewards = const $CopyWithPlaceholder(),
    Object? achievements = const $CopyWithPlaceholder(),
  }) {
    return GsAchievementGroup(
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
      icon: icon == const $CopyWithPlaceholder() || icon == null
          ? _value.icon
          // ignore: cast_nullable_to_non_nullable
          : icon as String,
      namecard: namecard == const $CopyWithPlaceholder() || namecard == null
          ? _value.namecard
          // ignore: cast_nullable_to_non_nullable
          : namecard as String,
      order: order == const $CopyWithPlaceholder() || order == null
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as int,
      rewards: rewards == const $CopyWithPlaceholder() || rewards == null
          ? _value.rewards
          // ignore: cast_nullable_to_non_nullable
          : rewards as int,
      achievements:
          achievements == const $CopyWithPlaceholder() || achievements == null
          ? _value.achievements
          // ignore: cast_nullable_to_non_nullable
          : achievements as int,
    );
  }
}

extension $GsAchievementGroupCopyWith on GsAchievementGroup {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsAchievementGroup.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsAchievementGroupCWProxy get copyWith =>
      _$GsAchievementGroupCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsAchievementGroup _$GsAchievementGroupFromJson(Map<String, dynamic> json) =>
    GsAchievementGroup(
      id: json['id'] as String? ?? '',
      version: json['version'] as String? ?? '',
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      namecard: json['namecard'] as String? ?? '',
      order: (json['order'] as num?)?.toInt() ?? 0,
      rewards: (json['rewards'] as num?)?.toInt() ?? 0,
      achievements: (json['achievements'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GsAchievementGroupToJson(GsAchievementGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'icon': instance.icon,
      'namecard': instance.namecard,
      'order': instance.order,
      'rewards': instance.rewards,
      'achievements': instance.achievements,
    };
