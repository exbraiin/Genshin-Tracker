// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_account_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiAccountInfoCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiAccountInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  GiAccountInfo call({
    String id,
    String monThuChar,
    String tueFriChar,
    String wedSatChar,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiAccountInfo.copyWith(...)`.
class _$GiAccountInfoCWProxyImpl implements _$GiAccountInfoCWProxy {
  const _$GiAccountInfoCWProxyImpl(this._value);

  final GiAccountInfo _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiAccountInfo(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiAccountInfo call({
    Object? id = const $CopyWithPlaceholder(),
    Object? monThuChar = const $CopyWithPlaceholder(),
    Object? tueFriChar = const $CopyWithPlaceholder(),
    Object? wedSatChar = const $CopyWithPlaceholder(),
  }) {
    return GiAccountInfo(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      monThuChar:
          monThuChar == const $CopyWithPlaceholder() || monThuChar == null
          ? _value.monThuChar
          // ignore: cast_nullable_to_non_nullable
          : monThuChar as String,
      tueFriChar:
          tueFriChar == const $CopyWithPlaceholder() || tueFriChar == null
          ? _value.tueFriChar
          // ignore: cast_nullable_to_non_nullable
          : tueFriChar as String,
      wedSatChar:
          wedSatChar == const $CopyWithPlaceholder() || wedSatChar == null
          ? _value.wedSatChar
          // ignore: cast_nullable_to_non_nullable
          : wedSatChar as String,
    );
  }
}

extension $GiAccountInfoCopyWith on GiAccountInfo {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiAccountInfo.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiAccountInfoCWProxy get copyWith => _$GiAccountInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiAccountInfo _$GiAccountInfoFromJson(Map<String, dynamic> json) =>
    GiAccountInfo(
      id: json['id'] as String? ?? '',
      monThuChar: json['monThuChar'] as String? ?? '',
      tueFriChar: json['tueFriChar'] as String? ?? '',
      wedSatChar: json['wedSatChar'] as String? ?? '',
    );

Map<String, dynamic> _$GiAccountInfoToJson(GiAccountInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'monThuChar': instance.monThuChar,
      'tueFriChar': instance.tueFriChar,
      'wedSatChar': instance.wedSatChar,
    };
