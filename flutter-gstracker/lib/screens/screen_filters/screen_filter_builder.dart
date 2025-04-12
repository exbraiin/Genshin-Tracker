import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/button.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';

typedef FilterBuilder<T extends GsModel<T>> = Widget Function(
  BuildContext context,
  ScreenFilter<T> filter,
  Widget button,
  void Function(FilterExtras extra) toggle,
);

class ScreenFilterBuilder<T extends GsModel<T>> extends StatelessWidget {
  final notifier = ValueNotifier(false);
  final FilterBuilder<T> builder;

  ScreenFilterBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final filter = ScreenFilters.of<T>()!;
    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, value, child) {
        final button = IconButton(
          onPressed: () => _GsFilterDialog.show(context, filter)
              .then((value) => notifier.value = !notifier.value),
          icon: const Icon(Icons.filter_alt_rounded),
        );
        return builder(context, filter, button, (v) {
          filter.toggleExtra(v);
          notifier.value = !notifier.value;
        });
      },
    );
  }
}

enum FilterKey { none, weekdays, obtain }

enum FilterExtras { info, table, hide, versionSort }

class FilterSection<T, I> {
  final FilterKey key;
  final Set<T> values;
  final Set<T> enabled;
  final bool singleValue;
  final bool Function(I item)? filter;
  final IconData? Function(T i)? _icon;
  final String? Function(T i)? _asset;
  final String Function(BuildContext c) title;
  final String Function(BuildContext c, T i) _label;
  final bool Function(I item, Set<T> enabled) match;

  FilterSection(
    this.values,
    T Function(I item) match,
    this.title,
    this._label, {
    this.key = FilterKey.none,
    this.filter,
    this.singleValue = false,
    String? Function(T i)? asset,
    IconData? Function(T i)? icon,
  })  : enabled = {},
        _icon = icon,
        _asset = asset,
        match = ((item, enabled) => enabled.contains(match(item)));

  FilterSection.raw(
    this.values,
    this.match,
    this.title,
    this._label, {
    this.key = FilterKey.none,
    this.filter,
    this.singleValue = false,
    String? Function(T i)? asset,
    IconData? Function(T i)? icon,
  })  : enabled = {},
        _icon = icon,
        _asset = asset;

  static FilterSection<String, I> version<I>(String Function(I item) match) {
    String toMajorVersion(String version) => '${version.split('.').first}.x';
    return FilterSection(
      Database.instance
          .infoOf<GsVersion>()
          .items
          .map((e) => toMajorVersion(e.id))
          .toSet(),
      (item) => toMajorVersion(match(item)),
      (c) => c.labels.version(),
      (c, i) => i,
    );
  }

  static FilterSection<int, I> rarity<I>(
    int Function(I item) match, [
    int min = 1,
  ]) {
    return FilterSection(
      Iterable.generate(6 - min, (idx) => idx + min).toSet(),
      match,
      (c) => c.labels.rarity(),
      (c, i) => c.labels.rarityStar(i),
    );
  }

  static FilterSection<GeRegionType, I> region<I>(
    GeRegionType Function(I item) match,
  ) {
    return FilterSection(
      GeRegionType.values.toSet(),
      match,
      (c) => c.labels.region(),
      (c, i) => i.label(c),
    );
  }

  static FilterSection<GeWeaponType, I> weaponType<I>(
    GeWeaponType Function(I item) match,
  ) {
    return FilterSection(
      GeWeaponType.values.toSet(),
      match,
      (c) => c.labels.weapon(),
      (c, e) => e.label(c),
      asset: (e) => e.assetPath,
    );
  }

  static FilterSection<GeElementType, I> element<I>(
    GeElementType Function(I item) match,
  ) {
    return FilterSection(
      GeElementType.values.toSet(),
      match,
      (c) => c.labels.element(),
      (c, i) => i.label(c),
      asset: (i) => i.assetPath,
    );
  }

  static FilterSection<bool, I> itemType<I>(bool Function(I item) match) {
    return FilterSection.state(
      match,
      (c) => c.labels.type(),
      (c, i) => i ? c.labels.weapon() : c.labels.character(),
    );
  }

