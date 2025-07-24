import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/characters_screen/character_details_card.dart';
import 'package:tracker/screens/characters_screen/character_list_item.dart';
import 'package:tracker/screens/screen_filters/screen_filter_builder.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class CharactersScreen extends StatelessWidget {
  static const id = 'characters_screen';

  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventoryListPage<GsCharacter>(
      icon: AppAssets.menuIconCharacters,
      title: context.labels.characters(),
      items: (db) => db.infoOf<GsCharacter>().items,
      versionSort: (item) => item.version,
      itemBuilder: (context, state) => CharacterListItem(
        state.item,
        showItem: !state.filter!.isSectionEmpty(FilterKey.weekdays),
        onTap: state.onSelect,
        selected: state.selected,
      ),
      itemCardBuilder: (context, item) => CharacterDetailsCard(item),
    );
  }
}
