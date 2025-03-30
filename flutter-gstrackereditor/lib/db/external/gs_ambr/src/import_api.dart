import 'dart:convert';
import 'dart:io';

import 'package:data_editor/db/external/gs_ambr/src/yatta_import_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:http/http.dart' as http;

class ImportItem {
  final int level;
  final String id, name, icon;
  ImportItem(this.id, this.name, this.icon, [this.level = 0]);
}

abstract class ImportApi {
  static final ImportApi i = YattaImporter.i;

  Image get icon;
  String get name;

  Future<GsArtifact> fetchArtifact(String id, [GsArtifact? other]);
  Future<List<ImportItem>> fetchArtifacts();

  Future<GsCharacter> fetchCharacter(String id, [GsCharacter? other]);
  Future<List<ImportItem>> fetchCharacters();

  Future<GsNamecard> fetchNamecard(String id, [GsNamecard? other]);
  Future<List<ImportItem>> fetchNamecards();

  Future<GsRecipe> fetchRecipe(String id, [GsRecipe? other]);
  Future<List<ImportItem>> fetchRecipes();

  Future<GsWeapon> fetchWeapon(String id, [GsWeapon? other]);
  Future<List<ImportItem>> fetchWeapons();

  Future<GsSereniteaSet> fetchSereniteaSet(String id, [GsSereniteaSet? other]);
  Future<List<ImportItem>> fetchSereniteaSets();
}

class ImportCache {
  final String baseUrl;
  final _cache = <String, JsonMap>{};
  final JsonMap Function(JsonMap data)? proccess;

  ImportCache(this.baseUrl, {this.proccess});

  Future<JsonMap> fetchPage(
    String endpoint, {
    bool useCache = true,
  }) async {
    final url = '$baseUrl$endpoint';
    var filename = '.cache$endpoint';
    if (!filename.endsWith('.json')) filename += '.json';
    final file = kDebugMode ? File(filename) : null;

    if (useCache) {
      final data = _cache[endpoint];
      if (data != null) {
        if (kDebugMode) print('Reading from cache!');
        return proccess?.call(data) ?? data;
      }

      if (file != null && await file.exists()) {
        final data = await file.readAsString();
        if (kDebugMode) print('Reading from cache file!');
        return _cache[endpoint] = jsonDecode(data);
      }
    }

    if (kDebugMode) print('Downloading: $url');
    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body) as JsonMap;
    if (useCache) {
      _cache[endpoint] = data;
      if (file != null && !await file.exists()) {
        if (!await file.parent.exists()) {
          await file.parent.create(recursive: true);
        }
        await file.writeAsString(jsonEncode(data));
      }
    }
    return proccess?.call(data) ?? data;
  }
}

abstract final class ImportUtils {
  static int rarityNameToLevel(String name, [int? fallback]) {
    return switch (name) {
      'QUALITY_ORANGE_SP' => 5,
      'QUALITY_ORANGE' => 5,
      'QUALITY_PURPLE' => 4,
      _ => fallback ?? 0,
    };
  }

  static GeElementType elementNameToType(
    String name, [
    GeElementType? fallback,
  ]) {
    return switch (name) {
      'Wind' => GeElementType.anemo,
      'Rock' => GeElementType.geo,
      'Electric' => GeElementType.electro,
      'Grass' => GeElementType.dendro,
      'Water' => GeElementType.hydro,
      'Fire' => GeElementType.pyro,
      'Ice' => GeElementType.cryo,
      _ => fallback ?? GeElementType.anemo,
    };
  }
}

extension JsonMapExt on JsonMap {
  T getOr<T>(String key, T or) {
    final v = this[key];
    if (v == null) return or;
    return this[key] as T;
  }

  int getInt(String key) => getOr(key, 0);
  int? getIntOrNull(String key) => getOr<int?>(key, null);
  String getString(String key) => getOr(key, '');
  String? getStringOrNull(String key) => getOr<String?>(key, null);
  JsonMap getJsonMap(String key) => getOr(key, const {});

  List<T> getList<T>(String key) => getOr<List>(key, const []).cast<T>();
  List<int> getIntList(String key) => getList<int>(key);
  List<JsonMap> getJsonMapList(String key) => getList<JsonMap>(key);
}
