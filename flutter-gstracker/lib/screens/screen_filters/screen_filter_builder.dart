import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
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
    final filter = ScreenFilters._of<T>() ?? ScreenFilter(sections: []);
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

enum FilterExtras { hide, versionSort }

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
    if (queryMatcher != null) {
      return list.where((e) {
        final item = selector(e);
        return queryMatcher!(item).toLowerCase().contains(_query) &&
            sections.every((s) => s._filter(item));
      });
    } else {
      return list.where((e) => sections.every((s) => s._filter(selector(e))));
    }
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

  static ScreenFilter<T>? _of<T extends GsModel<T>>() {
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
              (item) => !GsUtils.achievements.isObtainable(item.id),
              (c) => c.labels.status(),
              (c, e) =>
                  e ? c.labels.filterObtained() : c.labels.filterNotObtained(),
              key: FilterKey.obtain,
            ),
            FilterSection<GeAchievementType, GsAchievement>(
              GeAchievementType.values.toSet(),
              (item) => item.type,
              (c) => c.labels.type(),
              (c, e) => e.label(c),
            ),
            FilterSection.state(
              (item) => item.hidden,
              (c) => c.labels.achHidden(),
              (c, e) => e ? c.labels.achHidden() : c.labels.achVisible(),
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
            FilterSection.rarity((item) => item.rarity),
            FilterSection<GeRecipeEffectType, GsRecipe>(
              GeRecipeEffectType.values.toSet(),
              (item) => item.effect,
              (c) => c.labels.status(),
              (c, i) => i.label(c),
              asset: (i) => i.assetPath,
            ),
            FilterSection.version((item) => item.version),
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
            FilterSection.owned((item) => GsUtils.weapons.hasWeapon(item.id)),
            FilterSection.weaponType((item) => item.type),
            FilterSection.rarity((item) => item.rarity),
            FilterSection.version((item) => item.version),
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
            FilterSection.owned((e) => GsUtils.characters.hasCaracter(e.id)),
            FilterSection.state(
              (item) => GsUtils.characters.isCharMaxAscended(item.id),
              (c) => c.labels.ascension(),
              (c, i) =>
                  i ? c.labels.filterComplete() : c.labels.filterIncomplete(),
              filter: (i) => GsUtils.characters.hasCaracter(i.id),
            ),
            FilterSection.state(
              (item) => GsUtils.characters.getCharFriendship(item.id) == 10,
              (c) => c.labels.friendship(),
              (c, i) =>
                  i ? c.labels.filterComplete() : c.labels.filterIncomplete(),
              filter: (i) => GsUtils.characters.hasCaracter(i.id),
            ),
            FilterSection.rarity((item) => item.rarity, 4),
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
  static Future<T?> show<T>(BuildContext context, ScreenFilter filter) {
    return showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, _) => _GsFilterDialog(filter),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final dx = Curves.easeOut.transform(animation.value);
        return FractionalTranslation(
          translation: Offset(1 - dx, 0),
          child: child,
        );
      },
    );
  }

  final ScreenFilter filter;
  const _GsFilterDialog(this.filter);

  @override
  State<_GsFilterDialog> createState() => _GsFilterDialogState();
}

class _GsFilterDialogState extends State<_GsFilterDialog> {
  final _changeNotifier = ValueNotifier(false);
  final _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _queryController.text = widget.filter.query;
  }

  @override
  void dispose() {
    _queryController.dispose();
    _changeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: 360,
          margin: EdgeInsets.only(right: 60),
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.themeColors.mainColor0,
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(4, 10),
                color: Colors.black,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InventoryBox(
                margin: kListPadding.copyWith(bottom: 0),
                padding: EdgeInsets.all(kSeparator8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.labels.hintSearch(),
                            style: context.themeStyles.label16n
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.restart_alt_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            widget.filter.reset();
                            _changeNotifier.value = !_changeNotifier.value;
                            Navigator.of(context).maybePop();
                          },
                        ),
                      ],
                    ),
                    if (widget.filter.hasQuery())
                      const SizedBox(height: kGridSeparator * 2),
                    if (widget.filter.hasQuery())
                      TextField(
                        controller: _queryController,
                        style: context.themeStyles.label14n,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          focusColor: context.themeColors.mainColor1,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: kSeparator8,
                            horizontal: kSeparator16,
                          ),
                          border: _getInputBorder(context),
                          enabledBorder: _getInputBorder(context),
                          focusedBorder: _getInputBorder(context, true),
                          hintText: context.labels.hintSearch(),
                          hintStyle: context.themeStyles.label14n.copyWith(
                            color: context.themeColors.almostWhite
                                .withValues(alpha: kDisableOpacity),
                          ),
                        ),
                        onChanged: (value) {
                          widget.filter.query = value;
                          _changeNotifier.value = !_changeNotifier.value;
                        },
                        onSubmitted: (value) {
                          widget.filter.query = value;
                          _changeNotifier.value = !_changeNotifier.value;
                          Navigator.of(context).maybePop();
                        },
                      ),
                  ],
                ),
              ),
              Expanded(
                child: InventoryBox(
                  margin: kListPadding,
                  padding: EdgeInsets.all(kSeparator8),
                  child: ValueListenableBuilder(
                    valueListenable: _changeNotifier,
                    builder: (context, value, child) {
                      return ListView(
                        children: widget.filter.sections
                            .map((section) => _layoutSection(section))
                            .spaced(kSeparator16)
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _layoutSection(FilterSection section) {
    Widget expandedButton(Object? value) {
      if (value == null) return Spacer();
      return Expanded(
        child: _filterButton(
          selected: section.enabled.contains(value),
          label: section.label(context, value),
          onTap: () {
            section.toggle(value);
            _changeNotifier.value = !_changeNotifier.value;
          },
        ),
      );
    }

    final buttons = Column(
      children: section.values
          .chunked(2)
          .map((e) {
            return Row(
              children: [
                expandedButton(e.elementAtOrNull(0)),
                SizedBox(width: kListSeparator),
                expandedButton(e.elementAtOrNull(1)),
              ],
            );
          })
          .spaced(kListSeparator)
          .toList(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.title(context),
          style: context.themeStyles.label16n
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: kGridSeparator * 2),
        buttons,
      ],
    );
  }

  Widget _filterButton<T>({
    required bool selected,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(minHeight: 26),
          padding: EdgeInsets.symmetric(
            vertical: kSeparator4,
            horizontal: kSeparator8,
          ),
          margin: selected ? null : EdgeInsets.all(1),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected
                  ? context.themeColors.almostWhite
                  : context.themeColors.divider,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_on_rounded
                    : Icons.radio_button_off_rounded,
                size: 16,
              ),
              SizedBox(width: kGridSeparator * 2),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(label),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputBorder _getInputBorder(BuildContext context, [bool selected = false]) {
    final color = context.themeColors.almostWhite;
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: selected ? color : color.withValues(alpha: kDisableOpacity),
        width: selected ? 2 : 1,
      ),
      borderRadius: BorderRadius.circular(100),
    );
  }
}
