import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_divider.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/domain/utils/gu_materials.dart';
import 'package:tracker/screens/characters_screen/character_details_card.dart';
import 'package:tracker/screens/characters_screen/character_widgets.dart';
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
                    icon: filter.hasExtra(FilterExtras.hide)
                        ? Icon(Icons.visibility_off_rounded)
                        : Icon(Icons.visibility_rounded),
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  IconButton(
                    onPressed: () => toggle(FilterExtras.versionSort),
                    icon: Icon(Icons.swap_horiz_rounded),
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  button,
                ],
              ),
              child: filter.hasExtra(FilterExtras.versionSort)
                  ? _MatsList(list)
                  : InventoryBox(child: _getTableList(context, list)),
            );
          },
        );
      },
    );
  }

  Widget _getTableList(BuildContext context, Iterable<CharInfo> characters) {
    final builders = _getBuilders(context);
    final sortItem = builders.elementAtOrNull(_sortIndex);

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

        final sorter = builders.elementAtOrNull(_sortIndex);
        _idSortedList = _getCharsIdsSorted(characters, sorter);
      });
    }

    final list = characters.toList();
    return Column(
      children: [
        Row(
          children: builders.mapIndexed((index, builder) {
            final child = InkWell(
              onTap: builder.sortBy != null
                  ? () => applySort(builder, index)
                  : null,
              child: Container(
                padding: const EdgeInsets.all(kSeparator8),
                child: Row(
                  children: [
                    Text(
                      builder.label,
                      textAlign: !builder.expand ? TextAlign.center : null,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      sortItem == builder
                          ? _ascending
                                ? Icons.arrow_drop_up_rounded
                                : Icons.arrow_drop_down_rounded
                          : null,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );

            return builder.expand
                ? Expanded(child: child)
                : SizedBox(width: builder.width, child: child);
          }).toList(),
        ),
        GsDivider(),
        Expanded(
          child: ListView.separated(
            itemCount: list.length,
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.white.withValues(alpha: 0.09),
                indent: kSeparator16,
                endIndent: kSeparator16,
              );
            },
            itemBuilder: (context, index) {
              final item = list[index];
              return SizedBox(
                height: 44,
                child: Row(
                  children: builders.map((builder) {
                    Widget child = Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kSeparator4,
                        horizontal: kSeparator8,
                      ),
                      child: Opacity(
                        opacity: item.isOwned ? 1 : kDisableOpacity,
                        child: builder.builder(item),
                      ),
                    );

                    if (builder.onTap != null &&
                        (builder.allowTap || item.isOwned)) {
                      child = InkWell(
                        onTap: () => builder.onTap!(item),
                        child: child,
                      );
                    }

                    return builder.expand
                        ? Expanded(child: child)
                        : SizedBox(width: builder.width, child: child);
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
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
        expand: true,
        label: context.labels.tableTitleName(),
        sortBy: (e) => e.item.name,
        builder: (info) => Text(info.item.name),
      ),
      _TableItem(
        label: context.labels.tableTitleFriendship(),
        sortBy: (e) => e.isOwned ? e.friendship : unowned(),
        builder: (info) => Text(
          info.isOwned ? '${info.friendship}' : context.labels.tableEmpty(),
          textAlign: TextAlign.center,
          style: TextStyle(color: getGoodColor(info.friendship, 10)),
        ),
        onTap: (info) =>
            GsUtils.characters.increaseFriendshipCharacter(info.item.id),
      ),
      _TableItem(
        label: context.labels.tableTitleAscension(),
        sortBy: (e) => e.isOwned ? e.ascension : unowned(),
        builder: (info) => Text(
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
        builder: (info) => Text.rich(
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
                  color: info.talentsTotal >= CharTalents.kTotal
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
          style: TextStyle(
            color: hasExtra ? context.themeColors.extraTalent : null,
          ),
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

  late final width = () {
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          fontFamily: defaultFontFamily,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    return painter.size.width + kSeparator8 * 2 + 28;
  }();

  _TableItem({
    this.sortBy,
    required this.label,
    required this.builder,
    this.onTap,
    this.expand = false,
    this.allowTap = false,
  });
}

class _MatsList extends StatefulWidget {
  final Iterable<CharInfo> characters;

  const _MatsList(this.characters);

  @override
  State<_MatsList> createState() => _MatsListState();
}

class _MatsListState extends State<_MatsList> {
  var talent = 9;
  var ascension = 6;
  Future<_MissMats>? future;

  @override
  void initState() {
    super.initState();
    future = _missingMaterials(maxTalent: talent, maxAscension: ascension);
  }

  @override
  void didUpdateWidget(covariant _MatsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    future = _missingMaterials(maxTalent: talent, maxAscension: ascension);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: GsSpacing.kGridSeparator,
      children: [
        _materialsBox(
          label: context.labels.talents(),
          filter: (mats) => mats.talents,
          value: talent,
          values: (min: 2, max: 10),
          setValue: (value) => talent = value,
        ),
        _materialsBox(
          label: context.labels.ascension(),
          filter: (mats) => mats.ascension,
          value: ascension,
          values: (min: 1, max: 6),
          setValue: (value) => ascension = value,
        ),
        _materialsBox(
          label: context.labels.total(),
          filter: (mats) => mats.total,
        ),
      ],
    );
  }

  Future<_MissMats> _missingMaterials({
    int maxAscension = 6,
    int maxTalent = 10,
  }) {
    _MissMats callback((GuMaterials, List<CharInfo>) data) {
      final (utils, characters) = data;

      final tal = utils.getCharTalentsMissing;
      final asc = utils.getCharAscensionMissing;

      final tals = characters
          .map((info) => (info, tal(info.item, info.info, maxTalent)))
          .toList();
      final ascs = characters
          .map((info) => (info, asc(info.item, info.info, maxAscension)))
          .toList();

      final total = [...tals, ...ascs].groupBy((e) => e.$1.item.id).values.map((
        entry,
      ) {
        final item = entry.first.$1;
        final mats = entry
            .expand((e) => e.$2.entries)
            .groupBy((e) => e.key.id)
            .values
            .map((e) => MapEntry(e.first.key, e.sumBy((n) => n.value)))
            .toMap();

        return (item, mats);
      }).toList();

      return (total: total, talents: tals, ascension: ascs);
    }

    final list = widget.characters.toList();
    return compute(callback, (GsUtils.materials, list));
  }

  Widget _materialsBox({
    required String label,
    required List<_CharMats> Function(_MissMats mats) filter,
    int? value,
    ({int min, int max})? values,
    void Function(int value)? setValue,
  }) {
    return Expanded(
      child: Column(
        spacing: GsSpacing.kGridSeparator,
        children: [
          Expanded(
            child: InventoryBox(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(kSeparator8),
                    child: Text(label, style: context.themeStyles.label14b),
                  ),
                  GsDivider(),
                  SizedBox(height: kSeparator8),
                  Expanded(
                    child: FutureBuilder(
                      key: ValueKey(future),
                      future: future,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeCap: StrokeCap.round,
                            ),
                          );
                        }

                        final data = snapshot.data!;
                        final list = filter(data).where((e) => e.$2.isNotEmpty);
                        if (list.isEmpty) {
                          return GsNoResultsState.small();
                        }

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(kSeparator8),
                                child: Text(
                                  context.labels.characters(),
                                  style: context.themeStyles.label14n,
                                ),
                              ),
                              _characters(list),
                              GsDivider(),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(kSeparator8),
                                child: Text(
                                  context.labels.materials(),
                                  style: context.themeStyles.label14n,
                                ),
                              ),
                              _materials(list),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (value != null && values != null && setValue != null)
            _sliderBox(
              label: context.labels.max(),
              min: values.min,
              max: values.max,
              value: value,
              setValue: setValue,
            ),
        ],
      ),
    );
  }

  Widget _characters(Iterable<_CharMats> list) {
    return Wrap(
      spacing: kSeparator4,
      runSpacing: kSeparator4,
      children: list
          .sortedBy((e) => e.$1.talentsTotalCrownless)
          .thenBy((e) => e.$1.item.rarity)
          .map((e) {
            const kTal = GeMaterialType.talentMaterials;
            final mat = e.$2.keys.firstOrNullWhere((e) => e.group == kTal);
            final enable = (mat?.isFarmableToday ?? false) && e.$1.isOwned;
            return ItemGridWidget.character(
              e.$1.item,
              disabled: !enable,
              labelWidget: CharaterTalentsLabel(
                e.$1,
                style: context.themeStyles.label12n,
              ),
              tooltip: '',
            );
          })
          .toList(),
    );
  }

  Widget _materials(Iterable<_CharMats> list) {
    return Wrap(
      spacing: kSeparator4,
      runSpacing: kSeparator4,
      children: list
          .expand((e) => e.$2.entries)
          .groupBy((e) => e.key.id)
          .values
          .where((e) => e.firstOrNull != null)
          .map((e) => (e.first.key, e.sumBy((e) => e.value)))
          .sortedBy((e) => e.$1.group.index)
          .thenBy((e) => e.$1.subgroup)
          .thenBy((e) => e.$1.region.index)
          .map((e) {
            return ItemGridWidget.material(
              e.$1,
              disabled: !e.$1.isFarmableToday,
              label: e.$2.compact(),
              tooltip: '',
            );
          })
          .toList(),
    );
  }

  Widget _sliderBox({
    required String label,
    required int value,
    required int min,
    required int max,
    required void Function(int) setValue,
  }) {
    return InventoryBox(
      padding: EdgeInsets.all(kSeparator16),
      child: Row(
        spacing: kSeparator16,
        children: [
          Text(label, style: context.themeStyles.label14b),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                thumbColor: context.themeColors.primary,
                activeTickMarkColor: context.themeColors.primary80,
                inactiveTickMarkColor: context.themeColors.mainColor1,
                activeTrackColor: context.themeColors.primary60,
                inactiveTrackColor: context.themeColors.mainColor0,
                overlayColor: Colors.white.withValues(alpha: 0.1),
                valueIndicatorColor: context.themeColors.almostWhite,
                valueIndicatorTextStyle: context.themeStyles.label12b.copyWith(
                  color: Colors.black,
                ),
                allowedInteraction: SliderInteraction.tapAndSlide,
              ),
              child: Slider(
                value: value.toDouble(),
                min: min.toDouble(),
                max: max.toDouble(),
                divisions: max - min,
                label: value.toString(),
                padding: EdgeInsets.symmetric(horizontal: kSeparator8),
                onChanged: (i) => setState(() {
                  setValue(i.toInt());
                }),
                onChangeEnd: (value) {
                  setState(() {
                    future = _missingMaterials(
                      maxAscension: ascension,
                      maxTalent: talent,
                    );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef _CharMats = (CharInfo, Map<GsMaterial, int>);
typedef _MissMats = ({
  List<_CharMats> total,
  List<_CharMats> talents,
  List<_CharMats> ascension,
});
