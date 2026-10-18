// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gs_recipe.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GsRecipeCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsRecipe(...).copyWith(id: 12, name: "My name")
  /// ```
  GsRecipe call({
    String id,
    String version,
    String name,
    GeRecipeType type,
    int rarity,
    String image,
    GeRecipeEffectType effect,
    String desc,
    String effectDesc,
    String baseRecipe,
    List<GsIngredient> ingredients,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsRecipe.copyWith(...)`.
class _$GsRecipeCWProxyImpl implements _$GsRecipeCWProxy {
  const _$GsRecipeCWProxyImpl(this._value);

  final GsRecipe _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsRecipe(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsRecipe call({
    Object? id = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? rarity = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? effect = const $CopyWithPlaceholder(),
    Object? desc = const $CopyWithPlaceholder(),
    Object? effectDesc = const $CopyWithPlaceholder(),
    Object? baseRecipe = const $CopyWithPlaceholder(),
    Object? ingredients = const $CopyWithPlaceholder(),
  }) {
    return GsRecipe(
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
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeRecipeType,
      rarity: rarity == const $CopyWithPlaceholder() || rarity == null
          ? _value.rarity
          // ignore: cast_nullable_to_non_nullable
          : rarity as int,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      effect: effect == const $CopyWithPlaceholder() || effect == null
          ? _value.effect
          // ignore: cast_nullable_to_non_nullable
          : effect as GeRecipeEffectType,
      desc: desc == const $CopyWithPlaceholder() || desc == null
          ? _value.desc
          // ignore: cast_nullable_to_non_nullable
          : desc as String,
      effectDesc:
          effectDesc == const $CopyWithPlaceholder() || effectDesc == null
          ? _value.effectDesc
          // ignore: cast_nullable_to_non_nullable
          : effectDesc as String,
      baseRecipe:
          baseRecipe == const $CopyWithPlaceholder() || baseRecipe == null
          ? _value.baseRecipe
          // ignore: cast_nullable_to_non_nullable
          : baseRecipe as String,
      ingredients:
          ingredients == const $CopyWithPlaceholder() || ingredients == null
          ? _value.ingredients
          // ignore: cast_nullable_to_non_nullable
          : ingredients as List<GsIngredient>,
    );
  }
}

extension $GsRecipeCopyWith on GsRecipe {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsRecipe.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsRecipeCWProxy get copyWith => _$GsRecipeCWProxyImpl(this);
}

abstract class _$GsIngredientCWProxy {
  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsIngredient(...).copyWith(id: 12, name: "My name")
  /// ```
  GsIngredient call({String id, int amount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGsIngredient.copyWith(...)`.
class _$GsIngredientCWProxyImpl implements _$GsIngredientCWProxy {
  const _$GsIngredientCWProxyImpl(this._value);

  final GsIngredient _value;

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields.
  ///
  /// Example:
  /// ```dart
  /// GsIngredient(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  GsIngredient call({
    Object? id = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
  }) {
    return GsIngredient(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
    );
  }
}

extension $GsIngredientCopyWith on GsIngredient {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGsIngredient.copyWith(...)`.
  // ignore: library_private_types_in_public_api
  _$GsIngredientCWProxy get copyWith => _$GsIngredientCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GsRecipe _$GsRecipeFromJson(Map<String, dynamic> json) => GsRecipe(
  id: json['id'] as String? ?? '',
  version: json['version'] as String? ?? '',
  name: json['name'] as String? ?? '',
  type:
      $enumDecodeNullable(
        _$GeRecipeTypeEnumMap,
        json['type'],
        unknownValue: GeRecipeType.none,
      ) ??
      GeRecipeType.none,
  rarity: (json['rarity'] as num?)?.toInt() ?? 0,
  image: json['image'] as String? ?? '',
  effect:
      $enumDecodeNullable(
        _$GeRecipeEffectTypeEnumMap,
        json['effect'],
        unknownValue: GeRecipeEffectType.none,
      ) ??
      GeRecipeEffectType.none,
  desc: json['desc'] as String? ?? '',
  effectDesc: json['effectDesc'] as String? ?? '',
  baseRecipe: json['baseRecipe'] as String? ?? '',
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map((e) => GsIngredient.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GsRecipeToJson(GsRecipe instance) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'name': instance.name,
  'type': _$GeRecipeTypeEnumMap[instance.type]!,
  'rarity': instance.rarity,
  'image': instance.image,
  'effect': _$GeRecipeEffectTypeEnumMap[instance.effect]!,
  'desc': instance.desc,
  'effectDesc': instance.effectDesc,
  'baseRecipe': instance.baseRecipe,
  'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
};

const _$GeRecipeTypeEnumMap = {
  GeRecipeType.none: 'none',
  GeRecipeType.event: 'event',
  GeRecipeType.permanent: 'permanent',
};

const _$GeRecipeEffectTypeEnumMap = {
  GeRecipeEffectType.none: 'none',
  GeRecipeEffectType.recoveryHPAll: 'recoveryHPAll',
  GeRecipeEffectType.recoveryHP: 'recoveryHP',
  GeRecipeEffectType.revive: 'revive',
  GeRecipeEffectType.atkBoost: 'atkBoost',
  GeRecipeEffectType.staminaIncrease: 'staminaIncrease',
  GeRecipeEffectType.staminaReduction: 'staminaReduction',
  GeRecipeEffectType.atkCritBoost: 'atkCritBoost',
  GeRecipeEffectType.defBoost: 'defBoost',
  GeRecipeEffectType.adventure: 'adventure',
  GeRecipeEffectType.special: 'special',
};

GsIngredient _$GsIngredientFromJson(Map<String, dynamic> json) => GsIngredient(
  id: json['id'] as String? ?? '',
  amount: (json['amount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$GsIngredientToJson(GsIngredient instance) =>
    <String, dynamic>{'id': instance.id, 'amount': instance.amount};
