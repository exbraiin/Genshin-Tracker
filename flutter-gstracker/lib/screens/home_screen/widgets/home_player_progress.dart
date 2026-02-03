import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/static/sliver_grid_fixed_size_delegate.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/achievements_screen/achievement_groups_screen.dart';
import 'package:tracker/screens/envisaged_echo_screen/envisaged_echo_screen.dart';
import 'package:tracker/screens/lunar_arcana_screen/lunar_arcana_screen.dart';
import 'package:tracker/screens/main_screen/main_screen.dart';
import 'package:tracker/screens/recipes_screen/recipes_screen.dart';
import 'package:tracker/screens/remarkable_chests_screen/remarkable_chests_screen.dart';
import 'package:tracker/screens/screen_filters/screen_filter_builder.dart';
import 'package:tracker/screens/serenitea_sets_screen/serenitea_sets_screen.dart';
import 'package:tracker/screens/spincrystals_screen/spincrystals_screen.dart';
import 'package:tracker/screens/thespian_tricks_screen/thespian_tricks_screen.dart';
import 'package:tracker/theme/gs_assets.dart';

class HomePlayerProgress extends StatelessWidget {
  const HomePlayerProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder<bool>(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        return GsDataBox.info(
          title: Text(context.labels.progress()),
          child: Padding(
            padding: EdgeInsetsGeometry.only(top: kSeparator8),
            child: GridView.custom(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedChildSize(
                childWidth: 93,
                childHeight: 117,
                mainAxisSpacing: GsSpacing.kGridSeparator,
                crossAxisSpacing: GsSpacing.kGridSeparator,
                alignment: CrossAxisAlignment.center,
              ),
              childrenDelegate: SliverChildListDelegate([
                _ProgressInfo(
                  AppAssets.menuIconAchievements,
                  context.labels.achievements(),
                  GsUtils.achievements.countSaved(),
                  GsUtils.achievements.countTotal(),
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsAchievement>({
                      FilterKey.obtained: false,
                    });
                    MainScreen.navigateTo(context, AchievementGroupsScreen.id);
                  },
                ),
                _ProgressInfo(
                  AppAssets.menuIconRecipes,
                  context.labels.recipes(),
                  GsUtils.recipes.totalPermanent(owned: true),
                  GsUtils.recipes.totalPermanent(),
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsRecipe>({
                      FilterKey.obtained: false,
                    });
                    MainScreen.navigateTo(context, RecipesScreen.id);
                  },
                ),
                _ProgressInfo(
                  AppAssets.menuIconRecipes,
                  context.labels.filterProficiency(),
                  GsUtils.recipes.totalMastered(owned: true),
                  GsUtils.recipes.totalMastered(),
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsRecipe>({
                      FilterKey.maxProficiency: false,
                    });
                    MainScreen.navigateTo(context, RecipesScreen.id);
                  },
                ),
                _ProgressInfo(
                  AppAssets.menuIconMap,
                  context.labels.remarkableChests(),
                  GsUtils.furnitureChests.owned,
                  GsUtils.furnitureChests.total,
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsFurnitureChest>({
                      FilterKey.obtained: false,
                    });
                    MainScreen.navigateTo(context, RemarkableChestsScreen.id);
                  },
                ),
                _ProgressInfo(
                  AppAssets.menuEnvisagedEchoes,
                  context.labels.envisagedEchoes(),
                  GsUtils.envisagedEchos.owned,
                  GsUtils.envisagedEchos.total,
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsEnvisagedEcho>({
                      FilterKey.obtained: false,
                    });
                    MainScreen.navigateTo(context, EnvisagedEchoScreen.id);
                  },
                ),
                _ProgressInfo(
                  AppAssets.menuIconThespianTricks,
                  context.labels.thespianTricks(),
                  GsUtils.thespianTricks.owned,
                  GsUtils.thespianTricks.total,
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsThespianTrick>({
                      FilterKey.obtained: false,
                    });
                    MainScreen.navigateTo(context, ThespianTricksScreen.id);
                  },
                ),
                _ProgressInfo(
                  AppAssets.menuIconPreciousItems,
                  context.labels.spincrystals(),
                  GsUtils.spincrystals.owned,
                  GsUtils.spincrystals.total,
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsSpincrystal>({
                      FilterKey.obtained: false,
                    });
                    MainScreen.navigateTo(context, SpincrystalsScreen.id);
                  },
                ),
                _ProgressInfo(
                  AppAssets.menuIconSereniteaSets,
                  context.labels.sereniteaSets(),
                  GsUtils.sereniteaSets.owned,
                  GsUtils.sereniteaSets.total,
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsSereniteaSet>({
                      FilterKey.obtained: false,
                    });
                    MainScreen.navigateTo(context, SereniteaSetsScreen.id);
                  },
                ),
                _ProgressInfo(
                  AppAssets.menuLunarArcana,
                  context.labels.lunarArcana(),
                  GsUtils.lunarArcana.owned,
                  GsUtils.lunarArcana.total,
                  onPressed: () {
                    ScreenFilters.setFilterValues<GsLunarArcana>({
                      FilterKey.obtained: false,
                    });
                    MainScreen.navigateTo(context, LunarArcanaScreen.id);
                  },
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}

