import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/gs_collections.dart';

final class GuRecipes {
  final GuCollections _items;
  const GuRecipes(this._items);

  int totalPermanent({bool owned = false}) {
    bool countTotal(GsRecipe recipe) {
      return recipe.baseRecipe.isEmpty && recipe.type == GeRecipeType.permanent;
    }

    bool countOwned(GsRecipe recipe) {
      return countTotal(recipe) && _items.svRecipes.exists(recipe.id);
    }

    return _items.inRecipes.items.count(owned ? countOwned : countTotal);
  }

  int totalMastered({bool owned = false}) {
    bool countTotal(GsRecipe recipe) {
      return recipe.baseRecipe.isEmpty && _items.svRecipes.exists(recipe.id);
    }

    bool countOwned(GsRecipe recipe) {
      return countTotal(recipe) &&
          (_items.svRecipes.getItem(recipe.id)?.proficiency ?? 0) >=
              recipe.maxProficiency;
    }

    return _items.inRecipes.items.count(owned ? countOwned : countTotal);
  }

  /// Updates the recipe as [own] or the recipe [proficiency].
  ///
  /// {@macro db_update}
  void update(String id, {bool? own, int? proficiency}) {
    if (own != null) {
      final contains = _items.svRecipes.exists(id);
      if (own && !contains) {
        _items.svRecipes.setItem(GiRecipe(id: id, proficiency: 0));
      } else if (!own && contains) {
        _items.svRecipes.removeItem(id);
      }
    }
    if (proficiency != null) {
      _items.svRecipes.setItem(GiRecipe(id: id, proficiency: proficiency));
    }
  }
}
