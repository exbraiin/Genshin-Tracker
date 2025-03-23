import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
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

        final characters = iChar.items
            .where((c) => chars.hasCaracter(c.id))
            .map((c) => chars.getCharInfo(c.id))
            .whereNotNull()
            .where((data) {
              final hasMissingTalents = (data.talent1 ?? 10) < 9 ||
                  (data.talent2 ?? 10) < 9 ||
                  (data.talent3 ?? 10) < 9;

              late final talentMaterial =
                  iMats.getItem(data.item.talentMaterial);
              final hasWeekdayTalents = today == GeWeekdayType.sunday ||
                  talentMaterial != null &&
                      talentMaterial.weekdays.contains(today);

              return hasMissingTalents && hasWeekdayTalents;
            })
            .sortedByDescending((c) => c.item.rarity)
            .thenByDescending((c) => c.talents ?? 0)
            .thenBy((c) => c.item.releaseDate)
            .thenBy((c) => c.item.id);

        if (characters.isEmpty) {
          return GsDataBox.info(
            title: Text(context.labels.talents()),
            child: const GsNoResultsState.small(),
          );
        }

        const kItemSize = ItemSize.large;
        return GsDataBox.info(
          title: Text(context.labels.talents()),
          child: LayoutBuilder(
            builder: (context, layout) {
              final itemSize = kItemSize.gridSize + kGridSeparator;
              final width = layout.maxWidth;
              final items = (width ~/ itemSize).coerceAtMost(8);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: characters
                    .take(items)
                    .map<Widget>((info) {
                      return ItemGridWidget.character(
                        size: kItemSize,
                        info.item,
                        label: '${info.talent1 ?? 1} '
                            '${info.talent2 ?? 1} '
                            '${info.talent3 ?? 1}',
                      );
                    })
                    .separate(const SizedBox(width: kGridSeparator))
                    .toList(),
              );
            },
          ),
        );
      },
    );
  }
}
