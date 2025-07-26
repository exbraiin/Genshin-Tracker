import 'package:flutter/widgets.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class NamecardListItem extends StatelessWidget {
  final bool selected;
  final GsNamecard item;
  final VoidCallback? onTap;

  const NamecardListItem(
    this.item, {
    super.key,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GsItemCardButton(
      label: item.name,
      rarity: item.rarity,
      selected: selected,
      imageUrlPath: item.image,
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      onTap: onTap,
      child: Stack(
        children: [
          Positioned(
            top: kSeparator2,
            left: kSeparator2,
            child: ItemIconWidget.asset(GsAssets.iconNamecardType(item.type)),
          ),
        ],
      ),
    );
  }
}
