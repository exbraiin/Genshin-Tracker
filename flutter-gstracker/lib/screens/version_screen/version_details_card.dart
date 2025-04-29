import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';

class VersionDetailsCard extends StatelessWidget with GsDetailedDialogMixin {
  final GsVersion item;

  const VersionDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        return ItemDetailsCard(
          name: item.name,
          fgImage: item.image,
          banner: GsItemBanner.version(context, item.id),
          info: Align(
            alignment: Alignment.topLeft,
            child: Text(item.id),
          ),
          contentPadding: EdgeInsets.all(kSeparator16),
          child: _content(context),
        );
      },
    );
  }

  Widget _content(BuildContext context) {
    final characters = Database.instance
        .infoOf<GsCharacter>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.name);
    final outfits = Database.instance
        .infoOf<GsCharacterSkin>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.name);
    final weapons = Database.instance
        .infoOf<GsWeapon>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.name);
    final materials = Database.instance
        .infoOf<GsMaterial>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.name);
    final recipes = Database.instance
        .infoOf<GsRecipe>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.name);
    final sets = Database.instance
        .infoOf<GsSereniteaSet>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.name);
    final crystals = Database.instance
        .infoOf<GsSpincrystal>()
        .items
        .where((element) => element.version == item.id)
        .sortedBy((element) => element.name);
    final banners = Database.instance
        .infoOf<GsBanner>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.type.index)
        .thenBy((element) => element.name);
    final chests = Database.instance
        .infoOf<GsFurnitureChest>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.name);
    final namecards = Database.instance
        .infoOf<GsNamecard>()
        .items
        .where((element) => element.version == item.id)
        .sortedByDescending((element) => element.rarity)
        .thenBy((element) => element.name);

    Widget? mapItems<T>(
      List<T> items,
      String label,
      ItemCircleWidget Function(T e) toElement,
    ) {
      if (items.isEmpty) return null;
      return ItemDetailsCardInfo.section(
        title: Text(label),
        content: Wrap(
          spacing: kSeparator2,
          runSpacing: kSeparator2,
          children: items.map(toElement).toList(),
        ),
      );
    }

    return Column(
      spacing: kSeparator16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemDetailsCardInfo.section(
          title: Text(context.labels.version()),
          content: Text(item.id),
        ),
        ...<Widget?>[
          mapItems(characters, context.labels.characters(), (e) {
            return ItemCircleWidget(
              image: e.image,
              rarity: e.rarity,
              tooltip: e.name,
              padding: EdgeInsets.zero,
            );
          }),
          mapItems(outfits, context.labels.outfits(), (e) {
            return ItemCircleWidget(
              image: e.image,
              rarity: e.rarity,
              tooltip: e.name,
            );
          }),
          mapItems(weapons, context.labels.weapons(), (e) {
            return ItemCircleWidget(
              image: e.image,
              rarity: e.rarity,
              tooltip: e.name,
              padding: EdgeInsets.zero,
            );
          }),
          mapItems(materials, context.labels.materials(), (e) {
            return ItemCircleWidget(
              image: e.image,
              rarity: e.rarity,
              tooltip: e.name,
            );
          }),
          mapItems(recipes, context.labels.recipes(), (e) {
            return ItemCircleWidget(
              image: e.image,
              rarity: e.rarity,
              tooltip: e.name,
            );
          }),
          mapItems(sets, context.labels.sereniteaSets(), (e) {
            return ItemCircleWidget(
              image: e.image,
              rarity: e.rarity,
              tooltip: e.name,
            );
          }),
          mapItems(crystals, context.labels.spincrystals(), (e) {
            return ItemCircleWidget(
              asset: GsAssets.spincrystal,
              rarity: 4,
              label: '${e.number} ${e.name}',
            );
          }),
          mapItems(banners, context.labels.wishes(), (e) {
            return ItemCircleWidget(
              image: e.image,
              tooltip: e.name,
            );
          }),
          mapItems(chests, context.labels.remarkableChests(), (e) {
            return ItemCircleWidget(
              image: e.image,
              rarity: e.rarity,
              tooltip: e.name,
            );
          }),
          mapItems(namecards, context.labels.namecards(), (e) {
            return ItemCircleWidget(
              image: e.image,
              rarity: e.rarity,
              tooltip: e.name,
            );
          }),
        ].whereNotNull(),
      ],
    );
  }
}
