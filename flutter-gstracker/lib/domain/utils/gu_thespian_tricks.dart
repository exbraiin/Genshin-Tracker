import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

final class GuThespianTricks {
  final GuCollections _items;
  GuThespianTricks(this._items);

  int get owned {
    return _items.inThespianTricks.items.count(
      (e) => _items.svThespianTricks.exists(e.id),
    );
  }

  int get total {
    return _items.inThespianTricks.length;
  }

  /// Updates the thespian trick as owned or not.
  ///
  /// {@macro db_update}
  void update(String id, {required bool obtained}) {
    if (obtained) {
      final trick = GiThespianTrick(id: id);
      _items.svThespianTricks.setItem(trick);
    } else {
      _items.svThespianTricks.removeItem(id);
    }
  }
}
