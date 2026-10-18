// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_serenitea_set.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiSereniteaSetCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiSereniteaSet(...).copyWith(id: 12, name: "My name")
  /// ```
  GiSereniteaSet call({String id, List<String> chars});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiSereniteaSet.copyWith(...)`.
class _$GiSereniteaSetCWProxyImpl implements _$GiSereniteaSetCWProxy {
  const _$GiSereniteaSetCWProxyImpl(this._value);

  final GiSereniteaSet _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiSereniteaSet(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiSereniteaSet call({
    Object? id = const $CopyWithPlaceholder(),
    Object? chars = const $CopyWithPlaceholder(),
  }) {
    return GiSereniteaSet(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      chars: chars == const $CopyWithPlaceholder() || chars == null
          ? _value.chars
          // ignore: cast_nullable_to_non_nullable
          : chars as List<String>,
    );
  }
}

extension $GiSereniteaSetCopyWith on GiSereniteaSet {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiSereniteaSet.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiSereniteaSetCWProxy get copyWith => _$GiSereniteaSetCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiSereniteaSet _$GiSereniteaSetFromJson(Map<String, dynamic> json) =>
    GiSereniteaSet(
      id: json['id'] as String? ?? '',
      chars:
          (json['chars'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$GiSereniteaSetToJson(GiSereniteaSet instance) =>
    <String, dynamic>{'id': instance.id, 'chars': instance.chars};
