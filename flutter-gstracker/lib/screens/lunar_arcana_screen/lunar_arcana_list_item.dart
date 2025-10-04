import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/domain/gs_database.dart';

class LunarArcanaListItem extends StatelessWidget {
  final bool selected;
  final GsLunarArcana item;
  final VoidCallback? onTap;

  const LunarArcanaListItem(
    this.item, {
    super.key,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final owned = Database.instance.saveOf<GiLunarArcana>().exists(item.id);
    return GsItemCardButton(
      onTap: onTap,
      label: item.name,
      rarity: 4,
      disable: !owned,
      selected: selected,
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      imageUrlPath: item.image,
    );
  }
}
