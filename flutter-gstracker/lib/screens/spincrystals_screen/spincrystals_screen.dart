import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/spincrystals_screen/spincrystal_details_card.dart';
import 'package:tracker/screens/spincrystals_screen/spincrystal_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class SpincrystalsScreen extends StatelessWidget {
  static const id = 'spincrystal_screen';

  const SpincrystalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsSpincrystal>(
      icon: AppAssets.menuIconPreciousItems,
      title: context.labels.spincrystals(),
      items: (db) => db.infoOf<GsSpincrystal>().items,
      versionSort: (item) => item.version,
      itemBuilder: (context, state) {
        return SpincrystalListItem(
          state.item,
          onTap: state.onSelect,
          selected: state.selected,
        );
      },
      itemCardBuilder:
          (context, item) =>
              SpincrystalDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
