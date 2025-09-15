import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/thespian_tricks_screen/thespian_trick_details_card.dart';
import 'package:tracker/screens/thespian_tricks_screen/thespian_trick_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class ThespianTricksScreen extends StatelessWidget {
  static const id = 'thespian_tricks_screen';

  const ThespianTricksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsThespianTrick>(
      icon: AppAssets.menuIconThespianTricks,
      title: context.labels.thespianTricks(),
      versionSort: (item) => item.version,
      itemBuilder: (context, state) {
        return ThespianTrickListItem(
          state.item,
          onTap: state.onSelect,
          selected: state.selected,
        );
      },
      itemCardBuilder: (context, item) =>
          ThespianTrickDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
