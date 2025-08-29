import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/common/widgets/value_notifier_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/characters_screen/characters_table_screen.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class HomeTalentsWidget extends StatelessWidget {
  const HomeTalentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        const chars = GsUtils.characters;
        final today = GeWeekdayType.values.today;
        final iMats = Database.instance.infoOf<GsMaterial>();
        final iChar = Database.instance.infoOf<GsCharacter>();

        final farmableDays = [
          (day1: GeWeekdayType.monday, day2: GeWeekdayType.thursday),
          (day1: GeWeekdayType.tuesday, day2: GeWeekdayType.friday),
          (day1: GeWeekdayType.wednesday, day2: GeWeekdayType.saturday),
        ];
        final characters = iChar.items
            .where((e) => chars.hasCaracter(e.id))
            .map((e) => chars.getCharInfo(e.id))
            .whereNotNull()
            .where((e) => e.talents?.isMissing(crownless: true) ?? false)
            .groupBy((e) {
              final weekdays =
                  iMats.getItem(e.item.talentMaterial)?.weekdays ?? [];
              return farmableDays.firstOrNullWhere(
                (e) => weekdays.contains(e.day1),
              );
            });

        final isEmpty = characters.values.every((list) => list.isEmpty);
        if (isEmpty) {
          return GsDataBox.info(
            title: Text(context.labels.talents()),
            child: const GsNoResultsState.small(),
          );
        }

        const kItemSize = kSize56;
        return ValueNotifierBuilder(
          value: false,
          builder: (context, notifier, child) {
            final asc = notifier.value;

            final charactersByDays = characters.map((key, value) {
              final list = value
                  .sortedByOrder((e) => e.talents?.totalCrownless ?? 0, asc)
                  .thenByDescending((e) => e.item.rarity)
                  .thenBy((c) => c.item.releaseDate)
                  .thenBy((c) => c.item.id);
              return MapEntry(key, list);
            });

            const kItemsPerDay = 4;
            return GsDataBox.info(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${context.labels.talents()} - ${today.getLabel(context)}',
                    ),
                  ),
                  SizedBox(width: kSeparator4),
                  IconButton(
                    padding: EdgeInsets.all(2),
                    constraints: BoxConstraints.tightFor(),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pushNamed(CharactersTableScreen.id),
                    icon: const Icon(Icons.list),
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  SizedBox(width: kSeparator4),
                  IconButton(
                    padding: EdgeInsets.all(2),
                    constraints: BoxConstraints.tightFor(),
                    onPressed: () => notifier.value = !asc,
                    icon:
                        asc
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
                    children:
                        farmableDays.map((days) {
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
                    children:
                        farmableDays.map((days) {
                          final chars = charactersByDays[days] ?? <CharInfo>[];
                          late final isToday =
                              today == GeWeekdayType.sunday ||
                              days.day1 == today ||
                              days.day2 == today;

                          return Wrap(
                            spacing: kSeparator4,
                            runSpacing: kSeparator4,
                            alignment: WrapAlignment.center,
                            children:
                                chars.take(kItemsPerDay).map((info) {
                                  return ItemGridWidget.character(
                                    info.item,
                                    size: kItemSize,
                                    disabled: !isToday,
                                    labelWidget: _talenstLabel(context, info),
                                  );
                                }).toList(),
                          );
                        }).toList(),
                  ),
                  TableRow(
                    children:
                        farmableDays.map((days) {
                          final chars = charactersByDays[days] ?? <CharInfo>[];
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

  Widget _talenstLabel(BuildContext context, CharInfo info) {
    final style = context.themeStyles.label14n;
    final strut = style.toStrut();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          CharTalentType.values.map((talent) {
            final value = info.talents?.talentWithExtra(talent);
            final hasExtra = info.talents?.hasExtra(talent) ?? false;
            return Text(
              '${value ?? '-'} ',
              style: style.copyWith(color: hasExtra ? Colors.lightBlue : null),
              strutStyle: strut,
            );
          }).toList(),
    );
  }
}

extension<E> on Iterable<E> {
  SortedList<E> sortedByOrder(
    Comparable Function(E element) selector,
    bool asc,
  ) {
    return asc ? sortedBy(selector) : sortedByDescending(selector);
  }
}
