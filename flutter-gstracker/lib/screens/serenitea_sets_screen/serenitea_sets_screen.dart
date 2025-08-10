import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/serenitea_sets_screen/serenitea_set_details_card.dart';
import 'package:tracker/screens/serenitea_sets_screen/serenitea_set_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class SereniteaSetsScreen extends StatelessWidget {
  static const id = 'serenitea_sets_screen';

  const SereniteaSetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsSereniteaSet>(
      childSize: const Size(126 * 2 + 6, 160),
      icon: AppAssets.menuIconSereniteaSets,
      title: context.labels.sereniteaSets(),
      versionSort: (item) => item.version,
      itemBuilder:
          (context, state) => SereniteaSetListItem(
            state.item,
            onTap: state.onSelect,
            selected: state.selected,
          ),
      itemCardBuilder:
          (context, item) =>
              SereniteaSetDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
