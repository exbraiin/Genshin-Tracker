import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart' show GsCharacter, GiCharacter;
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

enum CharTalentType { attack, skill, burst }

final class GuCharacters {
  final GuCollections _items;
  const GuCharacters(this._items);

  /// Whether the user has this character or not.
  bool hasCaracter(String id) {
    return _items.hasCaracter(id);
  }

  int eventCharacters(String id) {
    return _items.svEventRewards.items.count(
      (e) => e.obtainedCharacters.contains(id),
    );
  }

  int getCharFriendship(String id) {
    final char = _items.svCharacters.getItem(id);
    return char?.friendship.coerceAtLeast(1) ?? 1;
  }

  /// Gets the character ascension level.
  int getCharAscension(String id) {
    final char = _items.svCharacters.getItem(id);
    return char?.ascension ?? 0;
  }

  /// Whether the character is fully ascended or not.
  bool isCharMaxAscended(String id) {
    return !(getCharAscension(id) < 6);
  }

  /// Whether the character is owned and not fully ascended.
  bool isCharAscendable(GsCharacter char) {
    return hasCaracter(char.id) && !isCharMaxAscended(char.id);
  }

  /// Gets the character current constellations amount or null.
  int? getCharConstellations(String id) {
    return getTotalCharConstellations(id)?.clamp(0, 6);
  }

  /// Gets the character total constellations amount or null.
  int? getTotalCharConstellations(String id) {
    final total = _items.countWishesItem(id);
    final sum = total + eventCharacters(id);
    return sum > 0 ? (sum - 1) : null;
  }

  CharInfo? getCharInfo(String id) {
    final item = _items.inCharacters.getItem(id);
    if (item == null) return null;

    final info = _items.svCharacters.getItem(id) ?? GiCharacter(id: id);

    final wishes = _items.countWishesItem(id);
    final owned = wishes + eventCharacters(id);
    final constellations = owned > 0 ? (owned - 1) : 0;

    return CharInfo._(
      item: item,
      info: info,
      isOwned: owned > 0,
      totalConstellations: constellations,
    );
  }

  /// Sets the character friendship
  ///
  /// {@macro db_update}
  void setCharFriendship(String id, int friendship) {
    final char = _items.svCharacters.getItem(id);
    final friend = friendship.clamp(1, 10);
    final item = (char ?? GiCharacter(id: id)).copyWith(friendship: friend);
    if (item.friendship != char?.friendship) {
      _items.svCharacters.setItem(item);
    }
  }

  /// Increases the character friendship
  ///
  /// {@macro db_update}
  void increaseFriendshipCharacter(String id) {
    final char = _items.svCharacters.getItem(id);
    var cFriendship = char?.friendship ?? 1;
    cFriendship = ((cFriendship + 1) % 11).coerceAtLeast(1);
    final item = (char ?? GiCharacter(id: id)).copyWith(
      friendship: cFriendship,
    );
    _items.svCharacters.setItem(item);
  }

  /// Increases the character ascension
  ///
  /// {@macro db_update}
  void increaseAscension(String id) {
    final char = _items.svCharacters.getItem(id);
    var cAscension = char?.ascension ?? 0;
    cAscension = (cAscension + 1) % 7;
    final item = (char ?? GiCharacter(id: id)).copyWith(ascension: cAscension);
    _items.svCharacters.setItem(item);
  }

  /// Increases the character talent
  ///
  /// {@macro db_update}
  void increaseTalent(String id, CharTalentType tal) {
    final char = _items.svCharacters.getItem(id) ?? GiCharacter(id: id);
    final talent = switch (tal) {
      CharTalentType.attack => char.talent1,
      CharTalentType.skill => char.talent2,
      CharTalentType.burst => char.talent3,
    };

    final cTalent = ((talent + 1) % (10 + 1)).coerceAtLeast(1);
    final item = switch (tal) {
      CharTalentType.attack => char.copyWith(talent1: cTalent),
      CharTalentType.skill => char.copyWith(talent2: cTalent),
      CharTalentType.burst => char.copyWith(talent3: cTalent),
    };
    _items.svCharacters.setItem(item);
  }
}

final class CharInfo {
  final GsCharacter item;
  final GiCharacter info;
  final bool isOwned;
  final int ascension;
  final int friendship;
  final int totalConstellations;
  final String iconImage;
  final String wishImage;
  final CharTalents? talents;

  bool get isMaxAscension => ascension >= 6;
  bool get isAscendable => isOwned && !isMaxAscension;
  int get constellations => totalConstellations.clamp(0, 6);
  int get extraConstellations => totalConstellations - constellations;

  int get lowestTalent => talents?.lowest ?? 1;
  int get talentsTotal => talents?.total ?? 0;
  int get talentsTotalCrownless => talents?.totalCrownless ?? 0;

  CharInfo._({
    required this.item,
    required this.info,
    required this.isOwned,
    required this.totalConstellations,
  }) : iconImage = item.image,
       wishImage = item.fullImage,
       ascension = info.ascension.clamp(0, 6),
       friendship = info.friendship.clamp(1, 10),
       talents = isOwned ? CharTalents(item, info, totalConstellations) : null;
}

final class CharTalents {
  static const kTotal = 30;
  static const kMaxLevel = 10;
  static const kTotalCrownless = 9 * 3;
  final Map<CharTalentType, (int, int)> _data;

  int get lowest => _data.values.minBy((e) => e.$1)?.$1 ?? 1;
  int get total => _data.values.sumBy((e) => e.$1);
  int get totalCrownless => _data.values.sumBy((e) => e.$1.coerceAtMost(9));

  CharTalents(GsCharacter item, GiCharacter info, int cons)
    : _data = CharTalentType.values.toMap(
        (tal) => tal,
        (tal) => _parseTalent(item, info, tal, cons),
      );

  static (int, int) _parseTalent(
    GsCharacter item,
    GiCharacter info,
    CharTalentType tal,
    int cons,
  ) {
    final (value, talCons) = switch (tal) {
      CharTalentType.attack => (info.talent1, item.talentAConstellation),
      CharTalentType.skill => (info.talent2, item.talentEConstellation),
      CharTalentType.burst => (info.talent3, item.talentQConstellation),
    };

    final extra = cons >= talCons && talCons > 0 ? 3 : 0;
    return (value.clamp(1, 10), extra);
  }

  int talent(CharTalentType tal) {
    final (value, _) = _data[tal]!;
    return value;
  }

  int talentWithExtra(CharTalentType tal) {
    final (value, extra) = _data[tal]!;
    return value + extra;
  }

  bool hasExtra(CharTalentType tal) {
    final (_, extra) = _data[tal]!;
    return extra != 0;
  }

  bool isMissing({required bool crownless}) {
    final max = CharTalents.kMaxLevel - (crownless ? 1 : 0);
    return _data.values.any((e) => e.$1 < max);
  }
}
