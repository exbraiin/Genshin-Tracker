import 'package:dartx/dartx.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/src/iterable_ext.dart';
import 'package:tracker/domain/gs_database.dart';

typedef DaysGroup = ({GeWeekdayType day1, GeWeekdayType day2});
typedef DaysMap = Map<DaysGroup, List<CharInfo>>;

DaysMap groupCharactersByDays([List<CharInfo>? infos]) {
  late final chars = GsUtils.characters;
  late final iMats = Database.instance.infoOf<GsMaterial>();
  late final iChar = Database.instance.infoOf<GsCharacter>();
  late final fallback = iChar.items
      .map((e) => chars.getCharInfo(e.id))
      .whereNotNull();

  final farmableDays = [
    (day1: GeWeekdayType.monday, day2: GeWeekdayType.thursday),
    (day1: GeWeekdayType.tuesday, day2: GeWeekdayType.friday),
    (day1: GeWeekdayType.wednesday, day2: GeWeekdayType.saturday),
  ];
  final grouped = (infos ?? fallback)
      .where((e) => e.talents?.isMissing(crownless: true) ?? false)
      .groupBy((e) {
        final weekdays = iMats.getItem(e.item.talentMaterial)?.weekdays ?? [];
        return farmableDays.firstOrNullWhere((e) => weekdays.contains(e.day1));
      })
      .entries
      .where((entry) => entry.key != null)
      .map((e) => MapEntry(e.key!, e.value))
      .toMap();

  grouped.addEntries(
    farmableDays
        .where((e) => !grouped.containsKey(e))
        .map((e) => MapEntry(e, <CharInfo>[])),
  );

  return grouped;
}

DaysMap sortCharactersByDays(DaysMap map, {bool asc = false}) {
  return map.entries.map((entry) {
    final list = entry.value
        .sortedByDescending((e) => e.item.rarity)
        .thenByOrder((e) => e.lowestTalent, asc)
        .thenBy((c) => c.item.releaseDate)
        .thenBy((c) => c.item.id);
    return MapEntry(entry.key, list);
  }).toMap();
}

extension<E> on SortedList<E> {
  SortedList<E> thenByOrder(Comparable Function(E element) selector, bool asc) {
    return asc ? thenBy(selector) : thenByDescending(selector);
  }
}
