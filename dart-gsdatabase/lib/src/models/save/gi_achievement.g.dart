// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_achievement.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiAchievementCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiAchievement(...).copyWith(id: 12, name: "My name")
  /// ```
  GiAchievement call({String id, int obtained});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiAchievement.copyWith(...)`.
class _$GiAchievementCWProxyImpl implements _$GiAchievementCWProxy {
  const _$GiAchievementCWProxyImpl(this._value);

  final GiAchievement _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiAchievement(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiAchievement call({
    Object? id = const $CopyWithPlaceholder(),
    Object? obtained = const $CopyWithPlaceholder(),
  }) {
    return GiAchievement(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      obtained: obtained == const $CopyWithPlaceholder() || obtained == null
          ? _value.obtained
          // ignore: cast_nullable_to_non_nullable
          : obtained as int,
    );
  }
}

extension $GiAchievementCopyWith on GiAchievement {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiAchievement.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiAchievementCWProxy get copyWith => _$GiAchievementCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiAchievement _$GiAchievementFromJson(Map<String, dynamic> json) =>
    GiAchievement(
      id: json['id'] as String? ?? '',
      obtained: (json['obtained'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GiAchievementToJson(GiAchievement instance) =>
    <String, dynamic>{'id': instance.id, 'obtained': instance.obtained};
