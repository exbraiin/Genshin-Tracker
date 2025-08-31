import 'package:dartx/dartx_io.dart';
import 'package:flutter/foundation.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

enum WishState { none, won, lost, guaranteed }

typedef WishSummary = ({GsWish item, GiWish wish, int pity, WishState state});

final class GuWishes {
  final GuCollections _items;
  const GuWishes(this._items);

  /// Gets all released banners by [type]
  Iterable<GsBanner> getReleasedInfoBannerByType(GeBannerType type) {
    final now = DateTime.now();
    return _items.inBanners.items.where(
      (e) => e.type == type && e.dateStart.isBefore(now),
    );
  }

  /// Gets all released banners by [types]
  Iterable<GsBanner> getReleasedInfoBannerByTypes(
    Set<GeBannerType> types,
  ) sync* {
    for (final type in types) {
      yield* getReleasedInfoBannerByType(type);
    }
  }

  /// Gets a list of [GsWish] that can be obtained in banners.
  Iterable<GsWish> getBannerItemsData(GsBanner banner) {
    bool filterWp(GsWeapon info) {
      late final isStandard = info.source == GeItemSourceType.wishesStandard;
      late final isFeatured = banner.feature5.contains(info.id);
      late final isChar =
          banner.type == GeBannerType.character && info.rarity == 5;
      late final isBegn =
          banner.type == GeBannerType.beginner && info.rarity > 3;
      return (isStandard || isFeatured) && !isChar && !isBegn;
    }

    bool filterCh(GsCharacter info) {
      late final isStandard = info.source == GeItemSourceType.wishesStandard;
      late final isFeatured = banner.feature5.contains(info.id);
      late final isWeap =
          banner.type == GeBannerType.weapon && info.rarity == 5;
      return (isStandard || isFeatured) && !isWeap;
    }

    return [
      ..._items.inWeapons.items.where(filterWp).map(GsWish.fromWeapon),
      ..._items.inCharacters.items.where(filterCh).map(GsWish.fromCharacter),
    ];
  }

  /// Gets all wishes for the given [banner].
  List<GiWish> getBannerWishes(String banner) =>
      _items.svWishes.items.where((e) => e.bannerId == banner).toList();

  /// Gets all saved wishes summary for a banner [type] in ascending order.
  List<WishSummary> getSaveWishesSummaryByBannerType(GeBannerType type) {
    return measurePerformance('getSaveWishesSummaryByBannerType($type)', () {
      final l = getReleasedInfoBannerByType(type).map((e) => e.id);
      final wishes =
          _items.svWishes.items.where((e) => l.contains(e.bannerId)).sorted();

      WishState getWishState(
        String itemId,
        WishState lastState,
        Iterable<String>? featured,
      ) {
        if (type == GeBannerType.weapon) return WishState.none;
        if (type.isPermanent || featured == null) return WishState.none;
        final isFeatured = featured.contains(itemId);
        if (!isFeatured) return WishState.lost;
        if (lastState == WishState.lost) return WishState.guaranteed;
        return WishState.won;
      }

      var l4 = 0, l5 = 0;
      var s4 = WishState.none, s5 = WishState.none;
      final list = <WishSummary>[];
      for (final wish in wishes) {
        l4++;
        l5++;

        final item = _items.getWishItem(wish.itemId);
        late final banner = _items.inBanners.getItem(wish.bannerId);

        if (item.rarity == 5) {
          final state = getWishState(wish.itemId, s5, banner?.feature5);
          final tuple = (item: item, wish: wish, state: state, pity: l5);
          list.add(tuple);
          l5 = 0;
          s5 = state;
        } else if (item.rarity == 4) {
          final state = getWishState(wish.itemId, s4, banner?.feature4);
          final tuple = (item: item, wish: wish, state: state, pity: l4);
          list.add(tuple);
          l4 = 0;
          s4 = state;
        } else {
          final tuple = (
            item: item,
            wish: wish,
            state: WishState.none,
            pity: 1,
          );
          list.add(tuple);
        }
      }

      return list;
    });
  }

