import 'package:flutter/material.dart';

extension IterableWidgetExt on Iterable<Widget> {
  Iterable<Widget> spaced(double space) {
    return separate(SizedBox(width: space, height: space));
  }
}

extension IterableMapEntry<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() => Map.fromEntries(this);
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
}
