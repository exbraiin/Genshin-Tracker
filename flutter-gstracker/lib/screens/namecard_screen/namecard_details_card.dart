import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/graphics/gs_spacing.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/domain/enums/enum_ext.dart';

class NamecardDetailsCard extends StatelessWidget with GsDetailedDialogMixin {
  final GsNamecard item;

  const NamecardDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ItemDetailsCard(
      name: item.name,
      rarity: item.rarity,
      fgImage: item.fullImage,
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      info: Align(
        alignment: Alignment.topLeft,
        child: Text(item.type.label(context)),
      ),
      contentPadding: EdgeInsets.all(kSeparator16),
      child: Column(
        spacing: kSeparator16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemDetailsCardInfo.description(text: Text(item.desc)),
        ],
      ),
    );
  }
}
