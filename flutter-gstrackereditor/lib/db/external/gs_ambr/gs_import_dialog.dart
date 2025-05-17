import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:data_editor/db/external/gs_ambr/src/import_api.dart';
import 'package:data_editor/style/style.dart';
import 'package:data_editor/widgets/gs_selector/src/gs_select_chip.dart';
import 'package:data_editor/widgets/gs_selector/src/gs_single_select.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';

final class GsImportDialog {
  static const i = GsImportDialog._();
  const GsImportDialog._();

  Future<T> _fetch<T>(
    BuildContext context,
    T item,
    String title,
    Future<List<ImportItem>> Function() fetchAll,
    Future<T?> Function(String id, [T? other]) fetch, {
    String? searchText,
  }) async {
    final items = await fetchAll();
    if (!context.mounted) return item;
    String? id;
    await SelectDialog<String>(
      title: title,
      items: items
          .sortedBy((e) => e.level)
          .thenBy((e) => e.name)
          .map((item) => item.toSelect()),
      selected: null,
      searchText: searchText,
      onConfirm: (value) => id = value,
    ).show(context);
    if (id == null) return item;
    return await fetch(id!, item) ?? item;
  }

  Future<GsArtifact> fetchArtifact(BuildContext ctx, GsArtifact item) {
    return _fetch(
      ctx,
      item,
      'Artifacts',
      ImportApi.i.fetchArtifacts,
      ImportApi.i.fetchArtifact,
      searchText: item.name,
    );
  }

  Future<GsCharacter> fetchCharacter(BuildContext ctx, GsCharacter item) {
    return _fetch(
      ctx,
      item,
      'Characters',
      ImportApi.i.fetchCharacters,
      ImportApi.i.fetchCharacter,
      searchText: item.name,
    );
  }

  Future<GsNamecard> fetchNamecard(BuildContext ctx, GsNamecard item) {
    return _fetch(
      ctx,
      item,
      'Namecards',
      ImportApi.i.fetchNamecards,
      ImportApi.i.fetchNamecard,
      searchText: item.name,
    );
  }

  Future<GsRecipe> fetchRecipe(BuildContext context, GsRecipe item) {
    return _fetch(
      context,
      item,
      'Recipes',
      ImportApi.i.fetchRecipes,
      ImportApi.i.fetchRecipe,
      searchText: item.name,
    );
  }

  Future<GsWeapon> fetchWeapon(BuildContext ctx, GsWeapon item) {
    return _fetch(
      ctx,
      item,
      'Weapons',
      ImportApi.i.fetchWeapons,
      ImportApi.i.fetchWeapon,
      searchText: item.name,
    );
  }

  Future<GsSereniteaSet> fetchSereniteaSet(
    BuildContext ctx,
    GsSereniteaSet item,
  ) {
    return _fetch(
      ctx,
      item,
      'FurnishingSets',
      ImportApi.i.fetchSereniteaSets,
      ImportApi.i.fetchSereniteaSet,
      searchText: item.name,
    );
  }

  Future<GsFurnitureChest> fetchFurniture(
    BuildContext ctx,
    GsFurnitureChest item,
  ) {
    return _fetch(
      ctx,
      item,
      'Furnitures',
      ImportApi.i.fetchFurnitures,
      ImportApi.i.fetchFurniture,
      searchText: item.name,
    );
  }
}

extension on ImportItem {
  GsSelectItem<String> toSelect() {
    final color = GsStyle.getRarityColor(level);
    return GsSelectItem<String>(id, name, image: icon, color: color);
  }
}
