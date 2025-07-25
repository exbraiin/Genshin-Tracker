import 'dart:convert';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:data_editor/db/database.dart';
import 'package:data_editor/db/model_ext.dart';
import 'package:data_editor/db_ext/data_validator.dart';
import 'package:data_editor/style/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart' as html;

typedef JsonMap = Map<String, dynamic>;

class Changes {
  final int achRmv, achMdf, achAdd;
  final int grpRmv, grpMdf, grpAdd;

  Changes(
    this.achRmv,
    this.achMdf,
    this.achAdd,
    this.grpRmv,
    this.grpMdf,
    this.grpAdd,
  );

  factory Changes.fromData(
    Iterable<GsAchievementGroup> oldGrps,
    Iterable<GsAchievementGroup> newGrps,
    Iterable<GsAchievement> oldAchs,
    Iterable<GsAchievement> newAchs,
  ) {
    final achRmv = oldAchs.count((a) => !newAchs.any((b) => b.id == a.id));
    final achAdd = newAchs.count((a) => !oldAchs.any((b) => b.id == a.id));
    final achMdf = newAchs.count((a) {
      final b = oldAchs.firstOrNullWhere((b) => b.id == a.id);
      return b != null && !a.equalsTo(b);
    });

    final grpRmv = oldGrps.count((a) => !newGrps.any((b) => b.id == a.id));
    final grpAdd = newGrps.count((a) => !oldGrps.any((b) => b.id == a.id));
    final grpMdf = newGrps.count((a) {
      final b = oldGrps.firstOrNullWhere((b) => b.id == a.id);
      return b != null && !a.equalsTo(b);
    });

    return Changes(achRmv, achMdf, achAdd, grpRmv, grpMdf, grpAdd);
  }
}

abstract final class PaimonMoeImporter {
  static Future<Changes?> importAchievements() async {
    const url =
        'https://raw.githubusercontent.com/MadeBaruna/'
        'paimon-moe/main/src/data/achievement/en.json';
    final responseJson = await _getUrl(url);
    final data = jsonDecode(responseJson) as Map;

    Map<String, dynamic> parseAchievement(
      String groupName,
      List<Map<String, dynamic>> list,
    ) {
      final first = list.first;
      final name = first['name'] as String? ?? '';
      return {
        'id': '$groupName $name'.toDbId(),
        'name': name,
        'type': first.containsKey('commissions') ? 'commission' : '',
        'group': groupName.toDbId(),
        'hidden': first['hidden'],
        'version': first['ver'] as String? ?? '1.0',
        'phases':
            list
                .map((e) => {'desc': e['desc'], 'reward': e['reward']})
                .toList(),
      };
    }

    final grps = <Map<String, dynamic>>[];
    final achs = <Map<String, dynamic>>[];
    for (final group in data.values.cast<Map>()) {
      final groupOrder = group['order'] as int? ?? 0;
      final groupName = group['name'] as String? ?? '';

      grps.add({
        'id': groupName.toDbId(),
        'name': groupName,
        'order': groupOrder,
      });

      achs.addAll(
        (group['achievements'] as List? ?? []).map(
          (ach) =>
              ach is List
                  ? parseAchievement(
                    groupName,
                    ach.cast<Map<String, dynamic>>(),
                  )
                  : parseAchievement(groupName, [ach]),
        ),
      );
    }

    final inDbAchs = Database.i.of<GsAchievement>().items.toList();
    final inDbGrps = Database.i.of<GsAchievementGroup>().items.toList();

    const minReward = 5;
    final impAchs = achs.map(GsAchievement.fromJson).toList();
    final toRemove = impAchs.where((e) => e.reward < minReward).toList();
    impAchs.removeWhere((e) => e.reward < minReward);

    Database.i.of<GsAchievement>()
      ..deleteAll(toRemove.map((e) => e.id))
      ..updateAll(impAchs);

    final tmpGrps = grps.map(GsAchievementGroup.fromJson).toList();
    final impGrps = await compute(
      (tuple) => tuple.grps.map((e) {
        final exist = tuple.dbGrps.firstOrNullWhere((t) => t.id == e.id);
        final items = tuple.dbAchs.where((t) => t.group == e.id);
        return e.copyWith(
          icon: exist?.icon,
          namecard: exist?.namecard,
          version: items.minBy((t) => t.version)?.version,
          rewards: items.sumBy((t) => t.reward),
          achievements: items.sumBy((t) => t.phases.length),
        );
      }),
      (grps: tmpGrps, dbGrps: inDbGrps, dbAchs: inDbAchs),
    );
    Database.i.of<GsAchievementGroup>().updateAll(impGrps);

    await DataValidator.i.checkAll();
    Database.i.modified.add(null);

    return Changes.fromData(inDbGrps, impGrps, inDbAchs, impAchs);
  }
}