  static FilterSection<bool, I> owned<I>(
    bool Function(I item) match, {
    bool Function(I item)? filter,
    FilterKey key = FilterKey.none,
  }) {
    return FilterSection.state(
      match,
      (c) => c.labels.status(),
      (c, i) => i ? c.labels.filterObtained() : c.labels.filterNotObtained(),
      filter: filter,
      key: key,
    );
  }

  static FilterSection<bool, I> state<I>(
    bool Function(I item) match,
    String Function(BuildContext c) title,
    String Function(BuildContext c, bool i) label, {
    bool Function(I item)? filter,
    FilterKey key = FilterKey.none,
  }) {
    return FilterSection(
      const {true, false},
      match,
      title,
      label,
      key: key,
      filter: filter,
      singleValue: true,
    );
  }

  static FilterSection<GeWeekdayType, I> weekdaysMaterials<I>(
    Set<String> Function(I item) materialIds,
  ) {
    const sunday = GeWeekdayType.sunday;
    final weekdays = GeWeekdayType.values.exceptElement(sunday).toSet();
    return FilterSection<GeWeekdayType, I>.raw(
      weekdays,
      (item, enabled) {
        final t = Database.instance.infoOf<GsMaterial>().items;
        final eMats = t.where((e) => e.weekdays.intersect(enabled).isNotEmpty);
        final iMats = materialIds(item);
        return eMats.any((e) => iMats.contains(e.id));
      },
      (c) => c.labels.materials(),
      (c, i) => i == GeWeekdayType.values.today
          ? '✦ ${i.getLabel(c)}'
          : i.getLabel(c),
      key: FilterKey.weekdays,
    );
  }

  static FilterSection<GeSereniteaSetType, I> setCategory<I>(
    GeSereniteaSetType Function(I item) match,
  ) {
    return FilterSection(
      GeSereniteaSetType.values.exceptElement(GeSereniteaSetType.none).toSet(),
      match,
      (c) => c.labels.category(),
      (c, i) => i.label(c),
      singleValue: true,
    );
  }

  IconData? icon(T i) => _icon?.call(i);
  String? asset(T i) => _asset?.call(i);
  String label(BuildContext c, T i) => _label(c, i);

  bool _filter(I e) {
    if (enabled.isEmpty) return true;
    return (filter?.call(e) ?? true) && match.call(e, enabled);
  }

  void toggle(T v) {
    if (singleValue) {
      final contained = enabled.contains(v);
      enabled.clear();
      if (!contained) enabled.add(v);
      return;
    }

    enabled.contains(v) ? enabled.remove(v) : enabled.add(v);
  }
}

class ScreenFilter<I extends GsModel<I>> {
  var _query = '';
  final _extras = <FilterExtras>{};
  final List<FilterSection<dynamic, I>> sections;
  final String Function(I item)? queryMatcher;

  String get query => _query;
  set query(String value) => _query = value.toLowerCase();

  ScreenFilter({required this.sections, this.queryMatcher});

  Iterable<I> match(Iterable<I> list) {
    return matchBy(list, (e) => e);
  }

  Iterable<T> matchBy<T>(Iterable<T> list, I Function(T) selector) {
    bool matchQuery(I item) =>
        queryMatcher?.call(item).toLowerCase().contains(_query) ?? false;

    return list.where((e) {
      final item = selector(e);
      if (!matchQuery(item)) return false;
      return sections.every((s) => s._filter(item));
    });
  }

  void reset() {
    _query = '';
    for (final section in sections) {
      section.enabled.clear();
    }
  }

  bool hasQuery() {
    return queryMatcher != null;
  }

  bool hasExtra(FilterExtras key) {
    return _extras.contains(key);
  }

  FilterSection<K, I>? getFilterSectionByKey<K>(FilterKey key) =>
      sections.firstOrNullWhere((e) => e.key == key) as FilterSection<K, I>?;

  void toggleExtra(FilterExtras key) =>
      _extras.contains(key) ? _extras.remove(key) : _extras.add(key);

