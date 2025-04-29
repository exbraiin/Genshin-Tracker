import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/static/cached_image_widget.dart';

class ArtifactDetailsCard extends StatelessWidget with GsDetailedDialogMixin {
  final GsArtifact item;

  const ArtifactDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ItemDetailsCard(
      name: item.name,
      image: item.pieces.firstOrNull?.icon,
      info: Text(item.domain),
      rarity: item.rarity,
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      contentPadding: EdgeInsets.all(kSeparator16),
      child: Column(
        spacing: kSeparator16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.pc1.isNotEmpty)
            ItemDetailsCardInfo.section(
              title: Text(context.labels.nPieceBonus(1)),
              content: Text(item.pc1),
            ),
          if (item.pc2.isNotEmpty)
            ItemDetailsCardInfo.section(
              title: Text(context.labels.nPieceBonus(2)),
              content: Text(item.pc2),
            ),
          if (item.pc4.isNotEmpty)
            ItemDetailsCardInfo.section(
              title: Text(context.labels.nPieceBonus(4)),
              content: Text(item.pc4),
            ),
          ItemDetailsCardInfo.section(
            title: Text(context.labels.pieces()),
            content: Column(
              spacing: kSeparator8,
              children: item.pieces.map((e) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      margin: const EdgeInsets.only(right: kSeparator8),
                      child: CachedImageWidget(e.icon),
                    ),
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 64),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name,
                              style: context.themeStyles.label14b.copyWith(
                                color: context.themeColors.mainColor0,
                              ),
                            ),
                            const SizedBox(height: kSeparator2),
                            Text(
                              e.desc,
                              style: context.themeStyles.label12n.copyWith(
                                color: context.themeColors.mainColor1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