class _ProgressInfo extends StatelessWidget {
  final int owned;
  final int total;
  final String asset;
  final String label;
  final void Function()? onPressed;

  const _ProgressInfo(
    this.asset,
    this.label,
    this.owned,
    this.total, {
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (owned / total.coerceAtLeast(1)).clamp(0.0, 1.0);
    final missing = total - owned;

    final style = context.themeStyles.label12n;
    final child = Padding(
      padding: const EdgeInsets.all(kSeparator4),
      child: Column(
        spacing: kSeparator4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              SizedBox(
                width: 46,
                height: 46,
                child: Center(child: Image.asset(asset, width: 32, height: 32)),
              ),
              CircularProgressIndicator(
                constraints: BoxConstraints.tight(Size(46, 46)),
                value: percentage,
                strokeWidth: 4,
                backgroundColor: context.themeColors.mainColor1,
                color: context.themeColors.almostWhite,
                strokeCap: StrokeCap.round,
              ),
            ],
          ),
          SizedBox(height: kSeparator2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: 100,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      owned.format(),
                      textAlign: TextAlign.end,
                      style: style.copyWith(
                        color: missing > 0
                            ? context.themeColors.badValue
                            : Colors.white,
                      ),
                    ),
                    if (missing > 0)
                      Text(
                        '+${missing.format()}',
                        style: style.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                          color: context.themeColors.goodValue,
                        ),
                        strutStyle: style.copyWith(fontSize: 10).toStrut(),
                      ),
                    Text(
                      ' / ${total.format()}',
                      textAlign: TextAlign.end,
                      style: style,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _autoScaleText(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: context.themeStyles.label12n,
          ),
        ],
      ),
    );

    if (onPressed == null) return child;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: GsSpacing.kGridRadius,
        onTap: onPressed,
        child: child,
      ),
    );
  }

  static Widget _autoScaleText(
    String text, {
    required int maxLines,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    String splitTextByMaxLines(String text, int maxLines) {
      final words = text.split(RegExp(r'\s+'));
      if (maxLines <= 1 || words.length < maxLines) {
        return text;
      }

      final wordsPerLine = (words.length / maxLines).ceil();
      final buffer = StringBuffer();

      for (int i = 0; i < words.length; i += wordsPerLine) {
        buffer.writeln(
          words.sublist(i, (i + wordsPerLine).clamp(0, words.length)).join(' '),
        );
      }

      return buffer.toString();
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        splitTextByMaxLines(text, maxLines),
        maxLines: maxLines,
        textAlign: textAlign,
        style: style,
      ),
    );
  }
}
