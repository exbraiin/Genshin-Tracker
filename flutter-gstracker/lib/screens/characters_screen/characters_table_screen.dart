import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_divider.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/characters_screen/character_widgets.dart';
import 'package:tracker/screens/characters_screen/utils_sort_characters.dart';
import 'package:tracker/screens/materials_screen/material_details_card.dart';
import 'package:tracker/screens/screen_filters/screen_filter_builder.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class CharactersTableScreen extends StatelessWidget {
  static const id = 'characters_table_screen';

  const CharactersTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final utilsChars = GsUtils.characters;
        final listOfChars = Database.instance.infoOf<GsCharacter>().items;

        return ScreenFilterBuilder<GsCharacter>(
          builder: (context, filter, button, toggle) {
            final list = filter
                .match(listOfChars)
                .map((e) => utilsChars.getCharInfo(e.id))
                .whereNotNull()
                .toList();
            final grouped = groupCharactersByDays(list);
            final sorted = sortCharactersByDays(grouped);

            return InventoryPage(
              appBar: InventoryAppBar(
                label: context.labels.characters(),
                iconAsset: AppAssets.menuIconCharacters,
                actions: [button],
              ),
              child: _MatsByDays(sorted),
            );
          },
        );
      },
    );
  }
}

class _MatsByDays extends StatelessWidget {
  final DaysMap mapOfCharacters;

  const _MatsByDays(this.mapOfCharacters);

