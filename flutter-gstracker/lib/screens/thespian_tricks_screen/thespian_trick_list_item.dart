import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/theme/gs_assets.dart';

class ThespianTrickListItem extends StatelessWidget {
  final bool selected;
  final GsThespianTrick item;
  final VoidCallback? onTap;

  const ThespianTrickListItem(
    this.item, {
    super.key,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final table = Database.instance.saveOf<GiThespianTrick>();
    final character = Database.instance.infoOf<GsCharacter>().getItem(
      item.character,
    );

    final owned = table.exists(item.id);

    return GsItemCardButton(
      label: item.name.isNotEmpty ? item.name : context.labels.unknown(),
      rarity: item.rarity,
      onTap: onTap,
      disable: !owned,
      selected: selected,
      banner: GsItemBanner.isNewOrUpcoming(context, item.version),
      imageUrlPath: character?.image,
      child: Stack(
        children: [
          Positioned(
            top: kSeparator6,
            left: kSeparator6,
            child: Text(
              '${item.season}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                shadows: GsSpacing.kMainShadowText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
