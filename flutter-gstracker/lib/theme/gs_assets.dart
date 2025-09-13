import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/theme/gs_assets.g.dart';

export 'package:tracker/theme/gs_assets.g.dart';
export 'package:tracker/theme/gs_spacing.dart';
export 'package:tracker/theme/theme.dart';

abstract final class GsAssets {
  static String iconSetType(GeSereniteaSetType type) {
    return switch (type) {
      GeSereniteaSetType.none => AppAssets.missingIcon,
      GeSereniteaSetType.indoor => AppAssets.iconIndoorSet,
      GeSereniteaSetType.outdoor => AppAssets.iconOutdoorSet,
    };
  }

  static String iconNamecardType(GeNamecardType type) {
    return switch (type) {
      GeNamecardType.none => AppAssets.missingIcon,
      GeNamecardType.defaults => AppAssets.menuIconWish,
      GeNamecardType.achievement => AppAssets.menuIconAchievements,
      GeNamecardType.battlepass => AppAssets.menuIconWeapons,
      GeNamecardType.character => AppAssets.menuIconCharacters,
      GeNamecardType.event => AppAssets.menuIconFeedback,
      GeNamecardType.offering => AppAssets.menuIconQuest,
      GeNamecardType.reputation => AppAssets.menuIconReputation,
    };
  }

  static String iconRegionType(GeRegionType type) {
    return switch (type) {
      GeRegionType.none => AppAssets.missingIcon,
      GeRegionType.mondstadt => AppAssets.mondstadt,
      GeRegionType.liyue => AppAssets.liyue,
      GeRegionType.inazuma => AppAssets.inazuma,
      GeRegionType.sumeru => AppAssets.sumeru,
      GeRegionType.fontaine => AppAssets.fontaine,
      GeRegionType.natlan => AppAssets.natlan,
      GeRegionType.nodkrai => AppAssets.nodKrai,
      GeRegionType.snezhnaya => AppAssets.unknown,
    };
  }

  static String getRarityBgImage(int rarity) {
    return switch (rarity) {
      1 => AppAssets.item1Star,
      2 => AppAssets.item2Star,
      3 => AppAssets.item3Star,
      4 => AppAssets.item4Star,
      5 => AppAssets.item5Star,
      _ => AppAssets.missingIcon,
    };
  }

  static String getStygianIcon(int index) {
    return switch (index) {
      0 => AppAssets.playerStygian0,
      1 => AppAssets.playerStygian1,
      2 => AppAssets.playerStygian2,
      3 => AppAssets.playerStygian3,
      4 => AppAssets.playerStygian4,
      5 => AppAssets.playerStygian5,
      6 => AppAssets.playerStygian6,
      7 => AppAssets.playerStygian7,
      _ => AppAssets.missingIcon,
    };
  }
}
