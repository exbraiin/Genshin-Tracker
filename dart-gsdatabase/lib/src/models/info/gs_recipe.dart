import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_recipe_effect_type.dart';
import 'package:gsdatabase/src/enums/ge_recipe_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_recipe.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsRecipe({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  @JsonKey(unknownEnumValue: GeRecipeType.none)
  final GeRecipeType type = GeRecipeType.none,
  final int rarity = 0,
  final String image = '',
  @JsonKey(unknownEnumValue: GeRecipeEffectType.none)
  final GeRecipeEffectType effect = GeRecipeEffectType.none,
  final String desc = '',
  final String effectDesc = '',
  final String baseRecipe = '',
  final List<GsIngredient> ingredients = const [],
}) extends GsModel<GsRecipe> with GsVersionable {
  static const kTableKey = 'recipes';

  factory GsRecipe.fromJson(JsonMap json) => _$GsRecipeFromJson(json);

  @override
  JsonMap toMap() => _$GsRecipeToJson(this);

  @override
  Iterable<Comparable Function(GsRecipe e)> get sorters => [
    (e) => e.rarity,
    (e) => e.version,
  ];
}

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsIngredient({@override final String id = '', final int amount = 0})
    extends GsModel<GsIngredient> {
  factory GsIngredient.fromJson(JsonMap json) => _$GsIngredientFromJson(json);

  @override
  JsonMap toMap() => _$GsIngredientToJson(this);
}

extension GsRecipeExt on GsRecipe {
  int get maxProficiency => (rarity * 5).clamp(0, 25);
}
