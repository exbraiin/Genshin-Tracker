import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class ArtifactListItem extends StatelessWidget {
  final GsArtifact item;
  final bool selected;
  final VoidCallback? onTap;

  const ArtifactListItem(
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
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      imageUrlPath: item.pieces.firstOrNull?.icon,
      onTap: onTap,
      child: Stack(
        children: [
          if (item.region != GeRegionType.none)
            Positioned(
              right: kSeparator2,
              bottom: kSeparator2,
              child: ItemCircleWidget.region(item.region),
            ),
        ],
      ),
    );
  }
}