  @override
  Widget build(BuildContext context) {
    if (mapOfCharacters.values.every((e) => e.isEmpty)) {
      return InventoryBox(child: Center(child: GsNoResultsState.small()));
    }

    final size = kSize56;
    final versions = Database.instance.infoOf<GsVersion>();
    final weekMats = Database.instance
        .infoOf<GsMaterial>()
        .items
        .where((e) => e.group == GeMaterialType.weeklyBossDrops)
        .sortedBy((e) => e.region.index)
        .thenBy((e) => versions.getItem(e.version)?.releaseDate ?? DateTime(0))
        .thenBy((e) => e.id);
    final listMats = InventoryBox(
      width: size + GsSpacing.kListPadding.left + GsSpacing.kListPadding.right,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(kSeparator8),
            child: Image.asset(
              AppAssets.menuIconMaterials,
              width: 20,
              height: 20,
            ),
          ),
          GsDivider(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: kSeparator8),
              itemCount: weekMats.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: kSeparator4),
              itemBuilder: (context, index) {
                final item = weekMats[index];
                final child = ItemGridWidget.material(
                  item,
                  size: size,
                  label: GsUtils.materials
                      .getMaterialOwnedAmount(item.id)
                      .compact(),
                  onTap: (context, item) => MaterialDetailsCard(
                    item,
                    allowEditing: true,
                  ).show(context),
                );
                if (index == 0 ||
                    item.region != weekMats.elementAt(index - 1).region) {
                  return Column(
                    spacing: kSeparator8,
                    children: [
                      if (index != 0) SizedBox(height: kSeparator8),
                      SizedBox(
                        width: size / 2,
                        height: size / 2,
                        child: Image.asset(
                          GsAssets.iconRegionType(item.region),
                        ),
                      ),
                      child,
                    ],
                  );
                }
                return child;
              },
            ),
          ),
        ],
      ),
    );

    final isLimitedDaysToday = isLimitedDays();
    return Row(
      spacing: GsSpacing.kGridSeparator,
      children: mapOfCharacters.entries
          .map<Widget>((entry) {
            final days = entry.key;
            final chars = entry.value;
            late final isFarmable =
                days.day1.isFarmableToday ||
                days.day2.isFarmableToday ||
                isLimitedDaysToday;

            return Expanded(
              child: InventoryBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(kSeparator8),
                      child: Row(
                        children: [
                          Text(
                            '${days.day1.getLabel(context).substring(0, 3)} & '
                            '${days.day2.getLabel(context).substring(0, 3)}',
                            style: context.themeStyles.label14b,
                          ),
                          if (isLimitedDaysToday)
                            Text(
                              '  \u2022  Limited Days',
                              style: context.themeStyles.label12i.copyWith(
                                color: context.themeColors.starColor,
                              ),
                            ),
                          Spacer(),
                          Text('${chars.length}'),
                          SizedBox(width: kSeparator4),
                          Image.asset(
                            AppAssets.menuIconCharacters,
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    GsDivider(),
                    Expanded(
                      child: chars.isEmpty
                          ? Center(child: GsNoResultsState.small())
                          : ListView.separated(
                              padding: EdgeInsets.all(kSeparator8),
                              itemCount: chars.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: kSeparator4),
                              itemBuilder: (context, index) {
                                final widget = _listItem(
                                  context,
                                  chars[index],
                                  isToday: isFarmable,
                                );

                                late final cRarity = chars[index].item.rarity;
                                late final pRarity =
                                    chars[index - 1].item.rarity;
                                if (index == 0 || cRarity != pRarity) {
                                  return _raritySeparator(
                                    context,
                                    rarity: cRarity,
                                    isToday: isFarmable,
                                    hasTopPadding: index > 0,
                                    child: widget,
                                  );
                                }
                                return widget;
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          })
          .appendElement(listMats)
          .toList(),
    );
  }

  Widget _raritySeparator(
    BuildContext context, {
    required int rarity,
    required bool hasTopPadding,
    required bool isToday,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTopPadding) SizedBox(height: kSeparator16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            rarity,
            (i) => Transform.translate(
              offset: Offset(i * -4, 0),
              child: Opacity(
                opacity: isToday ? 1 : kDisableOpacity,
                child: Icon(
                  Icons.star_rounded,
                  size: 18,
                  color: context.themeColors.starColor,
                  shadows: GsSpacing.kMainShadow,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: kSeparator6),
        child,
      ],
    );
  }

  Widget _listItem(
    BuildContext context,
    CharInfo info, {
    required bool isToday,
  }) {
    final double size = 60.0;
    final mats = GsUtils.materials.getCharTalentsMissing(
      info.item,
      info.info,
      CharTalents.kCrownless,
    );

    return Row(
      spacing: kSeparator8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 30,
          height: size,
          child: Align(
            alignment: AlignmentGeometry.centerRight,
            child: Text(
              '${info.talentsTotal} \u2022',
              maxLines: 1,
              style: context.themeStyles.label14n,
            ),
          ),
        ),
        ItemGridWidget.character(
          info.item,
          size: size,
          disabled: !isToday,
          labelWidget: CharaterTalentsLabel(info),
        ),
        SizedBox(
          height: size,
          width: 24,
          child: Image.asset(GsAssets.iconRegionType(info.item.region)),
        ),
        Expanded(
          child: Wrap(
            spacing: kSeparator4,
            runSpacing: kSeparator4,
            alignment: WrapAlignment.start,
            children: mats.entries.map((mat) {
              return ItemGridWidget.material(
                mat.key,
                size: size,
                disabled: !isToday,
                label: mat.key.group == GeMaterialType.weeklyBossDrops
                    ? '${GsUtils.materials.getMaterialOwnedAmount(mat.key.id).compact()} /${mat.value.compact()}'
                    : mat.value.compact(),
                labelWidget: _materialAmountLabel(context, mat.key, mat.value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _materialAmountLabel(
    BuildContext context,
    GsMaterial material,
    int amount,
  ) {
    if (material.group != GeMaterialType.weeklyBossDrops) {
      return Text(amount.compact(), maxLines: 1);
    }

    final owned = GsUtils.materials.getMaterialOwnedAmount(material.id);
    final color = owned < amount
        ? context.themeColors.badValue
        : context.themeColors.goodValue;

    return Text(
      '${owned.compact()} /${amount.compact()}',
      maxLines: 1,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
