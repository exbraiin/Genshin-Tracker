import 'package:dartx/dartx.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

final class GuWeapons {
  final GuCollections _items;
  const GuWeapons(this._items);

  int obtainedAmount(String id) {
    return _items.svWishes.items.count((e) => e.itemId == id) + eventWeapons(id);
  }

  bool hasWeapon(String id) {
    return _items.svWishes.items.any((e) => e.itemId == id) ||
        _items.svEventRewards.items.any((e) => e.obtainedWeapons.contains(id));
  }

  int eventWeapons(String id) {
    return _items.svEventRewards.items.count((e) => e.obtainedWeapons.contains(id));
  }
}
