import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

final class GuFurnitureChest {
  final GuCollections _items;
  const GuFurnitureChest(this._items);

  int get owned {
    return _items.inFurnitureChests.items.count(
      (e) => _items.svFurnitureChests.exists(e.id),
    );
  }

  int get total {
    return _items.inFurnitureChests.length;
  }

  /// Updates the remarkable chest as obtained or not.
  ///
  /// {@macro db_update}
  void update(String id, {required bool obtained}) {
    if (obtained) {
      final item = GiFurnitureChest(id: id);
      _items.svFurnitureChests.setItem(item);
    } else {
      _items.svFurnitureChests.removeItem(id);
    }
  }
}
