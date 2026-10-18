// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_thespian_trick.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiThespianTrickCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiThespianTrick(...).copyWith(id: 12, name: "My name")
  /// ```
  GiThespianTrick call({String id});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiThespianTrick.copyWith(...)`.
class _$GiThespianTrickCWProxyImpl implements _$GiThespianTrickCWProxy {
  const _$GiThespianTrickCWProxyImpl(this._value);

  final GiThespianTrick _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiThespianTrick(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiThespianTrick call({Object? id = const $CopyWithPlaceholder()}) {
    return GiThespianTrick(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $GiThespianTrickCopyWith on GiThespianTrick {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiThespianTrick.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiThespianTrickCWProxy get copyWith => _$GiThespianTrickCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiThespianTrick _$GiThespianTrickFromJson(Map<String, dynamic> json) =>
    GiThespianTrick(id: json['id'] as String? ?? '');

Map<String, dynamic> _$GiThespianTrickToJson(GiThespianTrick instance) =>
    <String, dynamic>{'id': instance.id};
