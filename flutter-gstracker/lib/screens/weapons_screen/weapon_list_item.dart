import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';

class WeaponListItem extends StatelessWidget {
  final bool showItem;
  final bool showExtra;
  final bool selected;
  final GsWeapon item;
  final VoidCallback? onTap;

  const WeaponListItem({
    super.key,
    this.showItem = false,
    this.selected = false,
    this.onTap,
    required this.showExtra,
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
    late final material = GsUtils.weaponMaterials
        .getAscensionMaterials(item.id)
        .entries
        .map((e) => Database.instance.infoOf<GsMaterial>().getItem(e.key))
        .firstOrNullWhere((e) => e?.weekdays.isNotEmpty ?? false);

    return Padding(
      padding: const EdgeInsets.all(kSeparator2),
      child: Stack(
        children: [
          ItemIconWidget.asset(item.type.assetPath),
          if (showExtra)
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GsItemCardLabel(
                    label: '${item.ascAtkValue}',
                    asset: GsAssets.atkIcon,
                  ),
                  if (item.statType != GeWeaponAscStatType.none)
                    Padding(
                      padding: const EdgeInsets.only(top: kSeparator2),
                      child: Tooltip(
                        message: item.statType.label(context),
                        child: GsItemCardLabel(
                          label: item.statType
                              .toIntOrPercentage(item.ascStatValue),
                          asset: item.statType.assetPath,
                        ),
                      ),
                    ),
                ],
              ),
            ),
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
