import 'package:dartx/dartx.dart';
import 'package:data_editor/configs.dart';
import 'package:data_editor/db/database.dart';
import 'package:data_editor/style/style.dart';
import 'package:data_editor/widgets/gs_grid_item.dart';
import 'package:data_editor/widgets/gs_selector/gs_selector.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final ValueNotifier<bool> _invalid;
  late final ValueNotifier<String> _notifier;

  @override
  void initState() {
    super.initState();
    _invalid = ValueNotifier(true);
    _notifier = ValueNotifier('');
  }

  @override
  void dispose() {
    _invalid.dispose();
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Screen'),
        actions: [
          IconButton(
            onPressed: () => _invalid.value = !_invalid.value,
            icon: const Icon(Icons.swap_horiz_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: GsStyle.kMainDecoration,
        child: StreamBuilder(
          stream: Database.i.modified,
          builder: (context, snapshot) {
            return ValueListenableBuilder(
              valueListenable: _invalid,
              builder: (context, value, child) {
                if (value) {
                  return _getInvalidList();
                }
                return _getInfoList();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _getInvalidList() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: _validateList(context).expand((record) {
        final color0 = GsStyle.getVersionColor(record.version);
        final color1 = Color.lerp(color0, Colors.black, 0.6)!;
        return [
          Container(
            height: 44,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color0, color1],
                stops: const [0, 0.25],
              ),
              border: Border.all(width: 2, color: color1),
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 8),
            child: Text('Version ${record.version}'),
          ),
          ...record.items.map((record) {
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.only(bottom: 4),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0x66FFFFFF))),
              ),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(record.label)),
                  const SizedBox(width: 8),
                  Flexible(
                    flex: 6,
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: record.items.toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 24),
        ];
      }).toList(),
    );
  }

  Widget _getInfoList() {
    Widget getChild(GsVersion version) {
      final vColor = GsStyle.getVersionColor(version.id);
      final color1 = Color.lerp(vColor, Colors.black, 0.6)!;
      return Column(
        spacing: 4,
        children: [
          Container(
            height: 32,
            width: double.infinity,
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [vColor, color1],
                stops: const [0, 0.25],
              ),
              border: Border.all(width: 2, color: color1),
            ),
            child: Text(version.id, textAlign: TextAlign.center),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: GsConfigs.getAllConfigs()
                .where((e) => e.collection.parser({}) is GsVersionable)
                .map((config) {
                  final amount = config.collection.items
                      .cast<GsVersionable>()
                      .count((e) => e.version == version.id);
                  final color = amount < 1
                      ? Colors.deepOrange
                      : Colors.lightGreen;
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: GsGridItem(
                      color: color,
                      label: config.title,
                      onTap: () =>
                          config.openListScreen(context, version: version.id),
                      child: GsOrderOrb(amount.toString()),
                    ),
                  );
                })
                .toList(),
          ),
          SizedBox(height: 8),
        ],
      );
    }

    return ValueListenableBuilder(
      valueListenable: _notifier,
      builder: (context, value, child) {
        return ListView(
          padding: const EdgeInsets.all(8).copyWith(bottom: 0),
          children: Database.i
              .of<GsVersion>()
              .items
              .sortedByDescending((e) => e.releaseDate)
              .map(getChild)
              .toList(),
        );
      },
    );
  }
}

typedef _InvalidLine = ({Iterable<GsSelectChip> items, String label});
typedef _VersionLine = ({String version, List<_InvalidLine> items});

