import 'package:flutter/widgets.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/widgets/gs_icon_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/domain/gs_database.dart';

class LunarArcanaDetailsCard extends StatelessWidget {
  final GsLunarArcana item;

  const LunarArcanaDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final db = Database.instance.saveOf<GiLunarArcana>();
    final owned = db.exists(item.id);
    return ItemDetailsCard(
      name: item.name,
      rarity: 4,
      image: item.image,
      version: item.version,
      showRarityStars: false,
      info: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(item.number.toString()),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: GsIconButton.owned(
              owned: owned,
              onPress: (own) =>
                  GsUtils.lunarArcana.update(item.id, obtained: own),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemDetailsCardInfo.description(text: Text(item.description)),
        ],
      ),
    );
  }
}
