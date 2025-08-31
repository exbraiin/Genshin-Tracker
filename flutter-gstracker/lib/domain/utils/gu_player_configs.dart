import 'package:gsdatabase/gsdatabase.dart' show GiPlayerInfo;
import 'package:tracker/domain/utils/gs_collections.dart';

final class GuPlayerConfigs {
  final GuCollections _items;
  const GuPlayerConfigs(this._items);

  final _kPlayerInfo = 'player_info';

  GiPlayerInfo? getPlayerInfo() {
    return _items.svPlayerInfo.getItem(_kPlayerInfo);
  }

  void deletePlayerInfo() {
    _items.svPlayerInfo.removeItem(_kPlayerInfo);
  }

  void update(GiPlayerInfo info) {
    final item = info.copyWith(id: _kPlayerInfo);
    _items.svPlayerInfo.setItem(item);
  }
}
