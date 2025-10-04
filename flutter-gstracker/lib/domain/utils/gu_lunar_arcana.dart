import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/gs_collections.dart';

class GuLunarArcana {
  final GuCollections _items;
  const GuLunarArcana(this._items);

  int get owned {
    return _items.inLunarArcana.items.count(
      (e) => _items.svLunarArcana.exists(e.id),
    );
  }

  int get total {
    return _items.inLunarArcana.length;
  }

  /// Updates the lunar arcana as owned or not.
  ///
  /// {@macro db_update}
  void update(String id, {required bool obtained}) {
    if (obtained) {
      final item = GiLunarArcana(id: id);
      _items.svLunarArcana.setItem(item);
    } else {
      _items.svLunarArcana.removeItem(id);
    }
  }
}
