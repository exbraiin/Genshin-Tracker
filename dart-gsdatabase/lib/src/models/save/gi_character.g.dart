// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_character.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiCharacterCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiCharacter(...).copyWith(id: 12, name: "My name")
  /// ```
  GiCharacter call({
    String id,
    int ascension,
    int friendship,
    int talent1,
    int talent2,
    int talent3,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiCharacter.copyWith(...)`.
class _$GiCharacterCWProxyImpl implements _$GiCharacterCWProxy {
  const _$GiCharacterCWProxyImpl(this._value);

  final GiCharacter _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiCharacter(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiCharacter call({
    Object? id = const $CopyWithPlaceholder(),
    Object? ascension = const $CopyWithPlaceholder(),
    Object? friendship = const $CopyWithPlaceholder(),
    Object? talent1 = const $CopyWithPlaceholder(),
    Object? talent2 = const $CopyWithPlaceholder(),
    Object? talent3 = const $CopyWithPlaceholder(),
  }) {
    return GiCharacter(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      ascension: ascension == const $CopyWithPlaceholder() || ascension == null
          ? _value.ascension
          // ignore: cast_nullable_to_non_nullable
          : ascension as int,
      friendship:
          friendship == const $CopyWithPlaceholder() || friendship == null
          ? _value.friendship
          // ignore: cast_nullable_to_non_nullable
          : friendship as int,
      talent1: talent1 == const $CopyWithPlaceholder() || talent1 == null
          ? _value.talent1
          // ignore: cast_nullable_to_non_nullable
          : talent1 as int,
      talent2: talent2 == const $CopyWithPlaceholder() || talent2 == null
          ? _value.talent2
          // ignore: cast_nullable_to_non_nullable
          : talent2 as int,
      talent3: talent3 == const $CopyWithPlaceholder() || talent3 == null
          ? _value.talent3
          // ignore: cast_nullable_to_non_nullable
          : talent3 as int,
    );
  }
}

extension $GiCharacterCopyWith on GiCharacter {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiCharacter.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiCharacterCWProxy get copyWith => _$GiCharacterCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiCharacter _$GiCharacterFromJson(Map<String, dynamic> json) => GiCharacter(
  id: json['id'] as String? ?? '',
  ascension: (json['ascension'] as num?)?.toInt() ?? 0,
  friendship: (json['friendship'] as num?)?.toInt() ?? 1,
  talent1: (json['talent1'] as num?)?.toInt() ?? 1,
  talent2: (json['talent2'] as num?)?.toInt() ?? 1,
  talent3: (json['talent3'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$GiCharacterToJson(GiCharacter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ascension': instance.ascension,
      'friendship': instance.friendship,
      'talent1': instance.talent1,
      'talent2': instance.talent2,
      'talent3': instance.talent3,
    };
