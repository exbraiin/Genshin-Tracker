import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/materials_screen/material_details_card.dart';
import 'package:tracker/screens/materials_screen/material_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class MaterialsScreen extends StatelessWidget {
  static const id = 'materials_screen';

  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsMaterial>(
      icon: AppAssets.menuIconMaterials,
      title: context.labels.materials(),
      items: (db) => db.infoOf<GsMaterial>().items,
      versionSort: (item) => item.version,
      itemBuilder:
          (context, state) => MaterialListItem(
            state.item,
            onTap: state.onSelect,
            selected: state.selected,
          ),
      itemCardBuilder:
          (context, item) => MaterialDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
