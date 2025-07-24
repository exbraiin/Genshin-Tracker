import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class SpincrystalListItem extends StatelessWidget {
  final bool selected;
  final GsSpincrystal item;
  final VoidCallback? onTap;

  const SpincrystalListItem(
    this.item, {
    super.key,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final table = Database.instance.saveOf<GiSpincrystal>();
    final owned = table.exists(item.id);
    return GsItemCardButton(
      label: item.name.isNotEmpty ? item.name : context.labels.unknown(),
      rarity: 4,
      onTap: onTap,
      disable: !owned,
      selected: selected,
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      imageAssetPath: AppAssets.spincrystal,
      child: Stack(
        children: [
          Positioned(
            top: kSeparator6,
            left: kSeparator6,
            child: Text(
              item.number.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                shadows: GsSpacing.kMainShadowText,
              ),
            ),
          ),
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
