import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/common/widgets/value_notifier_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';

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

        final list = iChar.items
            .where((c) => chars.hasCaracter(c.id))
            .map((c) => chars.getCharInfo(c.id))
            .whereNotNull()
            .where((data) {
          final hasMissingTalents = data.talents?.isMissing() ?? false;

          late final talentMaterial = iMats.getItem(data.item.talentMaterial);
          final hasWeekdayTalents = today == GeWeekdayType.sunday ||
              talentMaterial != null && talentMaterial.weekdays.contains(today);

          return hasMissingTalents && hasWeekdayTalents;
        });

        if (list.isEmpty) {
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
            final characters = list
                .sortedByOrder((c) => c.talents?.totalCrownless ?? 0, asc)
                .thenByDescending((c) => c.item.rarity)
                .thenBy((c) => c.item.releaseDate)
                .thenBy((c) => c.item.id);
            return GsDataBox.info(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${context.labels.talents()} - ${today.getLabel(context)}',
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(2),
                    constraints: BoxConstraints.tightFor(),
                    onPressed: () => notifier.value = !asc,
                    icon: asc
                        ? const Icon(Icons.arrow_circle_up_rounded)
                        : const Icon(Icons.arrow_circle_down_rounded),
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  SizedBox(width: kSeparator4),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, layout) {
                  final itemSize = kItemSize + kGridSeparator;
                  final width = layout.maxWidth;
                  final items = (width ~/ itemSize).coerceAtMost(8) * 2;

                  return Center(
                    child: Wrap(
                      spacing: kGridSeparator,
                      runSpacing: kGridSeparator,
                      alignment: WrapAlignment.center,
                      children: characters.take(items).map<Widget>((info) {
                        return ItemGridWidget.character(
                          size: kItemSize,
                          info.item,
                          labelWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: CharTalentType.values
                                .map((e) => _talentLabel(context, info, e))
                                .toList(),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _talentLabel(BuildContext context, CharInfo info, CharTalentType tal) {
    final value = info.talents?.talentWithExtra(tal);
    final hasExtra = info.talents?.hasExtra(tal) ?? false;
    final style = context.themeStyles.label14n;
    final strut = style.toStrut();
    return Text(
      '${value ?? '-'} ',
      style: style.copyWith(
        color: hasExtra ? Colors.lightBlue : null,
      ),
      strutStyle: strut,
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
