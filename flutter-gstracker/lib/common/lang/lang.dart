import 'package:flutter/material.dart';
import 'package:tracker/common/lang/localization.dart';
import 'package:tracker/common/lang/localization.g.dart';

LocalizationMethods? _methods;

extension AppLocalizationExt on BuildContext {
  LocalizationMethods get labels {
    late final provider = AppLocalization.of(this).valueOf;
    return _methods ??= LocalizationMethods(provider);
  }
}
