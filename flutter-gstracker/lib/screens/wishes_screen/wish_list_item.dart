import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_confirm_dialog.dart';
import 'package:tracker/common/widgets/gs_grid_view.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/gs_time_dialog.dart';
import 'package:tracker/common/widgets/gs_wish_state_icon.dart';
import 'package:tracker/common/widgets/static/cached_image_widget.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/add_wish_screen/add_wish_item_data_list_item.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.dart';

enum ListType { none, top, middle, bottom }

class WishListItem extends StatelessWidget {
  final int pity;
  final int index;
  final GiWish wish;
  final WishState wishState;
  final GeBannerType bannerType;
  final ListType type;

  const WishListItem({
    super.key,
    required this.pity,
    required this.index,
    required this.wish,
    required this.wishState,
    required this.bannerType,
    this.type = ListType.none,
  });

  @override
  Widget build(BuildContext context) {
    final item = GsUtils.items.getItemData(wish.itemId);
    final color = context.themeColors.colorByRarityBg(item.rarity);
    final style = context.textTheme.titleSmall!.copyWith(color: Colors.white);

    Widget wishPity() {
      final pityWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(pity.toString(), style: style),
          GsWishStateIcon(wishState, rarity: item.rarity, banner: bannerType),
        ],
      );

      if (type == ListType.none) {
        return SizedBox(
          width: 44,
          height: 44,
          child: Center(child: pityWidget),
        );
      }

      final side = BorderSide(
        color: Colors.white.withValues(alpha: kDisableOpacity),
        width: 2,
      );

      return SizedBox(
        width: 44,
        height: 44,
        child: Stack(
          children: [
            Positioned.fill(
              left: null,
              child: Container(
                width: 22,
                margin: EdgeInsets.only(
                  top: type == ListType.top ? kSeparator6 : 0,
                  bottom: type == ListType.bottom ? kSeparator6 : 0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: type == ListType.top ? side : BorderSide.none,
                    right: side,
                    bottom: type == ListType.bottom ? side : BorderSide.none,
                  ),
                ),
              ),
            ),
            Center(child: pityWidget),
          ],
        ),
      );
    }

    return Container(
      height: 44,
      margin: const EdgeInsets.only(bottom: GsSpacing.kListSeparator),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.75),
        borderRadius: GsSpacing.kListRadius,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () => _updateDate(context),
                child: Text(
                  wish.date.format().replaceAll(' ', '\n'),
                  textAlign: TextAlign.center,
                  style: style.copyWith(fontSize: 11),
                ),
              ),
            ),
          ),
          wishPity(),
          Expanded(
            child: GestureDetector(
              onLongPress: () async {
                final banners = Database.instance.infoOf<GsBanner>();
                final banner = banners.getItem(wish.bannerId);
                if (banner == null) return;
                final result = await _ItemSelectorDialog.show(context, banner);
                if (result == null || wish.itemId == result) return;
                GsUtils.wishes.updateWishItem(wish, result);
              },
              child: Row(
                children: [
                  Container(
                    width: 44,
                    margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: CachedImageWidget(item.image, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item.name)),
                  SizedBox(
                    width: 44,
                    child: Text(
                      wish.number.toString(),
                      style: style,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateDate(BuildContext context) async {
    final date = await GsTimeDialog.show(context, wish.date);
    if (date == null || date == wish.date) return;

    if (type == ListType.none) {
      GsUtils.wishes.updateWishDate(wish, date);
      return;
    }

    final list = _getWishesAround(wish);
    bool? update = false;
    if (list.length > 1) {
      if (!context.mounted) return;
      final title = context.labels.wishes();
      final subtitle = context.labels.updateAllWishes(list.length);
      update = await GsConfirmDialog.show(context, title, subtitle);
      if (update == null) return;
    }

    if (update) {
      for (final wish in list) {
        GsUtils.wishes.updateWishDate(wish, date);
      }
    } else {
      GsUtils.wishes.updateWishDate(wish, date);
    }
  }

  List<GiWish> _getWishesAround(GiWish wish) {
    final list = <GiWish>[wish];
    final sorted = GsUtils.wishes.getBannerWishes(wish.bannerId);
    final index = sorted.indexWhere((e) => e.id == wish.id);
    if (index == -1) return list;
    final idxWish = sorted[index];
    for (var i = index + 1; i < sorted.length; ++i) {
      if (idxWish.date != sorted[i].date) break;
      list.add(sorted[i]);
    }
    return list;
  }

  static ListType getListType(List<WishSummary> wishes, int index) {
    late final cWish = wishes.elementAtOrNull(index)?.wish;
    late final pWish = wishes.elementAtOrNull(index - 1)?.wish;
    late final nWish = wishes.elementAtOrNull(index + 1)?.wish;
    if (cWish == null) return ListType.none;

    late final isTop = pWish?.date != cWish.date && nWish?.date == cWish.date;
    late final isMid = pWish?.date == cWish.date && nWish?.date == cWish.date;
    late final isBot = pWish?.date == cWish.date && nWish?.date != cWish.date;
    if (isTop) return ListType.top;
    if (isMid) return ListType.middle;
    if (isBot) return ListType.bottom;
    return ListType.none;
  }
}

class _ItemSelectorDialog extends StatelessWidget {
  static Future<String?> show(BuildContext context, GsBanner banner) {
    return showDialog<String>(
      context: context,
      builder: (context) => _ItemSelectorDialog(banner),
    );
  }

  final GsBanner banner;
  const _ItemSelectorDialog(this.banner);

  @override
  Widget build(BuildContext context) {
    bool featured(GsWish itemData) =>
        banner.feature4.contains(itemData.id) ||
        banner.feature5.contains(itemData.id);

    final list = GsUtils.wishes
        .getBannerItemsData(banner)
        .map((e) => e.copyWith(featured: featured(e)))
        .sorted();
    if (list.isEmpty) return const GsNoResultsState();

    return LayoutBuilder(
      builder: (context, constraints) {
        final max = constraints.biggest;
        return Center(
          child: Material(
            type: .transparency,
            child: InventoryBox(
              padding: EdgeInsets.all(kSeparator8),
              margin: EdgeInsets.all(kSeparator16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 300,
                  minHeight: 200,
                  maxWidth: (max.width / 1.3).coerceAtLeast(300),
                  maxHeight: (max.height / 1.3).coerceAtLeast(200),
                ),
                child: Column(
                  spacing: kSeparator6,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.labels.updateWish(),
                      style: context.themeStyles.label16b,
                    ),
                    Flexible(
                      child: GsGridView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];
                          return AddWishItemDataListItem(
                            item: item,
                            isItemFeatured: item.featured,
                            onAdd: () =>
                                Navigator.of(context).maybePop(item.id),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
