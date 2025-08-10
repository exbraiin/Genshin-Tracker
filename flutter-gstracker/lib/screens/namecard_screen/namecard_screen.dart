import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/namecard_screen/namecard_details_card.dart';
import 'package:tracker/screens/namecard_screen/namecard_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class NamecardScreen extends StatelessWidget {
  static const id = 'namecards_screen';

  const NamecardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsNamecard>(
      icon: AppAssets.menuIconArchive,
      title: context.labels.namecards(),
      versionSort: (item) => item.version,
      itemBuilder:
          (context, state) => NamecardListItem(
            state.item,
            onTap: state.onSelect,
            selected: state.selected,
          ),
      itemCardBuilder:
          (context, item) => NamecardDetailsCard(item, key: ValueKey(item.id)),
    );
  }
}
