import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gsdatabase/src/database_schema.dart';
import 'package:gsdatabase/src/exporter.dart';
import 'package:gsdatabase/src/utils/async.dart';

Iterable<Items> get _infoCollections {
  return [
    Items<GsAchievement>(GsAchievement.kTableKey, GsAchievement.fromJson),
    Items<GsAchievementGroup>(
      GsAchievementGroup.kTableKey,
      GsAchievementGroup.fromJson,
    ),
    Items<GsArtifact>(GsArtifact.kTableKey, GsArtifact.fromJson),
    Items<GsBanner>(GsBanner.kTableKey, GsBanner.fromJson),
    Items<GsBattlepass>(GsBattlepass.kTableKey, GsBattlepass.fromJson),
    Items<GsCharacter>(GsCharacter.kTableKey, GsCharacter.fromJson),
    Items<GsCharacterSkin>(GsCharacterSkin.kTableKey, GsCharacterSkin.fromJson),
    Items<GsEvent>(GsEvent.kTableKey, GsEvent.fromJson),
    Items<GsEnvisagedEcho>(GsEnvisagedEcho.kTableKey, GsEnvisagedEcho.fromJson),
    Items<GsThespianTrick>(GsThespianTrick.kTableKey, GsThespianTrick.fromJson),
    Items<GsMaterial>(GsMaterial.kTableKey, GsMaterial.fromJson),
    Items<GsNamecard>(GsNamecard.kTableKey, GsNamecard.fromJson),
    Items<GsRecipe>(GsRecipe.kTableKey, GsRecipe.fromJson),
    Items<GsFurnitureChest>(
      GsFurnitureChest.kTableKey,
      GsFurnitureChest.fromJson,
    ),
    Items<GsLunarArcana>(GsLunarArcana.kTableKey, GsLunarArcana.fromJson),
    Items<GsSereniteaSet>(GsSereniteaSet.kTableKey, GsSereniteaSet.fromJson),
    Items<GsSpincrystal>(GsSpincrystal.kTableKey, GsSpincrystal.fromJson),
    Items<GsVersion>(GsVersion.kTableKey, GsVersion.fromJson),
    Items<GsWeapon>(GsWeapon.kTableKey, GsWeapon.fromJson),
  ];
}

Iterable<Items> get _saveCollections {
  return [
    Items<GiAccountInfo>(GiAccountInfo.kTableKey, GiAccountInfo.fromJson),
    Items<GiAchievement>(GiAchievement.kTableKey, GiAchievement.fromJson),
    Items<GiWish>(GiWish.kTableKey, GiWish.fromJson),
    Items<GiRecipe>(GiRecipe.kTableKey, GiRecipe.fromJson),
    Items<GiMaterial>(GiMaterial.kTableKey, GiMaterial.fromJson),
    Items<GiEnvisagedEcho>(GiEnvisagedEcho.kTableKey, GiEnvisagedEcho.fromJson),
    Items<GiThespianTrick>(GiThespianTrick.kTableKey, GiThespianTrick.fromJson),
    Items<GiFurnitureChest>(
      GiFurnitureChest.kTableKey,
      GiFurnitureChest.fromJson,
    ),
    Items<GiLunarArcana>(GiLunarArcana.kTableKey, GiLunarArcana.fromJson),
    Items<GiCharacter>(GiCharacter.kTableKey, GiCharacter.fromJson),
    Items<GiSereniteaSet>(GiSereniteaSet.kTableKey, GiSereniteaSet.fromJson),
    Items<GiSpincrystal>(GiSpincrystal.kTableKey, GiSpincrystal.fromJson),
    Items<GiPlayerInfo>(GiPlayerInfo.kTableKey, GiPlayerInfo.fromJson),
    Items<GiFurnishing>(GiFurnishing.kTableKey, GiFurnishing.fromJson),
    Items<GiEventRewards>(GiEventRewards.kTableKey, GiEventRewards.fromJson),
  ];
}

enum OperationType { upsert, delete }

class Operation<T extends GsModel<T>> {
  final T? item;
  final OperationType operation;
  Operation.upsert(this.item) : operation = .upsert;
  Operation.delete(this.item) : operation = .delete;
}

final class GsDatabase {
  static const kSchemaVersion = kCurrentDatabaseSchemaVersion;

  final Iterable<Items> _collections;
  final JsonMap Function(JsonMap) _databaseMigrator;
  late final Stream<Operation<GsModel>> didUpdate =
      mergeStreams<Operation<GsModel>>(
        _collections.map((e) => e.onItemUpdated.cast<Operation<GsModel>>()),
      );

  GsDatabase.info()
    : _collections = _infoCollections,
      _databaseMigrator = infoDatabaseMigrator;
  GsDatabase.save()
    : _collections = _saveCollections,
      _databaseMigrator = saveDatabaseMigrator;

  Items<T> of<T extends GsModel<T>>() =>
      _collections.firstWhere((e) => e is Items<T>) as Items<T>;

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
    final migrated = _databaseMigrator(jsonMap);
    final deferred = _collections
        .map((collection) => collection._load(migrated))
        .toList();
    for (final replace in deferred) {
      replace();
    }
  }

  Future<void> save({required String path, bool encoded = false}) async {
    final file = File(path);
    final map = <String, dynamic>{kSchemaVersionKey: kSchemaVersion};
    for (final collection in _collections) {
      collection._save(map);
    }

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
  final _data = <String, T>{};
  final String collectionId;
  final T Function(JsonMap map) parser;
  final _notifier = StreamController<Operation<T>>.broadcast();
  Stream<Operation<T>> get onItemUpdated => _notifier.stream;

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
    _notifier.add(Operation.upsert(item));
  }

  /// Removes the item with the given id from db.
  void removeItem(String id) {
    final item = _data.remove(id);
    _notifier.add(Operation.delete(item));
  }

  // Parse immediately; defer replacement until every collection has parsed.
  void Function() _load(JsonMap map) {
    final items = (map[collectionId] as JsonMap? ?? {}).map(
      (k, v) => MapEntry(k, parser({...v, 'id': k})),
    );
    return () {
      _data
        ..clear()
        ..addAll(items);
    };
  }

  void _save(JsonMap map) {
    final items = _data.map((k, v) => MapEntry(k, v.toMap()..remove('id')));
    map[collectionId] = items;
  }
}
