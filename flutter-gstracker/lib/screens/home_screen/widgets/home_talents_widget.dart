import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/characters_screen/character_widgets.dart';
import 'package:tracker/screens/characters_screen/characters_table_screen.dart';
import 'package:tracker/screens/characters_screen/utils_sort_characters.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class HomeTalentsWidget extends StatefulWidget {
  const HomeTalentsWidget({super.key});

  @override
  State<HomeTalentsWidget> createState() => _HomeTalentsWidgetState();
}

class _HomeTalentsWidgetState extends State<HomeTalentsWidget> {
  final _ascending = ValueNotifier(false);

  @override
  void dispose() {
    _ascending.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final today = GeWeekdayType.values.today;
        final characters = groupCharactersByDays();

        final isEmpty = characters.values.every((list) => list.isEmpty);
        if (isEmpty) {
          return GsDataBox.info(
            title: Text(context.labels.talents()),
            child: const GsNoResultsState.small(),
          );
        }

        const kItemSize = kSize56;
        return ValueListenableBuilder(
          valueListenable: _ascending,
          builder: (context, asc, child) {
            final charactersByDays = sortCharactersByDays(characters, asc: asc);

            const kItemsPerDay = 4;
            return GsDataBox.info(
              title: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(context.labels.talents()),
                        Text(
                          ' \u2022 ${today.getLabel(context)}',
                          style: context.themeStyles.label14b.copyWith(
                            color: context.themeColors.sectionContent,
                          ),
                          strutStyle: context.themeStyles.label14b.toStrut(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: kSeparator4),
                  IconButton(
                    padding: EdgeInsets.all(2),
                    constraints: BoxConstraints.tightFor(),
                    onPressed: () => Navigator.of(
                      context,
                    ).pushNamed(CharactersTableScreen.id),
                    icon: const Icon(Icons.list),
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  SizedBox(width: kSeparator4),
                  IconButton(
                    padding: EdgeInsets.all(2),
                    constraints: BoxConstraints.tightFor(),
                    onPressed: () => _ascending.value = !asc,
                    icon: asc
                        ? const Icon(Icons.arrow_circle_up_rounded)
                        : const Icon(Icons.arrow_circle_down_rounded),
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  SizedBox(width: kSeparator4),
                ],
              ),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: charactersByDays.keys.map((days) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: kSeparator8),
                        child: Text(
                          '${days.day1.getLabel(context).substring(0, 3)} & '
                          '${days.day2.getLabel(context).substring(0, 3)}',
                          textAlign: TextAlign.center,
                          style: context.themeStyles.label14n,
                        ),
                      );
                    }).toList(),
                  ),
                  TableRow(
                    children: charactersByDays.entries.map((entry) {
                      final days = entry.key;
                      final chars = entry.value;
                      late final isToday =
                          today == GeWeekdayType.sunday ||
                          days.day1 == today ||
                          days.day2 == today;

                      return Wrap(
                        spacing: kSeparator4,
                        runSpacing: kSeparator4,
                        alignment: WrapAlignment.center,
                        children: chars.take(kItemsPerDay).map((info) {
                          return ItemGridWidget.character(
                            info.item,
                            size: kItemSize,
                            disabled: !isToday,
                            labelWidget: CharaterTalentsLabel(info),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                  TableRow(
                    children: charactersByDays.values.map((chars) {
                      final total = chars.length;
                      return Padding(
                        padding: EdgeInsets.only(top: kSeparator8),
                        child: Text(
                          '${context.labels.total()} $total',
                          textAlign: TextAlign.center,
                          style: context.themeStyles.label12i,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
