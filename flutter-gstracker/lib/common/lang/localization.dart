import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final class AppLocalization {
  static AppLocalization of(BuildContext context) {
    final service = Localizations.of<AppLocalization>(context, AppLocalization);
    assert(
      service != null,
      'Make sure to add the [AppLocalization.createDelegate] to the MaterialApp!',
    );
    return service!;
  }

  static _AppLocalizationDelegate? _delegate;
  static LocalizationsDelegate<AppLocalization> createDelegate({
    required Map<Locale, String> assets,
  }) {
    return _delegate ??= _AppLocalizationDelegate(assets);
  }

  final Map<String, String> _map;
  AppLocalization(this._map);

  String valueOf(String key, {int? howMany, Map<String, dynamic>? params}) {
    var value =
        howMany != null
            ? Intl.plural(
              howMany,
              zero: _map['$key.zero'],
              one: _map['$key.one'],
              two: _map['$key.two'],
              few: _map['$key.few'],
              many: _map['$key.many'],
              other: _map[key] ?? '',
            )
            : _map[key] ?? '';
    params?.forEach((k, v) => value = value.replaceAll('{$k}', '$v'));
    return value;
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Map<Locale, String> assets;
  _AppLocalizationDelegate(this.assets);

  @override
  Future<AppLocalization> load(Locale locale) async {
    final asset = assets[locale] ?? assets.values.first;
    final data = await rootBundle.loadString(asset);
    final map = (jsonDecode(data) as Map).cast<String, String>();
    return AppLocalization(map);
  }

  @override
  bool isSupported(Locale locale) {
    return true;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }
}
