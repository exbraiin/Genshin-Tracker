import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/gs_collections.dart';

final class GuVersions {
  final GuCollections _items;
  const GuVersions(this._items);

  bool isCurrentVersion(String version) {
    final now = DateTime.now();
    final current = _items.inVersions.items.sorted().lastOrNullWhere(
      (element) => !element.releaseDate.isAfter(now),
    );
    return current?.id == version;
  }

  bool isUpcomingVersion(String version) {
    final now = DateTime.now();
    final upcoming = _items.inVersions.items.sorted().where(
      (version) => version.releaseDate.isAfter(now),
    );
    return upcoming.any((element) => element.id == version);
  }

  GsVersion? getCurrentVersion() {
    final now = DateTime.now();
    final current = _items.inVersions.items.sorted().lastOrNullWhere(
      (version) => !version.releaseDate.isAfter(now),
    );
    return current;
  }

  String getName(String version) {
    return _items.inVersions.getItem(version)?.version ?? version;
  }
}
