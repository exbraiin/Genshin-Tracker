import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/static/circle_widget.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class SereniteaSetDetailsCard extends StatelessWidget
    with GsDetailedDialogMixin {
  final GsSereniteaSet item;

  const SereniteaSetDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final ic = Database.instance.infoOf<GsCharacter>();
    return ItemDetailsCard(
      name: item.name,
      fgImage: item.image,
      rarity: 4,
      version: item.version,
      info: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            ItemIconWidget.asset(GsAssets.iconSetType(item.category), size: 32),
            const SizedBox(width: kSeparator4),
            Text(item.category.label(context)),
          ],
        ),
      ),
      contentPadding: EdgeInsets.all(kSeparator16),
      child: Column(
        spacing: kSeparator16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.energy > 0)
            ItemDetailsCardInfo.section(
              title: Text(item.category.label(context)),
              content: Text(context.labels.energyN(item.energy.format())),
            ),
          if (item.chars.isNotEmpty)
            ItemDetailsCardInfo.section(
              title: Text(context.labels.characters()),
              content: ValueStreamBuilder<bool>(
                stream: Database.instance.loaded,
                builder: (context, snapshot) {
                  final saved = Database.instance
                      .saveOf<GiSereniteaSet>()
                      .getItem(item.id);
                  return Wrap(
                    spacing: kSeparator4,
                    runSpacing: kSeparator4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children:
                        item.chars
                            .map(ic.getItem)
                            .whereNotNull()
                            .sortedBy(
                              (e) =>
                                  GsUtils.characters.hasCaracter(e.id) ? 0 : 1,
                            )
                            .thenByDescending((element) => element.rarity)
                            .thenBy((element) => element.name)
                            .map((char) {
                              final owns = GsUtils.characters.hasCaracter(
                                char.id,
                              );
                              final marked =
                                  saved?.chars.contains(char.id) ?? false;
                              return Opacity(
                                opacity: owns ? 1 : 0.4,
                                child: Stack(
                                  children: [
                                    ItemGridWidget.character(
                                      char,
                                      onTap:
                                          owns
                                              ? (ctx, i) => GsUtils
                                                  .sereniteaSets
                                                  .setSetCharacter(
                                                    item.id,
                                                    char.id,
                                                    owned: !marked,
                                                  )
                                              : null,
                                    ),
                                    if (marked)
                                      const Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleWidget(
                                            color: Colors.black,
                                            borderColor: Colors.white,
                                            borderSize: 1.6,
                                            size: 20,
                                            child: Icon(
                                              Icons.check_rounded,
                                              color: Colors.lightGreen,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            })
                            .toList(),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
