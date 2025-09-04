import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_icon_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/theme/gs_assets.dart';

class RemarkableChestDetailsCard extends StatelessWidget
    with GsDetailedDialogMixin {
  final GsFurnitureChest item;

  const RemarkableChestDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final db = Database.instance.saveOf<GiFurnitureChest>();
        final owned = db.exists(item.id);
        return ItemDetailsCard(
          name: item.name,
          image: item.image,
          rarity: item.rarity,
          version: item.version,
          info: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          GsAssets.iconSetType(item.type),
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(width: kSeparator4),
                        Text(item.type.label(context)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: kSeparator8),
                      child: Text(
                        item.region.label(context),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: GsIconButton.owned(
                  owned: owned,
                  onPress:
                      (own) => GsUtils.furnitureChests.update(
                        item.id,
                        obtained: own,
                      ),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(kSeparator16),
          child: Column(
            spacing: kSeparator16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemDetailsCardInfo.section(
                title: Text(item.type.label(context)),
                content: Text(context.labels.energyN(item.energy.format())),
              ),
            ],
          ),
        );
      },
    );
  }
}
