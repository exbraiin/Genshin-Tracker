import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/gs_database.dart';

final class GuCollections {
  final Items<GsEvent> inEvents;
  final Items<GsBanner> inBanners;
  final Items<GsRecipe> inRecipes;
  final Items<GsWeapon> inWeapons;
  final Items<GsVersion> inVersions;
  final Items<GsMaterial> inMaterials;
  final Items<GsCharacter> inCharacters;
  final Items<GsLunarArcana> inLunarArcana;
  final Items<GsAchievement> inAchievements;
  final Items<GsSpincrystal> inSpincrystals;
  final Items<GsSereniteaSet> inSereniteaSet;
  final Items<GsEnvisagedEcho> inEnvisagedEcho;
  final Items<GsThespianTrick> inThespianTricks;
  final Items<GsFurnitureChest> inFurnitureChests;

  final Items<GiWish> svWishes;
  final Items<GiRecipe> svRecipes;
  final Items<GiCharacter> svCharacters;
  final Items<GiAchievement> svAchievements;
  final Items<GiLunarArcana> svLunarArcana;
  final Items<GiSpincrystal> svSpincrystals;
  final Items<GiEventRewards> svEventRewards;
  final Items<GiSereniteaSet> svSereniteaSet;
  final Items<GiEnvisagedEcho> svEnvisagedEcho;
  final Items<GiThespianTrick> svThespianTricks;
  final Items<GiFurnitureChest> svFurnitureChests;

  final Items<GiPlayerInfo> svPlayerInfo;
  final Items<GiAccountInfo> svAccountInfo;

  GuCollections(Database db)
    : inEvents = db.infoOf<GsEvent>(),
      inBanners = db.infoOf<GsBanner>(),
      inRecipes = db.infoOf<GsRecipe>(),
      inWeapons = db.infoOf<GsWeapon>(),
      inVersions = db.infoOf<GsVersion>(),
      inMaterials = db.infoOf<GsMaterial>(),
      inCharacters = db.infoOf<GsCharacter>(),
      inLunarArcana = db.infoOf<GsLunarArcana>(),
      inAchievements = db.infoOf<GsAchievement>(),
      inSpincrystals = db.infoOf<GsSpincrystal>(),
      inSereniteaSet = db.infoOf<GsSereniteaSet>(),
      inEnvisagedEcho = db.infoOf<GsEnvisagedEcho>(),
      inThespianTricks = db.infoOf<GsThespianTrick>(),
      inFurnitureChests = db.infoOf<GsFurnitureChest>(),
      //
      svWishes = db.saveOf<GiWish>(),
      svRecipes = db.saveOf<GiRecipe>(),
      svCharacters = db.saveOf<GiCharacter>(),
      svAchievements = db.saveOf<GiAchievement>(),
      svLunarArcana = db.saveOf<GiLunarArcana>(),
      svSpincrystals = db.saveOf<GiSpincrystal>(),
      svEventRewards = db.saveOf<GiEventRewards>(),
      svSereniteaSet = db.saveOf<GiSereniteaSet>(),
      svEnvisagedEcho = db.saveOf<GiEnvisagedEcho>(),
      svThespianTricks = db.saveOf<GiThespianTrick>(),
      svFurnitureChests = db.saveOf<GiFurnitureChest>(),
      //
      svPlayerInfo = db.saveOf<GiPlayerInfo>(),
      svAccountInfo = db.saveOf<GiAccountInfo>();

  GsWish getWishItem(String itemId) {
    final weapon = inWeapons.getItem(itemId);
    return weapon != null
        ? GsWish.fromWeapon(weapon)
        : GsWish.fromCharacter(inCharacters.getItem(itemId));
  }

  /// Counts the obtained amount of [itemId].
  int countWishesItem(String itemId) {
    return svWishes.items.count((e) => e.itemId == itemId);
  }

  /// Whether the user has this character or not.
  bool hasCaracter(String id) {
    late final hasEvent = svEventRewards.items.any(
      (e) => e.obtainedCharacters.contains(id),
    );
    late final hasWish = svWishes.items.any((e) => e.itemId == id);
    return hasEvent || hasWish;
  }
}
