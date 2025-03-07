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
    return ItemDetailsCardContent.generate(
      context,
      [
        ItemDetailsCardContent(
          label: context.labels.version(),
          description: item.id,
        ),
        if (characters.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.characters(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: characters.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  rarity: e.rarity,
                  tooltip: e.name,
                  padding: EdgeInsets.zero,
                );
              }).toList(),
            ),
          ),
        if (outfits.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.outfits(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: outfits.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  rarity: e.rarity,
                  tooltip: e.name,
                );
              }).toList(),
            ),
          ),
        if (weapons.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.weapons(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: weapons.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  rarity: e.rarity,
                  tooltip: e.name,
                  padding: EdgeInsets.zero,
                );
              }).toList(),
            ),
          ),
        if (materials.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.materials(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: materials.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  rarity: e.rarity,
                  tooltip: e.name,
                );
              }).toList(),
            ),
          ),
        if (recipes.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.recipes(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: recipes.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  rarity: e.rarity,
                  tooltip: e.name,
                );
              }).toList(),
            ),
          ),
        if (sets.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.sereniteaSets(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: sets.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  rarity: e.rarity,
                  tooltip: e.name,
                );
              }).toList(),
            ),
          ),
        if (crystals.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.spincrystals(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: crystals.map((e) {
                return ItemCircleWidget(
                  asset: GsAssets.spincrystal,
                  rarity: 4,
                  label: '${e.number} ${e.name}',
                );
              }).toList(),
            ),
          ),
        if (banners.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.wishes(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: banners.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  tooltip: e.name,
                );
              }).toList(),
            ),
          ),
        if (chests.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.remarkableChests(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: chests.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  rarity: e.rarity,
                  tooltip: e.name,
                );
              }).toList(),
            ),
          ),
        if (namecards.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.namecards(),
            content: Wrap(
              spacing: kSeparator2,
              runSpacing: kSeparator2,
              children: namecards.map((e) {
                return ItemCircleWidget(
                  image: e.image,
                  rarity: e.rarity,
                  tooltip: e.name,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