  WishesSummary getWishesSummary(GeBannerType type) {
    return measurePerformance('getWishesSummary($type)', () {
      final wishes = getSaveWishesSummaryByBannerType(
        type,
      ).sortedByDescending((e) => e.wish);

      final info4 = <WishSummary>[];
      final info4Weapon = <WishSummary>[];
      final info4Character = <WishSummary>[];
      final info5 = <WishSummary>[];
      final info5Weapon = <WishSummary>[];
      final info5Character = <WishSummary>[];

      var l4 = 0, l4w = 0, l4c = 0;
      var l5 = 0, l5w = 0, l5c = 0;
      bool? is4Guaranteed, is5Guaranteed;

      for (final item in wishes) {
        if (item.item.rarity == 4) {
          info4.add(item);
          is4Guaranteed ??=
              !(_items.inBanners
                      .getItem(item.wish.bannerId)
                      ?.feature4
                      .contains(item.wish.itemId) ??
                  true);

          if (item.item.isWeapon) {
            info4Weapon.add(item);
          } else {
            info4Character.add(item);
          }
        } else if (item.item.rarity == 5) {
          info5.add(item);
          is5Guaranteed ??=
              !(_items.inBanners
                      .getItem(item.wish.bannerId)
                      ?.feature5
                      .contains(item.wish.itemId) ??
                  true);
          if (item.item.isWeapon) {
            info5Weapon.add(item);
          } else {
            info5Character.add(item);
          }
        }
        if (info4.isEmpty) {
          l4++;
          if (info4Weapon.isEmpty) l4w++;
          if (info4Character.isEmpty) l4c++;
        }
        if (info5.isEmpty) {
          l5++;
          if (info5Weapon.isEmpty) l5w++;
          if (info5Character.isEmpty) l5c++;
        }
      }

      WishesInfo getWishInfo(List<WishSummary> list, int last) {
        return (
          last: last,
          total: list.length,
          average: list.isNotEmpty ? list.averageBy((e) => e.pity) : 0.0,
          percentage: list.length * 100 / wishes.length.coerceAtLeast(1),
          wishes: list,
        );
      }

      return WishesSummary(
        total: wishes.length,
        isNext4Guaranteed: is4Guaranteed ?? false,
        isNext5Guaranteed: is5Guaranteed ?? false,
        info4: getWishInfo(info4, l4),
        info4Weapon: getWishInfo(info4Weapon, l4w),
        info4Character: getWishInfo(info4Character, l4c),
        info5: getWishInfo(info5, l5),
        info5Weapon: getWishInfo(info5Weapon, l5w),
        info5Character: getWishInfo(info5Character, l5c),
      );
    });
  }

  Future<WishesSummary> getWishesSummaryAsync(GeBannerType type) {
    return compute(((GuWishes, GeBannerType) data) {
      final (wishes, type) = data;
      return wishes.getWishesSummary(type);
    }, (this, type));
  }

  /// Whether the [banner] has wishes.
  bool bannerHasWishes(String banner) =>
      _items.svWishes.items.any((e) => e.bannerId == banner);

  /// Counts the [banner] wishes.
  int countBannerWishes(String banner) =>
      _items.svWishes.items.count((e) => e.bannerId == banner);

  /// Removes the [bannerId] last wish
  ///
  /// {@macro db_update}
  void removeLastWish(String bannerId) {
    final list = getBannerWishes(bannerId).sorted();
    if (list.isEmpty) return;
    _items.svWishes.removeItem(list.last.id);
  }

  /// Updates the given [wish] date.
  ///
  /// {@macro db_update}
  void updateWishDate(GiWish wish, DateTime date) {
    if (!_items.svWishes.exists(wish.id)) return;
    final newWish = wish.copyWith(date: date);
    _items.svWishes.setItem(newWish);
  }

  /// Adds the items with the given [ids] to the given [bannerId].
  ///
  /// {@macro db_update}
  void addWishes({
    required Iterable<String> ids,
    required DateTime date,
    required String bannerId,
  }) async {
    final lastRoll = countBannerWishes(bannerId);
    final wishes = ids.mapIndexed((i, id) {
      final number = lastRoll + i + 1;
      return GiWish(
        id: '${bannerId}_$number',
        number: number,
        itemId: id,
        bannerId: bannerId,
        date: date,
      );
    });

    final setItem = _items.svWishes.setItem;
    wishes.forEach(setItem);
  }
}

typedef WishesInfo =
    ({
      int last,
      int total,
      double average,
      double percentage,
      List<WishSummary> wishes,
    });

class WishesSummary {
  final int total;
  final bool isNext4Guaranteed;
  final bool isNext5Guaranteed;
  final WishesInfo info4;
  final WishesInfo info5;
  final WishesInfo info4Weapon;
  final WishesInfo info4Character;
  final WishesInfo info5Weapon;
  final WishesInfo info5Character;

  WishesSummary({
    required this.total,
    required this.isNext4Guaranteed,
    required this.isNext5Guaranteed,
    required this.info4,
    required this.info5,
    required this.info4Weapon,
    required this.info4Character,
    required this.info5Weapon,
    required this.info5Character,
  });
}
