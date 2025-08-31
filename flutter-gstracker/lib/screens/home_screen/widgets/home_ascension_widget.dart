import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class HomeAscensionWidget extends StatelessWidget {
  const HomeAscensionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final characters = Database.instance
            .infoOf<GsCharacter>()
            .items
            .where(GsUtils.characters.isCharAscendable)
            .sortedByDescending((e) => e.rarity)
            .thenBy((e) => e.id);

        if (characters.isEmpty) {
          return GsDataBox.info(
            title: Text(context.labels.ascension()),
            child: const GsNoResultsState.small(),
          );
        }

        final chars = GsUtils.characters;
        return GsDataBox.info(
          title: Text(context.labels.ascension()),
          child: LayoutBuilder(
            builder: (context, layout) {
              final itemSize = kSize50 + GsSpacing.kGridSeparator;
              final width = layout.maxWidth;
              final items = (width ~/ itemSize).coerceAtMost(8);
              final list = characters.take(items);
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        list
                            .map<Widget>((info) {
                              return ItemGridWidget.character(
                                info,
                                label: '✦${chars.getCharAscension(info.id)}',
                                onAdd:
                                    (ctx) => GsUtils.characters
                                        .increaseAscension(info.id),
                              );
                            })
                            .separate(
                              const SizedBox(width: GsSpacing.kGridSeparator),
                            )
                            .toList(),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
