import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/domain/utils/gs_collections.dart';
import 'package:tracker/domain/utils/gu_achievements.dart';
import 'package:tracker/domain/utils/gu_characters.dart';
import 'package:tracker/domain/utils/gu_envisaged_echos.dart';
import 'package:tracker/domain/utils/gu_events.dart';
import 'package:tracker/domain/utils/gu_furniture_chests.dart';
import 'package:tracker/domain/utils/gu_items.dart';
import 'package:tracker/domain/utils/gu_lunar_arcana.dart';
import 'package:tracker/domain/utils/gu_materials.dart';
import 'package:tracker/domain/utils/gu_player_configs.dart';
import 'package:tracker/domain/utils/gu_recipes.dart';
import 'package:tracker/domain/utils/gu_serenitea_sets.dart';
import 'package:tracker/domain/utils/gu_spincrystals.dart';
import 'package:tracker/domain/utils/gu_thespian_tricks.dart';
import 'package:tracker/domain/utils/gu_versions.dart';
import 'package:tracker/domain/utils/gu_weapons.dart';
import 'package:tracker/domain/utils/gu_wishes.dart';

export 'gu_characters.dart' show CharInfo, CharTalents, CharTalentType;
export 'gu_wishes.dart' show WishState, WishSummary, WishesSummary, WishesInfo;

/// {@template db_update}
/// Updates db collection
/// {@endtemplate}
final class _Details {
  const _Details();
  final primogemsPerWish = 160;
  final primogemsPerCharSet = 20;
}

abstract final class GsUtils {
  static const details = _Details();
  static final _db = Database.instance;
  static final _items = GuCollections(_db);

  static final items = GuItems(_items);
  static final wishes = GuWishes(_items);
  static final events = GuEvents(_items);
  static final recipes = GuRecipes(_items);
  static final weapons = GuWeapons(_items);
  static final versions = GuVersions(_items);
  static final materials = GuMaterials(_items);
  static final characters = GuCharacters(_items);
  static final lunarArcana = GuLunarArcana(_items);
  static final achievements = GuAchievements(_items);
  static final spincrystals = GuSpincrystals(_items);
  static final sereniteaSets = GuSereniteaSets(_items);
  static final envisagedEchos = GuEnvisagedEcho(_items);
  static final thespianTricks = GuThespianTricks(_items);
  static final furnitureChests = GuFurnitureChest(_items);

  static final playerConfigs = GuPlayerConfigs(_items);
}
