import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart' show GsAchievement, GiAchievement;
import 'package:tracker/domain/utils/_gu_collections.dart';

final class GuAchievements {
  final GuCollections _items;
  const GuAchievements(this._items);

  int countTotal([bool Function(GsAchievement)? test]) {
    var items = _items.inAchievements.items;
    if (test != null) items = items.where(test);
    return items.sumBy((e) => e.phases.length).toInt();
  }

  int countTotalRewards([bool Function(GsAchievement)? test]) {
    var items = _items.inAchievements.items;
    if (test != null) items = items.where(test);
    return items.sumBy((e) => e.phases.sumBy((e) => e.reward)).toInt();
  }

  bool isObtainable(String id) {
    final saved = _items.svAchievements.getItem(id);
    if (saved == null) return true;
    final item = _items.inAchievements.getItem(id);
    return (item?.phases.length ?? 0) > saved.obtained;
  }

  int countSaved([bool Function(GsAchievement)? test]) {
    var items = _items.inAchievements.items;
    if (test != null) items = items.where(test);
    return items
        .sumBy((e) => _items.svAchievements.getItem(e.id)?.obtained ?? 0)
        .toInt();
  }

  int countSavedRewards([bool Function(GsAchievement)? test]) {
    var items = _items.inAchievements.items;
    if (test != null) items = items.where(test);
    return items.sumBy((e) {
      final i = _items.svAchievements.getItem(e.id)?.obtained ?? 0;
      return e.phases.take(i).sumBy((element) => element.reward);
    }).toInt();
  }

  /// Updates the achievement obtained phase
  ///
  /// {@macro db_update}
  void update(String id, {required int obtained}) {
    final saved = _items.svAchievements.getItem(id)?.obtained ?? 0;
    if (saved >= obtained) obtained -= 1;
    if (obtained > 0) {
      final item = GiAchievement(id: id, obtained: obtained);
      _items.svAchievements.setItem(item);
    } else {
      _items.svAchievements.removeItem(id);
    }
  }
}
