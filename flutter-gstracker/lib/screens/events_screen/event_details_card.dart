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

class EventDetailsCard extends StatelessWidget with GsDetailedDialogMixin {
  final GsEvent item;

  EventDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final weapons = GsUtils.events.getEventWeapons(item.id);
    final characters = GsUtils.events.getEventCharacters(item.id);

    return ItemDetailsCard(
      name: item.name,
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.type.label(context), style: context.themeStyles.title18n),
        ],
      ),
      rarity: item.type == GeEventType.flagship ? 5 : 4,
      fgImage: item.image,
      version: item.version,
      contentPadding: EdgeInsets.all(kSeparator16),
      child: Column(
        spacing: kSeparator16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemDetailsCardInfo.section(
            title: Text(context.labels.duration()),
            content: Text(_eventDuration(context)),
          ),
          ItemDetailsCardInfo.section(
            title: Text(context.labels.version()),
            content: Text(item.version),
          ),
          if (weapons.isNotEmpty || characters.isNotEmpty)
            ItemDetailsCardInfo.section(
              title: Text(context.labels.rewards()),
              content: _getRewards(context, weapons, characters),
            ),
        ],
      ),
    );
  }

  Widget _item({required Widget child, required bool marked}) {
    return Stack(
      children: [
        child,
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
    );
  }

  String _eventDuration(BuildContext context) {
    return item.dateStart.year != 0 && item.dateEnd.year != 0
        ? '${DateTimeUtils.format(context, item.dateStart, item.dateEnd)} '
            '(${item.dateEnd.difference(item.dateStart).toShortTime(context)})'
        : context.labels.itemUpcoming();
  }

  Widget _getRewards(
    BuildContext context,
    List<GsWeapon> weapons,
    List<GsCharacter> characters,
  ) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        return Wrap(
          spacing: kSeparator4,
          runSpacing: kSeparator4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...characters.map((char) {
              final marked = GsUtils.events.ownsCharacter(item.id, char.id);
              return _item(
                child: ItemGridWidget.character(
                  char,
                  onTap:
                      (context, char) => GsUtils.events.toggleObtainedCharacter(
                        item.id,
                        char.id,
                      ),
                ),
                marked: marked,
              );
            }),
            ...weapons.map((weapon) {
              final marked = GsUtils.events.ownsWeapon(item.id, weapon.id);
              return _item(
                child: ItemGridWidget.weapon(
                  weapon,
                  onTap:
                      (context, weapon) => GsUtils.events.toggleObtainedtWeapon(
                        item.id,
                        weapon.id,
                      ),
                ),
                marked: marked,
              );
            }),
          ],
        );
      },
    );
  }
}
