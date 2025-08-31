import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/domain/utils/_gu_collections.dart';

final class GuEvents {
  final GuCollections _items;
  const GuEvents(this._items);

  /// Gets the event characters
  List<GsCharacter> getEventCharacters(String id) {
    final list = _items.inEvents.getItem(id)?.rewardsCharacters;
    if (list == null) return const [];
    return list.map(_items.inCharacters.getItem).whereNotNull().toList();
  }

  /// Gets the event weapons
  List<GsWeapon> getEventWeapons(String id) {
    final list = _items.inEvents.getItem(id)?.rewardsWeapons;
    if (list == null) return const [];
    return list.map(_items.inWeapons.getItem).whereNotNull().toList();
  }

  /// Whether the user collected the [eventId] weapon or not.
  bool ownsWeapon(String eventId, String id) {
    return _items.svEventRewards
            .getItem(eventId)
            ?.obtainedWeapons
            .contains(id) ??
        false;
  }

  /// Whether the user collected the [eventId] character or not.
  bool ownsCharacter(String eventId, String id) {
    return _items.svEventRewards
            .getItem(eventId)
            ?.obtainedCharacters
            .contains(id) ??
        false;
  }

  /// Adds or removes the given [id] from the given [eventId].
  ///
  /// {@macro db_update}
  void toggleObtainedtWeapon(String eventId, String id) {
    final saved =
        _items.svEventRewards.getItem(eventId) ??
        GiEventRewards.fromJson({'id': eventId});
    final list = saved.obtainedWeapons.toList();
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    _items.svEventRewards.setItem(saved.copyWith(obtainedWeapons: list));
  }

  /// Adds or removes the given [id] from the given [eventId].
  ///
  /// {@macro db_update}
  void toggleObtainedCharacter(String eventId, String id) {
    final saved =
        _items.svEventRewards.getItem(eventId) ??
        GiEventRewards.fromJson({'id': eventId});
    final list = saved.obtainedCharacters.toList();
    if (list.contains(id)) {
      list.remove(id);
    } else {
      list.add(id);
    }
    _items.svEventRewards.setItem(saved.copyWith(obtainedCharacters: list));
  }
}
