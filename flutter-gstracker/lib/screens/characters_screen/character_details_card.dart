import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/static/cached_image_widget.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/ascension_status.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/screens/widgets/materials_table.dart';
import 'package:tracker/theme/gs_assets.dart';

class CharacterDetailsCard extends StatelessWidget with GsDetailedDialogMixin {
  final GsCharacter item;
  final Color bgColor;

  CharacterDetailsCard(this.item, {super.key})
    : bgColor = Color.lerp(
        Colors.black,
        item.element.color,
        0.2,
      )!.withValues(alpha: 0.6);

  @override
  Widget build(BuildContext context) {
    final namecards = Database.instance.infoOf<GsNamecard>();
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final utils = GsUtils.characters;
        final info = utils.getCharInfo(item.id);
        final hasChar = utils.hasCaracter(item.id);
        final ascension = info?.ascension ?? 0;
        final friendship = info?.friendship ?? 1;
        final constellation = info?.totalConstellations;
        final namecard = namecards.getItem(info?.item.namecardId ?? '');
        late final owned = (constellation ?? 0) + 1;

        return ItemDetailsCard(
          name: item.name,
          rarity: item.rarity,
          image: item.image,
          version: item.version,
          bgImage: namecard?.fullImage,
          contentImage: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(item.element.assetBgPath),
          ),
          info: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: context.themeStyles.label14n),
              const SizedBox(height: kSeparator4),
              if (hasChar) ...[
                Row(
                  children: [
                    GsItemCardLabel(
                      asset: item.element.assetPath,
                      label: constellation != null ? 'C$constellation' : null,
                    ),
                    const SizedBox(width: kSeparator4),
                    GsItemCardLabel(
                      asset: AppAssets.companionXp,
                      label: friendship.toString(),
                      onTap: () => GsUtils.characters
                          .increaseFriendshipCharacter(item.id),
                    ),
                  ],
                ),
                const SizedBox(height: kSeparator4),
                Row(
                  spacing: GsSpacing.kGridSeparator,
                  children: CharTalentType.values
                      .map((e) => _talentLabel(info, e))
                      .toList(),
                ),
                InkWell(
                  onTap: () => GsUtils.characters.increaseAscension(item.id),
                  child: Text(
                    '${'✦' * ascension}${'✧' * (6 - ascension)}',
                    style: context.themeStyles.title20n,
                  ),
                ),
              ],
            ],
          ),
          child: Stack(
            children: [
              if (item.constellationImage.isNotEmpty)
                Positioned.fill(
                  bottom: null,
                  child: CachedImageWidget(
                    item.constellationImage,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    scaleToSize: false,
                    showPlaceholder: false,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: kSeparator6),
                child: Column(
                  spacing: kSeparator8,
                  children: [
                    Text(
                      item.description,
                      style: context.themeStyles.label12n.copyWith(
                        color: context.themeColors.almostWhite,
                      ),
                    ),
                    _getAttributes(context, item),
                    _getStats(context, item),
                    _getMaterials(context, item),
                    if (hasChar)
                      Text(
                        context.labels.amountObtained(owned),
                        style: context.themeStyles.label12i,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _talentLabel(CharInfo? info, CharTalentType tal) {
    return GsItemCardLabel(
      label: info?.talents?.talentWithExtra(tal).toString() ?? '-',
      onTap: () => GsUtils.characters.increaseTalent(item.id, tal),
      fgColor: (ctx) {
        return info?.talents?.hasExtra(tal) ?? false
            ? ctx.themeColors.extraTalent
            : Colors.white;
      },
    );
  }

  Widget _getAttributes(BuildContext context, GsCharacter info) {
    final style = context.textTheme.titleSmall!;
    final stLabel = style.copyWith(color: context.themeColors.almostWhite);
    final stStyle = style.copyWith(color: Colors.white);
    final db = Database.instance.infoOf<GsRecipe>();
    final dish = db.getItem(info.specialDish);
    final version = GsUtils.versions.getName(info.version);

    final labels = context.labels;
    final data = <String, Widget>{
      labels.version(): Text(version),
      labels.element(): Text(info.element.label(context)),
      labels.weapon(): Text(info.weapon.label(context)),
      labels.region(): Text(info.region.label(context)),
      labels.constellation(): Text(info.constellation),
      labels.affiliation(): Text(info.affiliation),
      labels.birthday(): Text(info.birthday.toPrettyDate(context)),
      labels.releaseDate(): Text(info.releaseDate.toPrettyDate(context)),
      labels.specialDish(): dish != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(child: Text(dish.name)),
                const SizedBox(width: kSeparator8),
                ItemGridWidget.recipe(dish, tooltip: ''),
              ],
            )
          : Text(labels.wsNone()),
    };

    return GsDataBox.info(
      title: Text(context.labels.attributes()),
      bgColor: bgColor,
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {0: IntrinsicColumnWidth()},
          border: TableBorder(
            horizontalInside: BorderSide(
              color: context.themeColors.divider,
              width: 0.4,
            ),
          ),
          children: data.entries.map((entry) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                  child: Text(entry.key, style: stLabel),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                  child: DefaultTextStyle(
                    style: stStyle,
                    textAlign: TextAlign.end,
                    child: entry.value,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _getStats(BuildContext context, GsCharacter item) {
    return GsDataBox.info(
      bgColor: bgColor,
      title: Text(context.labels.status()),
      child: AscensionStatus.character(item),
    );
  }

  Widget _getMaterials(BuildContext context, GsCharacter item) {
    final ic = GsUtils.materials;
    final tltMats = ic.getAllCharTalents(item);
    final ascMats = ic.getCharAscension(item);
    final ascLvl = ic.getCharAscensionByLevel(item);
    final tltLvl = ic.getCharTalentsByLevel(item);

    int existance(String? id) {
      if (id == null) return 0;
      final a = tltMats.any((k, v) => k.id == id) ? 1 : 0;
      final b = ascMats.any((k, v) => k.id == id) ? 1 : 0;
      return a + b;
    }

    return Column(
      spacing: kSeparator8,
      mainAxisSize: MainAxisSize.min,
      children: [
        GsDataBox.info(
          bgColor: bgColor,
          title: Text(context.labels.ascension()),
          child: MaterialsTable(
            matsTotal: ascMats,
            matsByLevel: ascLvl,
            sort: (list) => list.sortedBy((e) => existance(e.key.id)),
          ),
        ),
        GsDataBox.info(
          bgColor: bgColor,
          title: Text(context.labels.talents()),
          child: MaterialsTable(
            matsTotal: tltMats,
            matsByLevel: tltLvl,
            sort: (list) => list.sortedBy((e) => existance(e.key.id)),
          ),
        ),
      ],
    );
  }
}
