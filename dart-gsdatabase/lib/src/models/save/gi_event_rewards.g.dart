// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_event_rewards.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiEventRewardsCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiEventRewards(...).copyWith(id: 12, name: "My name")
  /// ```
  GiEventRewards call({
    String id,
    List<String> obtainedWeapons,
    List<String> obtainedCharacters,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiEventRewards.copyWith(...)`.
class _$GiEventRewardsCWProxyImpl implements _$GiEventRewardsCWProxy {
  const _$GiEventRewardsCWProxyImpl(this._value);

  final GiEventRewards _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiEventRewards(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiEventRewards call({
    Object? id = const $CopyWithPlaceholder(),
    Object? obtainedWeapons = const $CopyWithPlaceholder(),
    Object? obtainedCharacters = const $CopyWithPlaceholder(),
  }) {
    return GiEventRewards(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      obtainedWeapons:
          obtainedWeapons == const $CopyWithPlaceholder() ||
              obtainedWeapons == null
          ? _value.obtainedWeapons
          // ignore: cast_nullable_to_non_nullable
          : obtainedWeapons as List<String>,
      obtainedCharacters:
          obtainedCharacters == const $CopyWithPlaceholder() ||
              obtainedCharacters == null
          ? _value.obtainedCharacters
          // ignore: cast_nullable_to_non_nullable
          : obtainedCharacters as List<String>,
    );
  }
}

extension $GiEventRewardsCopyWith on GiEventRewards {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiEventRewards.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiEventRewardsCWProxy get copyWith => _$GiEventRewardsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiEventRewards _$GiEventRewardsFromJson(Map<String, dynamic> json) =>
    GiEventRewards(
      id: json['id'] as String? ?? '',
      obtainedWeapons:
          (json['obtainedWeapons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      obtainedCharacters:
          (json['obtainedCharacters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GiEventRewardsToJson(GiEventRewards instance) =>
    <String, dynamic>{
      'id': instance.id,
      'obtainedWeapons': instance.obtainedWeapons,
      'obtainedCharacters': instance.obtainedCharacters,
    };
