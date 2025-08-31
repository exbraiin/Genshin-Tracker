import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

final class GuEnvisagedEcho {
  final GuCollections _items;
  const GuEnvisagedEcho(this._items);

  int get owned {
    return _items.inEnvisagedEcho.items.count(
      (e) => _items.svEnvisagedEcho.exists(e.id),
    );
  }

  int get total {
    return _items.inEnvisagedEcho.length;
  }

  /// Whether the item exists or not.
  bool hasItem(String id) {
    return _items.svEnvisagedEcho.exists(id);
  }

  /// Updates the echo as [own].
  ///
  /// {@macro db_update}
  void update(String id, {required bool own}) {
    if (own) {
      _items.svEnvisagedEcho.setItem(GiEnvisagedEcho(id: id));
    } else {
      _items.svEnvisagedEcho.removeItem(id);
    }
  }
}
