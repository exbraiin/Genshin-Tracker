import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/remarkable_chests_screen/remarkable_chest_details_card.dart';
import 'package:tracker/screens/remarkable_chests_screen/remarkable_chests_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class RemarkableChestsScreen extends StatelessWidget {
  static const id = 'remarkable_chests_screen';

  const RemarkableChestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsFurnitureChest>(
      icon: AppAssets.menuIconMap,
      title: context.labels.remarkableChests(),
      items: (db) => db.infoOf<GsFurnitureChest>().items,
      versionSort: (item) => item.version,
      itemBuilder:
          (context, state) => RemarkableChestListItem(
            state.item,
            selected: state.selected,
            onTap: state.onSelect,
          ),
      itemCardBuilder:
          (context, item) =>
              RemarkableChestDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
