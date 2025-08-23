import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/achievements_screen/achievement_groups_screen.dart';
import 'package:tracker/screens/artifacts_screen/artifacts_screen.dart';
import 'package:tracker/screens/characters_screen/characters_screen.dart';
import 'package:tracker/screens/envisaged_echo_screen/envisaged_echo_screen.dart';
import 'package:tracker/screens/events_screen/event_screen.dart';
import 'package:tracker/screens/home_screen/home_screen.dart';
import 'package:tracker/screens/main_screen/save_toast.dart';
import 'package:tracker/screens/main_screen/tracker_router.dart';
import 'package:tracker/screens/materials_screen/materials_screen.dart';
import 'package:tracker/screens/namecard_screen/namecard_screen.dart';
import 'package:tracker/screens/recipes_screen/recipes_screen.dart';
import 'package:tracker/screens/remarkable_chests_screen/remarkable_chests_screen.dart';
import 'package:tracker/screens/serenitea_sets_screen/serenitea_sets_screen.dart';
import 'package:tracker/screens/spincrystals_screen/spincrystals_screen.dart';
import 'package:tracker/screens/thespian_tricks_screen/thespian_tricks_screen.dart';
import 'package:tracker/screens/version_screen/version_screen.dart';
import 'package:tracker/screens/weapons_screen/weapons_screen.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/screens/wishes_screen/wishes_screen.dart';
import 'package:tracker/theme/gs_assets.dart';

const _menuWidth = 80.0;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final ValueNotifier<int> _page;

  @override
  void initState() {
    super.initState();
    _page = ValueNotifier(0);
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.themeColors.mainColor0,
      child: Stack(
        children: [
          Positioned.fill(left: _menuWidth, child: _pageWidget()),
          Positioned.fill(right: null, child: _buttonsWidget()),
          Positioned(
            right: 0,
            bottom: 0,
            child: StreamBuilder<bool>(
              initialData: false,
              stream: Database.instance.saving.distinct(),
              builder: (context, snapshot) => Toast(show: snapshot.data!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonsWidget() {
    Widget button(int idx, _Menu menu) {
      final selected = idx == _page.value;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(kSeparator2),
        decoration: BoxDecoration(
          color:
              idx == 0
                  ? context.themeColors.primary
                  : context.themeColors.mainColor0,
          borderRadius: GsSpacing.kGridRadius,
          border: Border.all(
            color:
                selected
                    ? context.themeColors.almostWhite.withValues(alpha: 0.4)
                    : Colors.transparent,
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: () {
            if (_page.value == idx) {
              final key = _menus[idx].navigator.key as GlobalKey?;
              final ctx = key?.currentContext;
              if (ctx != null) Navigator.of(ctx).maybePop();
            }
            _page.value = idx;
          },
          child: Image.asset(menu.icon, height: 40, width: 40),
        ),
      );
    }

    return InventoryBox(
      width: _menuWidth - GsSpacing.kGridSeparator,
      margin: const EdgeInsets.all(GsSpacing.kGridSeparator),
      child: ValueListenableBuilder(
        valueListenable: _page,
        builder: (context, value, child) {
          return ListView(
            children:
                _menus
                    .mapIndexed(button)
                    .separate(const SizedBox(height: GsSpacing.kListSeparator))
                    .toList(),
          );
        },
      ),
    );
  }

  Widget _pageWidget() {
    return ValueStreamBuilder<bool>(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        if (!snapshot.data!) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1.6,
            ),
          );
        }

        return ValueListenableBuilder(
          valueListenable: _page,
          key: const ValueKey('main_page_selector'),
          builder: (context, index, child) {
            return AnimatedSwitcher(
              key: const ValueKey('switcher'),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: _menus[index].navigator,
            );
          },
        );
      },
    );
  }
}

final _menus = [
  _Menu(icon: AppAssets.appIcon40px, page: HomeScreen.id),
  _Menu(icon: AppAssets.menuIconWish, page: WishesScreen.id),
  _Menu(icon: AppAssets.menuIconAchievements, page: AchievementGroupsScreen.id),
  _Menu(icon: AppAssets.menuIconCharacters, page: CharactersScreen.id),
  _Menu(icon: AppAssets.menuIconWeapons, page: WeaponsScreen.id),
  _Menu(icon: AppAssets.menuIconRecipes, page: RecipesScreen.id),
  _Menu(icon: AppAssets.menuIconMap, page: RemarkableChestsScreen.id),
  _Menu(icon: AppAssets.menuEnvisagedEchoes, page: EnvisagedEchoScreen.id),
  _Menu(icon: AppAssets.menuIconThespianTricks, page: ThespianTricksScreen.id),
  _Menu(icon: AppAssets.menuIconPreciousItems, page: SpincrystalsScreen.id),
  _Menu(icon: AppAssets.menuIconSereniteaSets, page: SereniteaSetsScreen.id),
  _Menu(icon: AppAssets.menuIconArtifacts, page: ArtifactsScreen.id),
  _Menu(icon: AppAssets.menuIconArchive, page: NamecardScreen.id),
  _Menu(icon: AppAssets.menuIconMaterials, page: MaterialsScreen.id),
  _Menu(icon: AppAssets.menuIconEvent, page: EventScreen.id),
  _Menu(icon: AppAssets.menuIconFeedback, page: VersionScreen.id),
];

class _Menu {
  final String icon;
  final String page;
  final Navigator navigator;

  _Menu({required this.icon, required this.page})
    : navigator = Navigator(
        key: GlobalKey(),
        initialRoute: page,
        onGenerateRoute: (settings) {
          if (page == settings.name) {
            settings = RouteSettings(name: settings.name);
          }
          return TrackerRouter.onGenerate(settings);
        },
      );
}
