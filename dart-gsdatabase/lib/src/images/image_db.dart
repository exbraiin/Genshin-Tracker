import 'dart:io';

import 'package:gsdatabase/gsdatabase.dart';

var _base = '';

void initializeImageDatabase(Directory directory) {
  _base = directory.absolute.path;
}

extension GsModelImageExt<T extends GsModel<T>> on T {
  File? get image {
    final path = _getImagePath(this);
    return path != null ? File(path) : null;
  }
}

extension GsArtifactPieceImageExt on GsArtifactPiece {
  File? getIcon(GsArtifact model) {
    final path = _getPath(GsArtifact.kTableKey, model.id, '_${type.id}');
    return File(path);
  }
}

extension GsCharacterImageExt on GsCharacter {
  File? get fullart {
    final path = _getPath(GsCharacter.kTableKey, id, '_full');
    return File(path);
  }

  File? get constellationImage {
    final path = _getPath(GsCharacter.kTableKey, id, '_constellation');
    return File(path);
  }
}

extension GsWeaponImageExt on GsWeapon {
  File? get imageAsc {
    final path = _getPath(GsWeapon.kTableKey, id, '_ascension');
    return File(path);
  }
}

extension GsNamecardImageExt on GsNamecard {
  File? get background {
    final path = _getPath(GsNamecard.kTableKey, id, '_background');
    return File(path);
  }
}

String? _getImagePath<T extends GsModel<T>>(T? model) {
  if (model == null) return null;
  return switch (model) {
    final GsAchievement item => _getPath(
      GsAchievementGroup.kTableKey,
      item.group,
    ),
    final GsAchievementGroup item => _getPath(
      GsAchievementGroup.kTableKey,
      item.id,
    ),
    final GsArtifact item => _getPath(
      GsArtifact.kTableKey,
      item.id,
      '_${item.pieces.firstOrNull?.type.id}',
    ),
    final GsBanner item => _getPath(GsBanner.kTableKey, item.id),
    final GsBattlepass item => _getPath(GsBattlepass.kTableKey, item.id),
    final GsCharacter item => _getPath(GsCharacter.kTableKey, item.id),
    final GsCharacterSkin item => _getPath(GsCharacter.kTableKey, item.id),
    final GsEvent item => _getPath(GsEvent.kTableKey, item.id),
    final GsEnvisagedEcho item => _getPath(GsEnvisagedEcho.kTableKey, item.id),
    final GsThespianTrick item => _getPath(GsThespianTrick.kTableKey, item.id),
    final GsMaterial item => _getPath(GsMaterial.kTableKey, item.id),
    final GsNamecard item => _getPath(GsNamecard.kTableKey, item.id),
    final GsRecipe item => _getPath(GsRecipe.kTableKey, item.id),
    final GsFurnitureChest item => _getPath(
      GsFurnitureChest.kTableKey,
      item.id,
    ),
    final GsLunarArcana item => _getPath(GsLunarArcana.kTableKey, item.id),
    final GsSereniteaSet item => _getPath(GsSereniteaSet.kTableKey, item.id),
    final GsSpincrystal item => _getPath(GsSpincrystal.kTableKey, item.id),
    final GsVersion item => _getPath(GsVersion.kTableKey, item.id),
    final GsWeapon item => _getPath(GsWeapon.kTableKey, item.id),
    final GsWish item =>
      _getImagePath(item.character) ?? _getImagePath(item.weapon),
    _ => null,
  };
}

String _getPath(String collection, String id, [String suffix = '']) {
  return '$_base/$collection/$id$suffix.webp';
}
