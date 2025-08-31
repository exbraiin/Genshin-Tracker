import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

final class GuSpincrystals {
  final GuCollections _items;
  const GuSpincrystals(this._items);

  int get owned {
    return _items.inSpincrystals.items.count(
      (e) => _items.svSpincrystals.exists(e.id),
    );
  }

  int get total {
    return _items.inSpincrystals.length;
  }

  /// Updates the spincrystal as owned or not.
  ///
  /// {@macro db_update}
  void update(int number, {required bool obtained}) {
    final id = number.toString();
    if (obtained) {
      final spin = GiSpincrystal(id: id);
      _items.svSpincrystals.setItem(spin);
    } else {
      _items.svSpincrystals.removeItem(id);
    }
  }
}
