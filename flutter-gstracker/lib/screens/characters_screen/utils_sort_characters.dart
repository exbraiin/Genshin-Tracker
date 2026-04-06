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
        .thenByOrder((c) => c.lowestTalent, asc)
        .thenBy((c) => c.item.releaseDate)
        .thenBy((c) => c.item.id);
    return MapEntry(entry.key, list);
  }).toMap();
}

List<({GsMaterial material, int amount})> getCharactersMissingMaterials({
  List<CharInfo>? infos,
  int maxTalent = CharTalents.kCrownless,
}) {
  late final chars = GsUtils.characters;
  late final iChar = Database.instance.infoOf<GsCharacter>();
  late final fallback = iChar.items
      .map((e) => chars.getCharInfo(e.id))
      .whereNotNull();

  final missing = GsUtils.materials.getCharTalentsMissing;
  final versions = Database.instance.infoOf<GsVersion>();
  DateTime versionRelease(String version) {
    return versions.getItem(version)?.releaseDate ?? DateTime(0);
  }

  return (infos ?? fallback)
      .where((e) => e.talents?.isMissing(crownless: true) ?? false)
      .map((e) => missing(e.item, e.info, CharTalents.kCrownless))
      .expand((e) => e.entries)
      .groupBy((e) => e.key.id)
      .map((k, v) {
        final sum = v.sumBy((e) => e.value);
        return MapEntry(v.first.key, sum);
      })
      .entries
      .map((e) => (material: e.key, amount: e.value))
      .sortedByDescending((e) => e.material.group.index)
      .thenByDescending((e) => e.material.rarity)
      .thenBy((e) => e.material.region.index)
      .thenBy((e) => versionRelease(e.material.version))
      .toList();
}

bool isLimitedDays() {
  // TODO: Check if it is after release or after the banner...
  final releaseDate = GsUtils.versions.getCurrentVersion()?.releaseDate;
  final endOfLimited = releaseDate?.add(Duration(days: DateTime.daysPerWeek));
  return endOfLimited != null && DateTime.now().date.isBefore(endOfLimited);
}

extension<E> on SortedList<E> {
  SortedList<E> thenByOrder(Comparable Function(E element) selector, bool asc) {
    return asc ? thenBy(selector) : thenByDescending(selector);
  }
}
