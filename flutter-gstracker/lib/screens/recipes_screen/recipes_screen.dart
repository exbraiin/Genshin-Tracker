import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/recipes_screen/recipe_details_card.dart';
import 'package:tracker/screens/recipes_screen/recipes_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class RecipesScreen extends StatelessWidget {
  static const id = 'recipes_screen';

  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final saveRecipes = Database.instance.saveOf<GiRecipe>();
    return InventoryListPage<GsRecipe>(
      icon: AppAssets.menuIconRecipes,
      title: context.labels.recipes(),
      items: (db) => db.infoOf<GsRecipe>().items,
      versionSort: (item) => item.version,
      itemBuilder:
          (context, state) => RecipesListItem(
            recipe: state.item,
            selected: state.selected,
            onTap: state.onSelect,
            savedRecipe: saveRecipes.getItem(state.item.id),
          ),
      itemCardBuilder:
          (context, item) => RecipeDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