  bool isSectionEmpty(FilterKey key) =>
      sections.firstOrNullWhere((e) => e.key == key)?.enabled.isEmpty ?? true;
}

class ScreenFilters {
  static final _db = Database.instance;
  static final _getItem = GsUtils.items.getItemData;
  static final _filters = <Type, ScreenFilter?>{};

  static ScreenFilter<T>? of<T extends GsModel<T>>() {
    late final filter = switch (T) {
      const (GsWish) => ScreenFilter<GsWish>(
          sections: [
            FilterSection.itemType((item) => item.isWeapon),
            FilterSection.rarity((item) => item.rarity, 3),
          ],
        ),
      const (GiWish) => ScreenFilter<GiWish>(
          sections: [
            FilterSection.itemType((item) => _getItem(item.itemId).isWeapon),
            FilterSection.rarity((item) => _getItem(item.itemId).rarity, 3),
          ],
        ),
      const (GsAchievement) => ScreenFilter<GsAchievement>(
          sections: [
            FilterSection.state(
              (item) => item.hidden,
              (c) => c.labels.achHidden(),
              (c, e) => e ? c.labels.achHidden() : c.labels.achVisible(),
            ),
            FilterSection<GeAchievementType, GsAchievement>(
              GeAchievementType.values.toSet(),
              (item) => item.type,
              (c) => c.labels.type(),
              (c, e) => e.label(c),
            ),
            FilterSection.state(
              (item) => !GsUtils.achievements.isObtainable(item.id),
              (c) => c.labels.status(),
              (c, e) =>
                  e ? c.labels.filterObtained() : c.labels.filterNotObtained(),
              key: FilterKey.obtain,
            ),
            FilterSection.version((item) => item.version),
          ],
        ),
      const (GsEvent) => ScreenFilter<GsEvent>(
          sections: [
            FilterSection.version((item) => item.version),
            FilterSection<GeEventType, GsEvent>(
              GeEventType.values.toSet(),
              (item) => item.type,
              (c) => c.labels.type(),
              (c, i) => i.label(c),
            ),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsNamecard) => ScreenFilter<GsNamecard>(
          sections: [
            FilterSection<GeNamecardType, GsNamecard>(
              GeNamecardType.values.toSet(),
              (item) => item.type,
              (c) => c.labels.type(),
              (c, e) => e.label(c),
            ),
            FilterSection.version((item) => item.version),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsRecipe) => ScreenFilter<GsRecipe>(
          sections: [
            FilterSection.rarity((item) => item.rarity),
            FilterSection<GeRecipeEffectType, GsRecipe>(
              GeRecipeEffectType.values.toSet(),
              (item) => item.effect,
              (c) => c.labels.status(),
              (c, i) => i.label(c),
              asset: (i) => i.assetPath,
            ),
            FilterSection.version((item) => item.version),
            FilterSection.owned(
              (item) => _db.saveOf<GiRecipe>().exists(item.id),
              filter: (item) => item.baseRecipe.isEmpty,
              key: FilterKey.obtain,
            ),
            FilterSection.state(
              (item) =>
                  _db.saveOf<GiRecipe>().getItem(item.id)?.proficiency ==
                  item.maxProficiency,
              (c) => c.labels.filterProficiency(),
              (c, e) =>
                  e ? c.labels.filterComplete() : c.labels.filterIncomplete(),
              filter: (i) => _db.saveOf<GiRecipe>().exists(i.id),
            ),
            FilterSection.state(
              (item) => item.baseRecipe.isNotEmpty,
              (c) => c.labels.specialDish(),
              (c, e) => e ? c.labels.specialDish() : c.labels.wsNone(),
            ),
            FilterSection<GeRecipeType, GsRecipe>(
              GeRecipeType.values.toSet(),
              (item) => item.type,
              (c) => c.labels.type(),
              (c, i) => i.label(c),
            ),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsFurnitureChest) => ScreenFilter<GsFurnitureChest>(
          sections: [
            FilterSection.rarity((item) => item.rarity),
            FilterSection.version((item) => item.version),
            FilterSection.region((item) => item.region),
            FilterSection.setCategory((item) => item.type),
            FilterSection.owned(
              (item) => _db.saveOf<GiFurnitureChest>().exists(item.id),
            ),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsWeapon) => ScreenFilter<GsWeapon>(
          sections: [
            FilterSection.weaponType((item) => item.type),
            FilterSection.rarity((item) => item.rarity),
            FilterSection.version((item) => item.version),
            FilterSection.owned((item) => GsUtils.weapons.hasWeapon(item.id)),
            FilterSection.weekdaysMaterials(
              (item) => GsUtils.weaponMaterials
                  .getAscensionMaterials(item.id)
                  .keys
                  .toSet(),
            ),
            FilterSection<GeWeaponAscStatType, GsWeapon>(
              GeWeaponAscStatType.values.toSet(),
              (item) => item.statType,
              (c) => c.labels.ndStat(),
              (c, i) => i.label(c),
              asset: (e) => e.assetPath,
            ),
            FilterSection<GeItemSourceType, GsWeapon>(
              Database.instance
                  .infoOf<GsWeapon>()
                  .items
                  .map((e) => e.source)
                  .toSet(),
              (item) => item.source,
              (c) => c.labels.source(),
              (c, i) => i.name.capitalize(),
            ),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsArtifact) => ScreenFilter<GsArtifact>(
          sections: [
            FilterSection.rarity((item) => item.rarity, 3),
            FilterSection.version((item) => item.version),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsCharacter) => ScreenFilter<GsCharacter>(
          sections: [
            FilterSection.element((item) => item.element),
            FilterSection.weaponType((item) => item.weapon),
            FilterSection.weekdaysMaterials((item) {
              return GsUtils.characterMaterials
                  .getTalentMaterials(item.id)
                  .keys
                  .toSet();
            }),
            FilterSection.version((item) => item.version),
            FilterSection.region((item) => item.region),
            FilterSection<GeCharacterAscStatType, GsCharacter>(
              GeCharacterAscStatType.values.toSet(),
              (item) => item.ascStatType,
              (c) => 'Special Stat',
              (c, i) => i.label(c),
              asset: (i) => i.assetPath,
            ),
            FilterSection.state(
              (item) => GsUtils.characters.getCharFriendship(item.id) == 10,
              (c) => c.labels.friendship(),
              (c, i) =>
                  i ? c.labels.filterComplete() : c.labels.filterIncomplete(),
              filter: (i) => GsUtils.characters.hasCaracter(i.id),
            ),
            FilterSection.owned((e) => GsUtils.characters.hasCaracter(e.id)),
            FilterSection.state(
              (item) => GsUtils.characters.isCharMaxAscended(item.id),
              (c) => c.labels.ascension(),
              (c, i) =>
                  i ? c.labels.filterComplete() : c.labels.filterIncomplete(),
              filter: (i) => GsUtils.characters.hasCaracter(i.id),
            ),
            FilterSection.rarity((item) => item.rarity, 4),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsSereniteaSet) => ScreenFilter<GsSereniteaSet>(
          sections: [
            FilterSection.version((item) => item.version),
            FilterSection.setCategory((item) => item.category),
            FilterSection.state(
              (item) => !GsUtils.sereniteaSets.isObtainable(item.id),
              (c) => c.labels.status(),
              (c, e) =>
                  e ? c.labels.filterObtained() : c.labels.filterNotObtained(),
            ),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsSpincrystal) => ScreenFilter<GsSpincrystal>(
          sections: [
            FilterSection.owned(
              (item) => _db.saveOf<GiSpincrystal>().exists(item.id),
            ),
            FilterSection.version((item) => item.version),
            FilterSection.state(
              (item) => item.fromChubby,
              (c) => c.labels.source(),
              (c, i) => i ? c.labels.chubby() : c.labels.world(),
            ),
          ],
          queryMatcher: (item) => item.name,
        ),
      const (GsMaterial) => ScreenFilter<GsMaterial>(
          sections: [
            FilterSection.rarity((item) => item.rarity),
            FilterSection.version((item) => item.version),
            FilterSection(
              {true},
              (item) => item.ingredient,
              (c) => c.labels.ingredients(),
              (c, i) => c.labels.buttonYes(),
            ),
            FilterSection<GeMaterialType, GsMaterial>(
              GeMaterialType.values.toSet(),
              (item) => item.group,
              (c) => c.labels.category(),
              (c, i) => i.label(c),
            ),
          ],
          queryMatcher: (item) => item.name,
        ),
      _ => null,
    } as ScreenFilter<T>?;

    return (_filters[T] ??= filter) as ScreenFilter<T>?;
  }
}

class _GsFilterDialog extends StatefulWidget {
  static Future<void> show(BuildContext context, ScreenFilter filter) async {
    return showDialog(
      context: context,
      builder: (_) => _GsFilterDialog(filter),
    );
  }

  final ScreenFilter filter;

  const _GsFilterDialog(this.filter);

  @override
  State<_GsFilterDialog> createState() => _GsFilterDialogState();
}

class _GsFilterDialogState extends State<_GsFilterDialog> {
  final notifier = ValueNotifier(false);
  final _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _queryController.text = widget.filter.query;
  }

  @override
  void dispose() {
    _queryController.dispose();
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height / 4,
        horizontal: size.width / 4,
      ),
      padding: kListPadding,
      decoration: BoxDecoration(
        color: context.themeColors.mainColor0,
        borderRadius: kGridRadius,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 4),
            color: Colors.black,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            InventoryBox(
              child: Row(
                children: [
                  const SizedBox(width: kGridSeparator),
                  Expanded(
                    child: Text(
                      context.labels.filter(),
                      style: context.themeStyles.title18n,
                      strutStyle: context.themeStyles.title18n.toStrut(),
                    ),
                  ),
                  if (widget.filter.hasQuery())
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: _queryController,
                        style: context.themeStyles.label14n,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          focusColor: context.themeColors.mainColor1,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: kSeparator8,
                            horizontal: kSeparator8 + kSeparator4,
                          ),
                          border: _getInputBorder(),
                          enabledBorder: _getInputBorder(),
                          focusedBorder: _getInputBorder(true),
                          hintText: context.labels.hintSearch(),
                          hintStyle: context.themeStyles.label14n.copyWith(
                            color: context.themeColors.almostWhite
                                .withValues(alpha: kDisableOpacity),
                          ),
                        ),
                        onChanged: (value) {
                          widget.filter.query = value;
                          notifier.value = !notifier.value;
                        },
                        onSubmitted: (value) {
                          widget.filter.query = value;
                          notifier.value = !notifier.value;
                          Navigator.of(context).maybePop();
                        },
                      ),
                    ),
                  IconButton(
                    icon: const Icon(
                      Icons.restart_alt_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      widget.filter.reset();
                      notifier.value = !notifier.value;
                      Navigator.of(context).maybePop();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: kGridSeparator),
            Expanded(
              child: InventoryBox(
                padding: const EdgeInsets.all(kGridSeparator * 2),
                child: ValueListenableBuilder<bool>(
                  valueListenable: notifier,
                  builder: (context, value, child) {
                    final half = widget.filter.sections.length ~/ 2;
                    return SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.filter.sections
                                  .take(half)
                                  .map(_filter)
                                  .separate(const SizedBox(height: 12))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(width: kSeparator8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.filter.sections
                                  .skip(half)
                                  .map(_filter)
                                  .separate(const SizedBox(height: 12))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputBorder _getInputBorder([bool selected = false]) {
    final color = context.themeColors.almostWhite;
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: selected ? color : color.withValues(alpha: kDisableOpacity),
        width: selected ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(100),
    );
  }

  Widget _filter(FilterSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title(context),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: kGridSeparator * 2),
        Wrap(
          spacing: kGridSeparator,
          runSpacing: kGridSeparator,
          children: section.values.map((v) {
            return MainButton(
              selected: section.enabled.contains(v),
              child: Text(section.label(context, v)),
              onPress: () {
                section.toggle(v);
                notifier.value = !notifier.value;
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
