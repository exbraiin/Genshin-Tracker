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
import 'package:tracker/screens/characters_screen/character_widgets.dart';
import 'package:tracker/screens/characters_screen/utils_sort_characters.dart';
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
  final _listType = ValueNotifier(false);

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
                actions: [
                  IconButton(
                    onPressed: () => _listType.value = !_listType.value,
                    icon: Icon(Icons.swap_horiz_rounded),
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  button,
                ],
              ),
              child: ValueListenableBuilder(
                valueListenable: _listType,
                builder: (context, value, child) {
                  if (!value) {
                    return _MatsByDays(sorted);
                  }
                  return _MatsList(list);
                },
              ),
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
    final today = GeWeekdayType.values.today;

    if (mapOfCharacters.values.every((e) => e.isEmpty)) {
      return InventoryBox(child: Center(child: GsNoResultsState.small()));
    }

    return Row(
      spacing: GsSpacing.kGridSeparator,
      children: mapOfCharacters.entries.map((entry) {
        final days = entry.key;
        final chars = entry.value;
        late final isToday =
            today == GeWeekdayType.sunday ||
            days.day1 == today ||
            days.day2 == today;

        return Expanded(
          child: InventoryBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(kSeparator8),
                  child: Text(
                    '${days.day1.getLabel(context).substring(0, 3)} & '
                    '${days.day2.getLabel(context).substring(0, 3)}',
                    style: context.themeStyles.label14b,
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
                            final info = chars[index];
                            final mats = GsUtils.materials
                                .getCharTalentsMissing(
                                  info.item,
                                  info.info,
                                  CharTalents.kCrownless,
                                );

                            return Row(
                              spacing: kSeparator8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ItemGridWidget.character(
                                  info.item,
                                  disabled: !isToday,
                                  labelWidget: CharaterTalentsLabel(info),
                                ),
                                SizedBox(
                                  height: kSize50,
                                  child: Center(
                                    child: Text(
                                      '\u2022',
                                      style: context.themeStyles.label14n,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Wrap(
                                    spacing: kSeparator4,
                                    runSpacing: kSeparator4,
                                    alignment: WrapAlignment.start,
                                    children: mats.entries.map((mat) {
                                      return ItemGridWidget.material(
                                        mat.key,
                                        disabled: !isToday,
                                        label: mat.value.compact(),
                                        tooltip: '',
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _MatsList extends StatefulWidget {
  final List<CharInfo> characters;

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

    return compute(callback, (GsUtils.materials, widget.characters));
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
