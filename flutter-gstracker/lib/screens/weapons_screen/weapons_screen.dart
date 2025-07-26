import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/screen_filters/screen_filter_builder.dart';
import 'package:tracker/screens/weapons_screen/weapon_details_card.dart';
import 'package:tracker/screens/weapons_screen/weapon_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class WeaponsScreen extends StatelessWidget {
  static const id = 'weapons_screen';

  const WeaponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsWeapon>(
      icon: AppAssets.menuIconWeapons,
      title: context.labels.weapons(),
      items: (db) => db.infoOf<GsWeapon>().items,
      versionSort: (item) => item.version,
      itemBuilder:
          (context, state) => WeaponListItem(
            showItem: !state.filter!.isSectionEmpty(FilterKey.weekdays),
            item: state.item,
            selected: state.selected,
            onTap: state.onSelect,
          ),
      itemCardBuilder:
          (context, item) => WeaponDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
