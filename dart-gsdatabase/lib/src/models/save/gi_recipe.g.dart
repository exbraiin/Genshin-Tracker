// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gi_recipe.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GiRecipeCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiRecipe(...).copyWith(id: 12, name: "My name")
  /// ```
  GiRecipe call({String id, int proficiency});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGiRecipe.copyWith(...)`.
class _$GiRecipeCWProxyImpl implements _$GiRecipeCWProxy {
  const _$GiRecipeCWProxyImpl(this._value);

  final GiRecipe _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GiRecipe(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GiRecipe call({
    Object? id = const $CopyWithPlaceholder(),
    Object? proficiency = const $CopyWithPlaceholder(),
  }) {
    return GiRecipe(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      proficiency:
          proficiency == const $CopyWithPlaceholder() || proficiency == null
          ? _value.proficiency
          // ignore: cast_nullable_to_non_nullable
          : proficiency as int,
    );
  }
}

extension $GiRecipeCopyWith on GiRecipe {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGiRecipe.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GiRecipeCWProxy get copyWith => _$GiRecipeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiRecipe _$GiRecipeFromJson(Map<String, dynamic> json) => GiRecipe(
  id: json['id'] as String? ?? '',
  proficiency: (json['proficiency'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$GiRecipeToJson(GiRecipe instance) => <String, dynamic>{
  'id': instance.id,
  'proficiency': instance.proficiency,
};
