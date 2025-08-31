import 'package:gsdatabase/gsdatabase.dart' show GiSereniteaSet;
import 'package:tracker/domain/utils/gs_collections.dart';

final class GuSereniteaSets {
  final GuCollections _items;
  const GuSereniteaSets(this._items);

  int get owned {
    final info = _items.inSereniteaSet;
    final save = _items.svSereniteaSet;
    return info.items.expand((e) {
      final saved = save.getItem(e.id);
      return e.chars.where((c) => saved?.chars.contains(c) ?? false);
    }).length;
  }

  int get total {
    final info = _items.inSereniteaSet;
    final hasChar = _items.hasCaracter;
    return info.items.expand((e) => e.chars.where(hasChar)).length;
  }

  bool isObtainable(String set) {
    final item = _items.inSereniteaSet.getItem(set);
    if (item == null) return false;
    final saved = _items.svSereniteaSet.getItem(set);
    final chars = saved?.chars ?? [];
    final hasChar = _items.hasCaracter;
    return item.chars.any((c) => !chars.contains(c) && hasChar(c));
  }

  /// Sets the serenitea character as obtained or not.
  ///
  /// {@macro db_update}
  void setSetCharacter(String set, String char, {required bool owned}) {
    late final item = GiSereniteaSet(id: set, chars: []);
    final sv = _items.svSereniteaSet.getItem(set) ?? item;
    final hasCharacter = sv.chars.contains(char);
    if (owned && !hasCharacter) {
      sv.chars.add(char);
    } else if (!owned && hasCharacter) {
      sv.chars.remove(char);
    }
    _items.svSereniteaSet.setItem(sv);
  }
}
