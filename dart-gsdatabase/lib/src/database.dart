import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gsdatabase/src/exporter.dart';
import 'package:gsdatabase/src/models/info/gs_thespian_trick.dart';
import 'package:gsdatabase/src/models/save/gi_thespian_trick.dart';

Iterable<Items> get _infoCollections {
  const kCategories = 'achievement_categories';
  return [
    Items<GsAchievement>('achievements', GsAchievement.fromJson),
    Items<GsAchievementGroup>(kCategories, GsAchievementGroup.fromJson),
    Items<GsArtifact>('artifacts', GsArtifact.fromJson),
    Items<GsBanner>('banners', GsBanner.fromJson),
    Items<GsBattlepass>('battlepass', GsBattlepass.fromJson),
    Items<GsCharacter>('characters', GsCharacter.fromJson),
    Items<GsCharacterSkin>('characters_outfits', GsCharacterSkin.fromJson),
    Items<GsEvent>('events', GsEvent.fromJson),
    Items<GsEnvisagedEcho>('echos', GsEnvisagedEcho.fromJson),
    Items<GsThespianTrick>('thespian', GsThespianTrick.fromJson),
    Items<GsMaterial>('materials', GsMaterial.fromJson),
    Items<GsNamecard>('namecards', GsNamecard.fromJson),
    Items<GsRecipe>('recipes', GsRecipe.fromJson),
    Items<GsFurnitureChest>('remarkable_chests', GsFurnitureChest.fromJson),
    Items<GsSereniteaSet>('serenitea_sets', GsSereniteaSet.fromJson),
    Items<GsSpincrystal>('spincrystals', GsSpincrystal.fromJson),
    Items<GsVersion>('versions', GsVersion.fromJson),
    Items<GsWeapon>('weapons', GsWeapon.fromJson),
  ];
}

Iterable<Items> get _saveCollections {
  return [
    Items<GiAccountInfo>('account', GiAccountInfo.fromJson),
    Items<GiAchievement>('achievements', GiAchievement.fromJson),
    Items<GiWish>('wishes', GiWish.fromJson),
    Items<GiRecipe>('recipes', GiRecipe.fromJson),
    Items<GiEnvisagedEcho>('echoes', GiEnvisagedEcho.fromJson),
    Items<GiThespianTrick>('thespian', GiThespianTrick.fromJson),
    Items<GiFurnitureChest>('remarkable_chests', GiFurnitureChest.fromJson),
    Items<GiCharacter>('characters', GiCharacter.fromJson),
    Items<GiSereniteaSet>('serenitea_sets', GiSereniteaSet.fromJson),
    Items<GiSpincrystal>('spincrystals', GiSpincrystal.fromJson),
    Items<GiPlayerInfo>('user_configs', GiPlayerInfo.fromJson),
    Items<GiFurnishing>('furnishing', GiFurnishing.fromJson),
    Items<GiEventRewards>('event_rewards', GiEventRewards.fromJson),
  ];
}

final class GsDatabase {
  final Iterable<Items> collections;
  final _notifier = StreamController<void>.broadcast();
  Stream<void> get didUpdate => _notifier.stream;

  GsDatabase.info() : collections = _infoCollections;
  GsDatabase.save() : collections = _saveCollections;

  Items<T> of<T extends GsModel<T>>() =>
      collections.firstWhere((e) => e is Items<T>) as Items<T>;

  Future<void> load({required String path, bool encoded = false}) async {
    final file = File(path);
    JsonMap jsonMap = {};
    if (await file.exists()) {
      if (encoded) {
        final bytes = await file.readAsBytes();
        jsonMap = _decodeBytesToJsonMap(bytes);
      } else {
        final string = await file.readAsString();
        jsonMap = jsonDecode(string);
      }
    }
    await Future.value(jsonMap)
        .then((value) => collections.map((e) => e._load(value, this)))
        .then((value) => Future.wait(value));
  }

  Future<void> save({required String path, bool encoded = false}) async {
    final file = File(path);
    final map = <String, dynamic>{};
    await Future.wait(collections.map((e) => e._save(map)));

    if (encoded) {
      final bytes = _encodeJsonMapToBytes(map);
      await file.writeAsBytes(bytes);
    } else {
      final string = jsonEncode(map);
      await file.writeAsString(string);
    }
  }

  List<int> _encodeJsonMapToBytes(JsonMap map) {
    final eJson = jsonEncode(map);
    final eUtf8 = utf8.encode(eJson);
    return gzip.encode(eUtf8);
  }

  JsonMap _decodeBytesToJsonMap(List<int> bytes) {
    final eUtf8 = gzip.decode(bytes);
    final eJson = utf8.decode(eUtf8);
    return jsonDecode(eJson) as JsonMap;
  }
}

final class Items<T extends GsModel<T>> {
  GsDatabase? _db;
  final _data = <String, T>{};
  final String collectionId;
  final T Function(JsonMap map) parser;

  Iterable<String> get ids => _data.keys;
  Iterable<T> get items => _data.values;
  int get length => _data.length;

  Items(this.collectionId, this.parser);

  /// Gets the item with the given id, returns null if it does not exist.
  T? getItem(String id) => _data[id];

  /// Checks if the item with the given id exists.
  bool exists(String id) => _data.containsKey(id);

  /// Replaces the item with the given one based on the id.
  void setItem(T item) {
    _data[item.id] = item;
    _db?._notifier.add(null);
  }

  /// Removes the item with the given id from db.
  void removeItem(String id) {
    _data.remove(id);
    _db?._notifier.add(null);
  }

  /// Edits the item, if the item does not exists a new one is created.
  /// * If the callback returns null, the item is removed.
  void editItem(String id, T? Function(T item) edit) {
    final item = getItem(id) ?? parser({'id': id});
    final edited = edit(item)?.copyWith(id: id);
    return edited != null ? setItem(edited) : removeItem(id);
  }

  Future<void> _load(JsonMap map, GsDatabase db) async {
    _db = db;
    final items = (map[collectionId] as JsonMap? ?? {})
        .map((k, v) => MapEntry(k, parser({'id': k, ...v})));
    _data.addAll(items);
  }

  Future<void> _save(JsonMap map) async {
    final items = _data.map((k, v) => MapEntry(k, v.toMap()..remove('id')));
    map[collectionId] = items;
  }
}