abstract final class FandomImporter {
  static Future<GsCharacter> importCharacter(GsCharacter item) async {
    final document = await _downloadDocument();

    const nameSel = 'h2[data-source="name"]';
    final name = document.querySelector(nameSel)?.text;
    final id = name?.toDbId();

    const titleSel = 'h2[data-item-name="secondary_title"]';
    final title = document.querySelector(titleSel)?.text;

    const regionSel = 'div[data-source="region"] a';
    final region = document.querySelector(regionSel)?.text;

    const raritySel = 'td[data-source="quality"] img';
    final rarity = document.querySelector(raritySel)?.attributes['title'] ?? '';
    final rarityInt = int.tryParse(rarity.split(' ').first);

    const weaponSel = 'td[data-source="weapon"] a';
    final weapon = document.querySelector(weaponSel)?.attributes['title'];

    const elementSel = 'td[data-source="element"] a:nth-child(2)';
    final element = document.querySelector(elementSel)?.text ?? '';

    const affiliationSel = 'div[data-source="affiliation"] div';
    final affiliation = document.querySelector(affiliationSel)?.text;

    const constellationSel = 'div[data-source="constellation"] div a';
    final constellation =
        document.querySelector(constellationSel)?.attributes['title'];

    const foodSel = 'div[data-source="dish"] .item_text';
    final food = document.querySelector(foodSel)?.text;

    const bdaySel = 'div[data-source="birthday"] div';
    final bday = document.querySelector(bdaySel)?.text;

    const wishSel = 'a[title="Wish"] img';
    var wish = document.querySelector(wishSel)?.attributes['src'];
    wish = wish != null ? _processImage(wish) : null;

    const releaseSel = 'div[data-source="releaseDate"] div';
    final release = document.querySelector(releaseSel)?.text;

    DateTime parseDate(String value) {
      const months = [
        ...['january', 'february', 'march', 'april', 'may', 'june'],
        ...['july', 'august', 'september', 'october', 'november', 'december'],
      ];

      final values = value.split(' ');
      var month = values.elementAtOrNull(0)?.toLowerCase();
      month = month != null ? '${months.indexOf(month) + 1}' : '01';
      month = month.padLeft(2, '0');
      var day = values.elementAtOrNull(1);
      day = day?.characters.takeWhile((e) => e.isInt).join() ?? '01';
      day = day.padLeft(2, '0');
      var year = values.elementAtOrNull(2);
      year = year?.characters.takeWhile((e) => e.isInt).take(4).join();
      year = year?.padLeft(4, '0') ?? '0000';

      return DateTime.tryParse('$year-$month-$day') ?? DateTime(0);
    }

    return item.copyWith(
      id: id,
      name: name,
      rarity: rarityInt,
      title: title,
      region: GeRegionType.values.fromId(region?.toDbId()),
      weapon: GeWeaponType.values.fromId(weapon?.toDbId()),
      element: GeElementType.values.fromId(element.toDbId()),
      releaseDate: release != null ? parseDate(release) : null,
      constellation: constellation,
      affiliation: affiliation,
      specialDish: food?.toDbId(),
      birthday: bday != null ? parseDate(bday) : null,
      fullImage: wish,
    );
  }

  static Future<GsSereniteaSet> importSereniteaSet(GsSereniteaSet item) async {
    final document = await _downloadDocument();

    const nameSel = 'h2[data-source="title"]';
    final name = document.querySelector(nameSel)?.text;
    final id = name?.toDbId();

    const imageSel = 'figure[data-source="image"] img';
    final image = document.querySelector(imageSel)?.attributes['src'] ?? '';

    const raritySel = 'div[data-source="quality"] img';
    final rarity = document.querySelector(raritySel)?.attributes['title'] ?? '';
    final rarityInt = int.tryParse(rarity.split(' ').first);

    const energySel = 'div[data-source="adeptal_energy"]';
    final energy = document.querySelector(energySel)?.text ?? '';
    final energyInt = int.tryParse(energy) ?? 0;

    return item.copyWith(
      id: id,
      name: name,
      image: _processImage(image),
      rarity: rarityInt,
      energy: energyInt,
    );
  }

  static Future<GsThespianTrick> importThespianTrick(
    GsThespianTrick item,
  ) async {
    final document = await _downloadDocument();

    final name = document.querySelector('h2.pi-title')?.text ?? '';

    final characterName =
        document
            .querySelector('section.pi-group span.character')
            ?.text
            .trim() ??
        '';
    final character = characterName.toDbId();

    final seasonEl = document
        .querySelectorAll('section.pi-group > div')
        .firstOrNullWhere((e) => e.attributes['data-source'] == 'date');
    final seasonText = seasonEl?.querySelectorAll('a').firstOrNull?.text ?? '';
    final season =
        seasonText
            .split(' ')
            .map((e) => int.tryParse(e))
            .whereNotNull()
            .firstOrNull ??
        0;

    final thumb = document.querySelector('img.pi-image-thumbnail');
    final thumbSrc = thumb?.attributes['src'] ?? '';

    final versionEl = document.querySelector('div.change-history-header > div');
    final version =
        versionEl?.text
            .split(' ')
            .skipWhile((e) => e.toLowerCase() != 'version')
            .skip(1)
            .firstOrNull;

    return item.copyWith(
      id: '${name}_$character'.toDbId(),
      name: name,
      character: character,
      rarity: 4,
      season: season,
      image: _processImage(thumbSrc),
      version: version,
    );
  }

  static Future<html.Document> _downloadDocument({
    String? url,
    bool useFile = kDebugMode,
  }) async {
    const format = Clipboard.kTextPlain;
    url ??= (await Clipboard.getData(format))?.text ?? '';

    late final String raw;
    if (useFile) {
      final file = File('temp.html');
      if (!await file.exists()) {
        raw = await _getUrl(url);
        await file.writeAsString(raw);
      } else {
        raw = await file.readAsString();
      }
    } else {
      raw = await _getUrl(url);
    }
    return html.parse(raw);
  }
}

final _cache = <String, String>{};
Future<String> _getUrl(String url) async {
  if (_cache.containsKey(url)) return _cache[url]!;
  final client = HttpClient();
  return client
      .getUrl(Uri.parse(url))
      .then((e) => e.close())
      .then((e) async => _cache[url] = await e.transform(utf8.decoder).join())
      .whenComplete(() => client.close());
}

String _processImage(String value) {
  final idx = value.indexOf('/revision');
  if (idx != -1) return value.substring(0, idx);
  return value;
}
