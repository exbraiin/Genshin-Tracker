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
      child: ItemDetailsCardContent.generate(context, [
        if (item.pc1.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.nPieceBonus(1),
            description: item.pc1,
          ),
        if (item.pc2.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.nPieceBonus(2),
            description: item.pc2,
          ),
        if (item.pc4.isNotEmpty)
          ItemDetailsCardContent(
            label: context.labels.nPieceBonus(4),
            description: item.pc4,
          ),
        ItemDetailsCardContent(
          label: context.labels.pieces(),
          content: Column(
            children: item.pieces.map((e) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(right: kSeparator8),
                    child: CachedImageWidget(e.icon),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.name,
                          style: context.themeStyles.label14b
                              .copyWith(color: context.themeColors.mainColor0),
                        ),
                        const SizedBox(height: kSeparator4),
                        Text(
                          e.desc,
                          style: context.themeStyles.label12n
                              .copyWith(color: context.themeColors.mainColor1),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
