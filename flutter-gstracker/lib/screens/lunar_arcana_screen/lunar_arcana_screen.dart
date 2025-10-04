import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/lunar_arcana_screen/lunar_arcana_details_card.dart';
import 'package:tracker/screens/lunar_arcana_screen/lunar_arcana_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class LunarArcanaScreen extends StatelessWidget {
  static const id = 'lunar_arcana_screen';

  const LunarArcanaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsLunarArcana>(
      icon: AppAssets.menuLunarArcana,
      title: context.labels.lunarArcana(),
      versionSort: (item) => item.version,
      itemBuilder: (context, state) => LunarArcanaListItem(
        state.item,
        onTap: state.onSelect,
        selected: state.selected,
      ),
      itemCardBuilder: (context, item) => LunarArcanaDetailsCard(item),
    );
  }
}
