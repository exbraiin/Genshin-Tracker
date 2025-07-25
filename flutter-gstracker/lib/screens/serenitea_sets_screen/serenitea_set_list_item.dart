import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class SereniteaSetListItem extends StatelessWidget {
  final bool selected;
  final GsSereniteaSet item;
  final VoidCallback? onTap;

  const SereniteaSetListItem(
    this.item, {
    super.key,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final saved = Database.instance.saveOf<GiSereniteaSet>().getItem(item.id);
    return GsItemCardButton(
      label: item.name,
      rarity: 4,
      selected: selected,
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      imageAspectRatio: 2,
      imageUrlPath: item.image,
      onTap: onTap,
      child: Stack(
        children: [
          ItemIconWidget.asset(
            GsAssets.iconSetType(item.category),
            size: kSize44,
          ),
          ...item.chars
              .map(Database.instance.infoOf<GsCharacter>().getItem)
              .whereNotNull()
              .where(
                (e) =>
                    !(saved?.chars.contains(e.id) ?? false) &&
                    GsUtils.characters.hasCaracter(e.id),
              )
              .sortedBy((element) => element.rarity)
              .thenByDescending((element) => element.name)
              .mapIndexed(
                (i, e) => Positioned(
                  right: kSeparator2 + i * kSeparator16,
                  bottom: kSeparator2,
                  child: ItemCircleWidget(image: e.image, rarity: e.rarity),
                ),
              ),
        ],
      ),
    );
  }
}
