import 'package:flutter/foundation.dart';

abstract final class Monitor {
  static void debug(Object? object) => _log('🟢', object);
  static void error(Object? object) => _log('🔴', object);

  static void _log(String emote, Object? object) {
    if (kDebugMode) {
      print('$emote $object');
    }
  }
}
