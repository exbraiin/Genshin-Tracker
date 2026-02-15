import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_divider.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/characters_screen/character_widgets.dart';
import 'package:tracker/screens/characters_screen/utils_sort_characters.dart';
import 'package:tracker/screens/screen_filters/screen_filter_builder.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class CharactersTableScreen extends StatelessWidget {
  static const id = 'characters_table_screen';

  const CharactersTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final utilsChars = GsUtils.characters;
        final listOfChars = Database.instance.infoOf<GsCharacter>().items;

        return ScreenFilterBuilder<GsCharacter>(
          builder: (context, filter, button, toggle) {
            final list = filter
                .match(listOfChars)
                .map((e) => utilsChars.getCharInfo(e.id))
                .whereNotNull()
                .toList();
            final grouped = groupCharactersByDays(list);
            final sorted = sortCharactersByDays(grouped);

            return InventoryPage(
              appBar: InventoryAppBar(
                label: context.labels.characters(),
                iconAsset: AppAssets.menuIconCharacters,
                actions: [button],
              ),
              child: _MatsByDays(sorted),
            );
          },
        );
      },
    );
  }
}

class _MatsByDays extends StatelessWidget {
  final DaysMap mapOfCharacters;

  const _MatsByDays(this.mapOfCharacters);

  @override
  Widget build(BuildContext context) {
    final today = GeWeekdayType.values.today;

    if (mapOfCharacters.values.every((e) => e.isEmpty)) {
      return InventoryBox(child: Center(child: GsNoResultsState.small()));
    }

    return Row(
      spacing: GsSpacing.kGridSeparator,
      children: mapOfCharacters.entries.map((entry) {
        final days = entry.key;
        final chars = entry.value;
        late final isToday =
            today == GeWeekdayType.sunday ||
            days.day1 == today ||
            days.day2 == today;

        return Expanded(
          child: InventoryBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(kSeparator8),
                  child: Text(
                    '${days.day1.getLabel(context).substring(0, 3)} & '
                    '${days.day2.getLabel(context).substring(0, 3)}',
                    style: context.themeStyles.label14b,
                  ),
                ),
                GsDivider(),
                Expanded(
                  child: chars.isEmpty
                      ? Center(child: GsNoResultsState.small())
                      : ListView.separated(
                          padding: EdgeInsets.all(kSeparator8),
                          itemCount: chars.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: kSeparator4),
                          itemBuilder: (context, index) => _listItem(
                            context,
                            chars[index],
                            isToday: isToday,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _listItem(
    BuildContext context,
    CharInfo info, {
    required bool isToday,
  }) {
    final mats = GsUtils.materials.getCharTalentsMissing(
      info.item,
      info.info,
      CharTalents.kCrownless,
    );

    return Row(
      spacing: kSeparator8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemGridWidget.character(
          info.item,
          disabled: !isToday,
          labelWidget: CharaterTalentsLabel(info),
        ),
        SizedBox(
          height: kSize50,
          child: Center(
            child: Text('\u2022', style: context.themeStyles.label14n),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: kSeparator4,
            runSpacing: kSeparator4,
            alignment: WrapAlignment.start,
            children: mats.entries.map((mat) {
              return ItemGridWidget.material(
                mat.key,
                disabled: !isToday,
                label: mat.value.compact(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
