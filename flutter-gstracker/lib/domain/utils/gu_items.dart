import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

final class GuItems {
  final GuCollections _items;
  const GuItems(this._items);

  /// Gets a weapon or a character by the given [id].
  GsWish getItemData(String id) {
    return _items.getWishItem(id);
  }

  /// Gets a weapon or a character by the given [id].
  GsWish? getItemDataOrNull(String? id) {
    if (id == null) return null;
    final weapon = _items.inWeapons.getItem(id);
    if (weapon != null) return GsWish.fromWeapon(weapon);
    final character = _items.inCharacters.getItem(id);
    if (character != null) return GsWish.fromCharacter(character);
    return null;
  }

  Map<GsMaterial, List<GsWish>> getItemsByMaterial(GeWeekdayType weekday) {
    final getMat = _items.inMaterials.getItem;
    return [
          ..._items.inCharacters.items.map(
            (element) => MapEntry(element.id, element.talentMaterial),
          ),
          ..._items.inWeapons.items.map(
            (element) => MapEntry(element.id, element.matWeapon),
          ),
        ]
        .groupBy((element) => element.value)
        .entries
        .where((element) => getMat(element.key)!.weekdays.contains(weekday))
        .toMap(
          (e) => _items.inMaterials.getItem(e.key)!,
          (e) => e.value.map((e) => getItemData(e.key)).toList(),
        );
  }
}
