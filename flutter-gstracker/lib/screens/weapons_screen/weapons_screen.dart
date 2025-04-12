import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/screen_filters/screen_filter_builder.dart';
import 'package:tracker/screens/weapons_screen/weapon_details_card.dart';
import 'package:tracker/screens/weapons_screen/weapon_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';

class WeaponsScreen extends StatelessWidget {
  static const id = 'weapons_screen';

  const WeaponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsWeapon>(
      icon: GsAssets.menuWeapons,
      title: context.labels.weapons(),
      items: (db) => db.infoOf<GsWeapon>().items,
      versionSort: (item) => item.version,
      itemBuilder: (context, state) => WeaponListItem(
        showItem: !state.filter!.isSectionEmpty(FilterKey.weekdays),
        showExtra: state.filter!.hasExtra(FilterExtras.info),
        item: state.item,
        selected: state.selected,
        onTap: state.onSelect,
      ),
      itemCardBuilder: (context, item) => WeaponDetailsCard(
        item,
        key: ValueKey(item.id),
      ),
      actions: (hasExtra, toggle) => [
        Tooltip(
          message: context.labels.showExtraInfo(),
          child: IconButton(
            icon: Icon(
              hasExtra(FilterExtras.info)
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            onPressed: () => toggle(FilterExtras.info),
          ),
        ),
      ],
    );
  }
}
