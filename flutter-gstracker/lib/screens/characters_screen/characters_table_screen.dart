import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/src/iterable_ext.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/characters_screen/character_details_card.dart';
import 'package:tracker/screens/screen_filters/screen_filter_builder.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class CharactersTableScreen extends StatefulWidget {
  static const id = 'characters_table_screen';

  const CharactersTableScreen({super.key});

  @override
  State<CharactersTableScreen> createState() => _CharactersTableScreenState();
}

class _CharactersTableScreenState extends State<CharactersTableScreen> {
  var _sortIndex = -1;
  var _ascending = false;
  var _idSortedList = <String>[];

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final items = Database.instance.infoOf<GsCharacter>().items;
        return ScreenFilterBuilder<GsCharacter>(
          builder: (context, filter, button, toggle) {
            final list = _getCharsSorted(filter.match(items)).where(
              (e) =>
                  !filter.hasExtra(FilterExtras.hide) ||
                  e.talentsTotal < CharTalents.kTotalCrownless && e.isOwned,
            );

            return InventoryPage(
              appBar: InventoryAppBar(
                label: context.labels.characters(),
                iconAsset: AppAssets.menuIconCharacters,
                actions: [
                  IconButton(
                    tooltip: context.labels.hideTableCharacters(),
                    onPressed: () => toggle(FilterExtras.hide),
                    icon:
                        filter.hasExtra(FilterExtras.hide)
                            ? Icon(Icons.visibility_off_rounded)
                            : Icon(Icons.visibility_rounded),
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  button,
                ],
              ),
              child: InventoryBox(child: _getList(context, list)),
            );
          },
        );
      },
    );
  }

  Widget _getList(BuildContext context, Iterable<CharInfo> characters) {
    final builders = _getBuilders(context);
    final sortItem = _sortIndex != -1 ? builders[_sortIndex] : null;

    void applySort(_TableItem item, int index) {
      setState(() {
        if (sortItem == null || sortItem != item) {
          _ascending = true;
          _sortIndex = index;
        } else if (_ascending) {
          _ascending = false;
        } else {
          _ascending = true;
          _sortIndex = -1;
        }

        _idSortedList = _getCharsIdsSorted(characters, sortItem);
      });
    }

    return SingleChildScrollView(
      child: Table(
        columnWidths: builders
            .mapIndexed((i, e) => (index: i, item: e))
            .toMap(
              (e) => e.index,
              (e) =>
                  e.item.expand
                      ? const FlexColumnWidth()
                      : const IntrinsicColumnWidth(),
            ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.symmetric(
          inside: BorderSide(color: context.themeColors.mainColor0),
        ),
        children: [
          TableRow(
            children:
                builders.mapIndexed((index, item) {
                  return InkWell(
                    onTap:
                        item.sortBy != null
                            ? () => applySort(item, index)
                            : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kSeparator4,
                        horizontal: kSeparator8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            item.label,
                            textAlign: !item.expand ? TextAlign.center : null,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            sortItem == item
                                ? _ascending
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded
                                : null,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
          ...characters.map((item) {
            return TableRow(
              children:
                  builders.map<Widget>((e) {
                    final child = Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kSeparator4,
                        horizontal: kSeparator8,
                      ),
                      child: Opacity(
                        opacity: item.isOwned ? 1 : kDisableOpacity,
                        child: e.builder(item),
                      ),
                    );

                    if (e.onTap != null && (e.allowTap || item.isOwned)) {
                      return InkWell(onTap: () => e.onTap!(item), child: child);
                    }

                    return child;
                  }).toList(),
            );
          }),
        ],
      ),
    );
  }

  List<_TableItem> _getBuilders(BuildContext context) {
    Color getGoodColor(int value, int max) {
      return context.themeColors.colorByPity(max - value, max);
    }

    double unowned() => _ascending ? double.infinity : double.negativeInfinity;
    return [
      _TableItem(
        label: context.labels.tableTitleCharacter(),
        sortBy: (e) => e.item.element.index,
        builder: (info) {
          return Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ItemCircleWidget(
                  image: info.item.image,
                  rarity: info.item.rarity,
                  size: kSize50,
                ),
                Positioned(
                  right: -6,
                  bottom: -6,
                  child: ItemIconWidget.asset(
                    info.item.element.assetPath,
                    size: 24,
                  ),
                ),
              ],
            ),
          );
        },
        allowTap: true,
        onTap: (info) => CharacterDetailsCard(info.item).show(context),
      ),
      _TableItem(
        label: context.labels.tableTitleName(),
        sortBy: (e) => e.item.name,
        builder: (info) => Text(info.item.name),
        expand: true,
      ),
      _TableItem(
        label: context.labels.tableTitleFriendship(),
        sortBy: (e) => e.isOwned ? e.friendship : unowned(),
        builder:
            (info) => Text(
              info.isOwned ? '${info.friendship}' : context.labels.tableEmpty(),
              textAlign: TextAlign.center,
              style: TextStyle(color: getGoodColor(info.friendship, 10)),
            ),
        onTap:
            (info) =>
                GsUtils.characters.increaseFriendshipCharacter(info.item.id),
      ),
      _TableItem(
        label: context.labels.tableTitleAscension(),
        sortBy: (e) => e.isOwned ? e.ascension : unowned(),
        builder:
            (info) => Text(
              info.isOwned
                  ? context.labels.tableNumAsc(info.ascension)
                  : context.labels.tableEmpty(),
              textAlign: TextAlign.center,
              style: TextStyle(color: getGoodColor(info.ascension, 6)),
            ),
        onTap: (info) => GsUtils.characters.increaseAscension(info.item.id),
      ),
      _TableItem(
        label: context.labels.tableTitleConstellation(),
        sortBy: (e) => e.isOwned ? e.totalConstellations : unowned(),
        builder:
            (info) => Text.rich(
              info.isOwned
                  ? TextSpan(
                    children: [
                      TextSpan(
                        text: context.labels.tableNumCons(info.constellations),
                      ),
                      if (info.extraConstellations > 0)
                        TextSpan(
                          text: ' +${info.extraConstellations}',
                          style: context.themeStyles.label12i.copyWith(
                            fontSize: 10,
                          ),
                        ),
                    ],
                  )
                  : TextSpan(text: context.labels.tableEmpty()),
              textAlign: TextAlign.center,
            ),
      ),
      ...CharTalentType.values.map((e) => _talentTableItem(e)),
      _TableItem(
        label: context.labels.tableTitleTalTotal(),
        sortBy: (e) => e.talents?.total ?? unowned(),
        builder: (info) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                info.talents?.total.toString() ?? context.labels.tableEmpty(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      info.talentsTotal >= CharTalents.kTotal
                          ? context.themeColors.starColor
                          : getGoodColor(
                            info.talentsTotal,
                            CharTalents.kTotalCrownless,
                          ),
                ),
              ),
              if (info.talentsTotal >= CharTalents.kTotal)
                Padding(
                  padding: EdgeInsets.only(left: kSeparator2),
                  child: Icon(
                    Icons.star_rounded,
                    color: context.themeColors.starColor,
                  ),
                ),
            ],
          );
        },
      ),
    ];
  }

  _TableItem _talentTableItem(CharTalentType tal) {
    double unowned() => _ascending ? double.infinity : double.negativeInfinity;

    final label = switch (tal) {
      CharTalentType.attack => context.labels.tableTitleTalAttack(),
      CharTalentType.skill => context.labels.tableTitleTalSkill(),
      CharTalentType.burst => context.labels.tableTitleTalBurst(),
    };

    return _TableItem(
      label: label,
      sortBy: (e) => e.talents?.talent(tal) ?? unowned(),
      builder: (info) {
        final value = info.talents?.talentWithExtra(tal);
        final hasExtra = info.talents?.hasExtra(tal) ?? false;
        return Text(
          value?.toString() ?? context.labels.tableEmpty(),
          textAlign: TextAlign.center,
          style: TextStyle(color: hasExtra ? Colors.lightBlue : null),
        );
      },
      onTap: (info) => GsUtils.characters.increaseTalent(info.item.id, tal),
    );
  }

  Iterable<CharInfo> _getCharsSorted(Iterable<GsCharacter> characters) {
    final info = GsUtils.characters.getCharInfo;
    var chars = characters.map((e) => info(e.id)).whereNotNull();

    if (_idSortedList.isNotEmpty) {
      chars = chars.sortedBy((e) => _idSortedList.indexOf(e.item.id));
    }
    return chars;
  }

  List<String> _getCharsIdsSorted(
    Iterable<CharInfo> chars,
    _TableItem? sortItem,
  ) {
    if (sortItem == null) return const [];

    final sorted = _ascending ? chars.sortedBy : chars.sortedByDescending;
    return sorted((e) => sortItem.sortBy?.call(e) ?? 0)
        .thenByDescending((e) => e.item.releaseDate)
        .thenBy((e) => e.item.name)
        .map((e) => e.item.id)
        .toList();
  }
}

class _TableItem {
  final String label;
  final bool expand;
  final bool allowTap;
  final Comparable Function(CharInfo)? sortBy;
  final void Function(CharInfo info)? onTap;
  final Widget Function(CharInfo info) builder;

  _TableItem({
    this.sortBy,
    required this.label,
    required this.builder,
    this.onTap,
    this.expand = false,
    this.allowTap = false,
  });
}
