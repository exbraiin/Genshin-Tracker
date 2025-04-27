import 'package:flutter/material.dart';

extension IterableWidgetExt on Iterable<Widget> {
  Iterable<Widget> spaced(double space) {
    return separate(SizedBox(width: space, height: space));
  }
}

extension IterableExt<T> on Iterable<T> {
  Iterable<T> separate(T separator) sync* {
    final it = iterator;
    if (!it.moveNext()) return;
    yield it.current;
    while (it.moveNext()) {
      yield separator;
      yield it.current;
    }
  }

  Map<K, V> toMap<K, V>(K Function(T e) key, V Function(T e) value) =>
      Map.fromEntries(map((e) => MapEntry(key(e), value(e))));
}
