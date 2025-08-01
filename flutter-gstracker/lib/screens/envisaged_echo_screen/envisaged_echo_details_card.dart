import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/widgets/gs_icon_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/theme/gs_assets.dart';

class EnvisagedEchoDetailsCard extends StatelessWidget {
  final GsEnvisagedEcho item;

  const EnvisagedEchoDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = Database.instance;
    final owned = GsUtils.echos.hasItem(item.id);
    final char = db.infoOf<GsCharacter>().getItem(item.character);
    return ItemDetailsCard(
      name: item.name,
      image: item.icon,
      rarity: item.rarity,
      version: item.version,
      info: Column(
        children: [
          Align(alignment: Alignment.topLeft, child: Text(char?.name ?? '')),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: GsIconButton(
              size: 26,
              color:
                  owned
                      ? context.themeColors.goodValue
                      : context.themeColors.badValue,
              icon: owned ? Icons.check : Icons.close,
              onPress: () => GsUtils.echos.update(item.id, !owned),
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.all(kSeparator16),
      child: Column(
        spacing: kSeparator16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemDetailsCardInfo.description(text: Text(item.description)),
        ],
      ),
    );
  }
}
