import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/static/sliver_grid_fixed_size_delegate.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/gs_database.dart';
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
                childHeight: 115,
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
                ),
                _ProgressInfo(
                  AppAssets.menuIconRecipes,
                  context.labels.recipes(),
                  GsUtils.recipes.totalPermanent(owned: true),
                  GsUtils.recipes.totalPermanent(),
                ),
                _ProgressInfo(
                  AppAssets.menuIconRecipes,
                  context.labels.filterProficiency(),
                  GsUtils.recipes.totalMastered(owned: true),
                  GsUtils.recipes.totalMastered(),
                ),
                _ProgressInfo(
                  AppAssets.menuIconMap,
                  context.labels.remarkableChests(),
                  GsUtils.furnitureChests.owned,
                  GsUtils.furnitureChests.total,
                ),
                _ProgressInfo(
                  AppAssets.menuEnvisagedEchoes,
                  context.labels.envisagedEchoes(),
                  GsUtils.envisagedEchos.owned,
                  GsUtils.envisagedEchos.total,
                ),
                _ProgressInfo(
                  AppAssets.menuIconThespianTricks,
                  context.labels.thespianTricks(),
                  GsUtils.thespianTricks.owned,
                  GsUtils.thespianTricks.total,
                ),
                _ProgressInfo(
                  AppAssets.menuIconPreciousItems,
                  context.labels.spincrystals(),
                  GsUtils.spincrystals.owned,
                  GsUtils.spincrystals.total,
                ),
                _ProgressInfo(
                  AppAssets.menuIconSereniteaSets,
                  context.labels.sereniteaSets(),
                  GsUtils.sereniteaSets.owned,
                  GsUtils.sereniteaSets.total,
                ),
                _ProgressInfo(
                  AppAssets.menuLunarArcana,
                  context.labels.lunarArcana(),
                  GsUtils.lunarArcana.owned,
                  GsUtils.lunarArcana.total,
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

  const _ProgressInfo(this.asset, this.label, this.owned, this.total);

  @override
  Widget build(BuildContext context) {
    final percentage = (owned / total.coerceAtLeast(1)).clamp(0.0, 1.0);
    final missing = total - owned;

    final style = context.themeStyles.label12n;

    return Column(
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
        Text(
          label,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: context.themeStyles.label12n,
        ),
      ],
    );
  }
}
