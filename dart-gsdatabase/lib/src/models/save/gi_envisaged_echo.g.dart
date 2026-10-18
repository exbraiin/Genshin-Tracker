// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_envisaged_echo.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiEnvisagedEchoCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiEnvisagedEcho(...).copyWith(id: 12, name: "My name")
  /// ```
  GiEnvisagedEcho call({String id});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiEnvisagedEcho.copyWith(...)`.
class _$GiEnvisagedEchoCWProxyImpl implements _$GiEnvisagedEchoCWProxy {
  const _$GiEnvisagedEchoCWProxyImpl(this._value);

  final GiEnvisagedEcho _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiEnvisagedEcho(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiEnvisagedEcho call({Object? id = const $CopyWithPlaceholder()}) {
    return GiEnvisagedEcho(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $GiEnvisagedEchoCopyWith on GiEnvisagedEcho {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiEnvisagedEcho.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiEnvisagedEchoCWProxy get copyWith => _$GiEnvisagedEchoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiEnvisagedEcho _$GiEnvisagedEchoFromJson(Map<String, dynamic> json) =>
    GiEnvisagedEcho(id: json['id'] as String? ?? '');

Map<String, dynamic> _$GiEnvisagedEchoToJson(GiEnvisagedEcho instance) =>
    <String, dynamic>{'id': instance.id};