Iterable<_VersionLine> _validateList(BuildContext context) sync* {
  Iterable<T> items<T extends GsModel<T>>() => Database.i.of<T>().items;

  GsVersion? next;
  final versions = items<GsVersion>().sortedDescending();
  for (final version in versions) {
    final buffer = <_InvalidLine>[];

    void addItems<T extends GsModel<T>>(
      String label, [
      Iterable<T?> values = const [],
    ]) {
      if (T == GsVersion) {
        return buffer.add((items: [], label: label));
      }

      final config = GsConfigs.of<T>();
      final items = values.map((value) {
        final decor = value != null ? config?.itemDecoration(value) : null;
        final color = GsStyle.getRarityColor(decor?.rarity ?? 1);

        return GsSelectChip(
          GsSelectItem(value, decor?.label ?? T.toString(), color: color),
          onTap: (item) => config?.openEditScreen(context, item),
        );
      }).toList();
      buffer.add((items: items, label: label));
    }

    final battlepass = items<GsBattlepass>().firstOrNullWhere(
      (e) => e.version == version.id,
    );
    if (battlepass == null) {
      addItems<GsBattlepass>('Missing battlepass!', [null]);
    }

    final materials = items<GsMaterial>().where((e) => e.version == version.id);
    final matRegion = <GsMaterial>[];
    final matWeekdays = <GsMaterial>[];
    for (final mat in materials) {
      if (!mat.hasValidWeekdays) {
        matWeekdays.add(mat);
      } else if (!mat.hasValidRegion) {
        matRegion.add(mat);
      }
    }
    if (matWeekdays.isNotEmpty) {
      addItems<GsMaterial>('Missing weekdays:', matWeekdays);
    }
    if (matRegion.isNotEmpty) {
      addItems<GsMaterial>('Missing region:', matRegion);
    }

    const minEvents = 5;
    final events = items<GsEvent>().count((e) => e.version == version.id);
    if (events < minEvents) {
      final missing = minEvents - events;
      addItems<GsEvent>('Missing $missing events!', [null]);
    }

    final banners = items<GsBanner>().where((e) => e.version == version.id);
    final weapons = items<GsWeapon>().where((e) => e.version == version.id);
    final chars = items<GsCharacter>().where((e) => e.version == version.id);
    final weaponWrongSource = weapons.where((e) => !e.hasValidSource);
    if (weaponWrongSource.isNotEmpty) {
      addItems<GsWeapon>('Wrong source:', weaponWrongSource);
    }

    final charWrongSource = chars.where((e) => !e.hasValidSource);
    if (charWrongSource.isNotEmpty) {
      addItems<GsCharacter>('Wrong source:', charWrongSource);
    }

    // We ignore weapon of rarity 1 and 2.
    final effectReg = RegExp(r'\{(.+,)*.+\}');
    final noEffect = weapons.where((e) => e.effectName.isEmpty && e.rarity > 2);
    final noEffectValues = weapons.where(
      (e) => e.effectName.isNotEmpty && !effectReg.hasMatch(e.effectDesc),
    );
    if (noEffect.isNotEmpty) {
      addItems<GsWeapon>('No Effect for:', noEffect);
    }
    if (noEffectValues.isNotEmpty) {
      addItems<GsWeapon>('No Effect Values for:', noEffectValues);
    }

    // Ignore version 1.0
    final charMissingBanner = chars.where(
      (e) =>
          e.version != '1.0' &&
          e.isWishable &&
          !banners.any((b) => b.containsCharacter(e)),
    );
    if (charMissingBanner.isNotEmpty) {
      addItems<GsCharacter>('Missing banner:', charMissingBanner);
    }

    final lists = banners
        .where((e) => e.type == GeBannerType.character)
        .groupBy((e) => e.dateStart)
        .values
        .where((e) => e.distinctBy((b) => b.subtype).length == 1)
        .where((e) => e.length != 1);

    for (final list in lists) {
      addItems<GsBanner>(
        '${list.length} as character type for the same date!',
        list,
      );
    }

    final charWrongReleaseDate = chars.where(
      (char) =>
          char.releaseDate.isBefore(version.releaseDate) ||
          next != null && char.releaseDate.isAfter(next.releaseDate),
    );
    if (charWrongReleaseDate.isNotEmpty) {
      addItems<GsCharacter>(
        'Wrong version or release date',
        charWrongReleaseDate,
      );
    }

    final sets = items<GsSereniteaSet>();
    final charMissingGift = chars.where(
      (e) => sets.count((s) => s.chars.contains(e.id)) != 2,
    );
    if (charMissingGift.isNotEmpty) {
      addItems<GsCharacter>('Missing Serenitea Gift', charMissingGift);
    }

    final recipes = items<GsRecipe>();
    final versionRecipes = recipes.where((e) => e.version == version.id);
    final charRecipes = versionRecipes.where((e) => e.baseRecipe.isNotEmpty);

    final isNotPermanent = charRecipes.where(
      (e) => e.type != GeRecipeType.permanent,
    );
    if (isNotPermanent.isNotEmpty) {
      addItems('Recipes are not permanent:', isNotPermanent);
    }
    final notSameEffect = charRecipes.where(
      (e) =>
          e.effect !=
          recipes.firstOrNullWhere((r) => r.id == e.baseRecipe)?.effect,
    );
    if (notSameEffect.isNotEmpty) {
      addItems('Recipes dont have same effect:', notSameEffect);
    }

    next = version;
    if (buffer.isNotEmpty) {
      yield (version: version.version, items: buffer);
    }
  }
}

extension on GsMaterial {
  bool get hasValidWeekdays {
    if (group == GeMaterialType.talentMaterials ||
        group == GeMaterialType.weaponMaterials) {
      if (weekdays.length != 3) return false;
      late final mon = weekdays.containsAll([
        GeWeekdayType.sunday,
        GeWeekdayType.monday,
        GeWeekdayType.thursday,
      ]);
      late final tue = weekdays.containsAll([
        GeWeekdayType.sunday,
        GeWeekdayType.tuesday,
        GeWeekdayType.friday,
      ]);
      late final wed = weekdays.containsAll([
        GeWeekdayType.sunday,
        GeWeekdayType.wednesday,
        GeWeekdayType.saturday,
      ]);
      return mon || tue || wed;
    }

    /// If does not require weekdays mark it as valid
    return true;
  }

  bool get hasValidRegion {
    return group != GeMaterialType.regionMaterials ||
        region != GeRegionType.none;
  }
}

extension on GsCharacter {
  bool get isWishable =>
      source == GeItemSourceType.wishesStandard ||
      source == GeItemSourceType.wishesCharacterBanner;

  bool get hasValidSource {
    const valid = [
      GeItemSourceType.event,
      GeItemSourceType.wishesStandard,
      GeItemSourceType.wishesCharacterBanner,
    ];
    return valid.contains(source);
  }
}

extension on GsWeapon {
  bool get hasValidSource {
    if (rarity != 5) {
      return source != GeItemSourceType.wishesCharacterBanner &&
          source != GeItemSourceType.none;
    }
    return source == GeItemSourceType.wishesWeaponBanner ||
        source == GeItemSourceType.wishesStandard;
  }
}

extension on GsBanner {
  bool containsCharacter(GsCharacter char) {
    if (type != GeBannerType.character) return false;
    if (char.rarity == 4) return feature4.contains(char.id);
    if (char.rarity == 5) return feature5.contains(char.id);
    return false;
  }
}
