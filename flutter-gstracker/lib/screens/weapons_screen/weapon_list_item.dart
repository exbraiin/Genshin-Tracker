import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class WeaponListItem extends StatelessWidget {
  final bool showItem;
  final bool selected;
  final GsWeapon item;
  final VoidCallback? onTap;

  const WeaponListItem({
    super.key,
    this.showItem = false,
    this.selected = false,
    this.onTap,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final owned = GsUtils.weapons.hasWeapon(item.id);
    return GsItemCardButton(
      label: item.name,
      rarity: item.rarity,
      disable: !owned,
      selected: selected,
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      imageUrlPath: item.image,
      onTap: onTap,
      child: _getContent(context),
    );
  }

  Widget _getContent(BuildContext context) {
    late final material = GsUtils.materials
        .getWeaponAscension(item)
        .keys
        .firstOrNullWhere((e) => e.weekdays.isNotEmpty);

    return Padding(
      padding: const EdgeInsets.all(kSeparator2),
      child: Stack(
        children: [
          ItemIconWidget.asset(item.type.assetPath),
          if (showItem && material != null)
            Positioned(
              right: kSeparator2,
              bottom: kSeparator2,
              child: ItemCircleWidget.material(material),
            ),
        ],
      ),
    );
  }
}
