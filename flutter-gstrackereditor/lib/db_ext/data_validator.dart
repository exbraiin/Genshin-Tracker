import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:data_editor/configs.dart';
import 'package:data_editor/db/database.dart';
import 'package:data_editor/db_ext/datafield.dart';
import 'package:data_editor/db_ext/image_file_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';

export 'src/gs_achievement_ext.dart';
export 'src/gs_achievement_group_ext.dart';
export 'src/gs_artifact_ext.dart';
export 'src/gs_banner_ext.dart';
export 'src/gs_battlepass_ext.dart';
export 'src/gs_character_ext.dart';
export 'src/gs_character_outfit_ext.dart';
export 'src/gs_envisaged_echo_ext.dart';
export 'src/gs_event_ext.dart';
export 'src/gs_lunar_arcana_ext.dart';
export 'src/gs_material_ext.dart';
export 'src/gs_namecard_ext.dart';
export 'src/gs_recipe_ext.dart';
export 'src/gs_remarkable_chest_ext.dart';
export 'src/gs_serenitea_ext.dart';
export 'src/gs_spincrystal_ext.dart';
export 'src/gs_thespian_trick_ext.dart';
export 'src/gs_version_ext.dart';
export 'src/gs_weapon_ext.dart';

// The validator level.
enum GsValidLevel {
  none,
  good,
  warn1(color: Colors.lightBlue),
  warn2(color: Colors.orange, label: 'Missing'),
  warn3(color: Colors.deepOrange, label: 'Wrong'),
  error(color: Colors.red, label: 'Invalid');

  final Color? color;
  final String? label;

  bool get isInvalid =>
      this == GsValidLevel.warn2 ||
      this == GsValidLevel.warn3 ||
      this == GsValidLevel.error;

  const GsValidLevel({this.color, this.label});
}

class DataValidator {
  static final i = DataValidator._();

  final _levels = <Type, Map<String, GsValidLevel>>{};

  final _requests = <Type, Map<String, Object>>{};

  DataValidator._();

  Future<void> checkItems<T extends GsModel<T>>() {
    final models = Database.i.of<T>().items.toList();
    final validator = _GsValidator.of<T>();
    final data = _ComputeData(models, validator, Database.i.imagesDirectory);
    final requests = Map<String, Object>.of(_requests[T] ?? {});
    return compute(_validateModels<T>, data).then((value) {
      final levels = _levels[T] ??= {};
      for (final entry in value.entries) {
        if (_requests[T]?[entry.key] == requests[entry.key]) {
          levels[entry.key] = entry.value;
        }
      }
    });
  }

  Future<void> checkAll() async {
    final configs = GsConfigs.getAllConfigs();
    for (final config in configs) {
      await config.checkItems(this);
    }
  }

  /// Gets the level for the given [id].
  GsValidLevel getLevel<T extends GsModel<T>>(String id) =>
      _levels[T]?[id] ?? GsValidLevel.good;

  /// Gets the max level for this type.
  GsValidLevel getMaxLevel<T extends GsModel<T>>() {
    return _levels[T]?.values.maxBy((e) => e.index) ?? GsValidLevel.good;
  }

  /// Checks the level for the given [id].
  /// * If [model] is null, it is removed from the levels list.
  /// * Otherwise it updates its level value and returns it.
  Future<GsValidLevel> checkLevel<T extends GsModel<T>>(
    String id,
    T? model,
  ) async {
    final request = Object();
    (_requests[T] ??= {})[id] = request;
    if (model == null) {
      _levels[T]?.remove(id);
    } else {
      final validator = _GsValidator.of<T>();
      final level = await validator.validate(model);
      if (_requests[T]?[id] == request) {
        (_levels[T] ??= {})[model.id] = level;
      }
    }
    return getLevel<T>(id);
  }
}

Future<Map<String, GsValidLevel>> _validateModels<T extends GsModel<T>>(
  _ComputeData<T> data,
) async {
  imageValidationInWorker = true;
  initializeImageDatabase(data.imagesDirectory);
  final valid = <String, GsValidLevel>{};
  for (final item in data.models) {
    valid[item.id] = await data.validator.validate(item);
  }
  return valid;
}

class _ComputeData<T extends GsModel<T>> {
  final Iterable<T> models;
  final Directory imagesDirectory;
  final _GsValidator validator;

  _ComputeData(this.models, this.validator, this.imagesDirectory);
}

class _GsValidator<T extends GsModel<T>> {
  final Iterable<DValidator<T>> _validators;

  _GsValidator._(this._validators);

  static _GsValidator<T> of<T extends GsModel<T>>() {
    // We send an empty id so the "validate id" method can reassign the id.
    final fields = GsConfigs.of<T>()?.pageBuilder.getFields('') ?? [];
    return _GsValidator._(fields.map((e) => e.validator));
  }

  Future<GsValidLevel> validate(T item) =>
      maxValidationLevel(_validators.map((validator) => validator(item)));
}

Future<GsValidLevel> maxValidationLevel(
  Iterable<FutureOr<GsValidLevel>> validations, {
  GsValidLevel emptyLevel = GsValidLevel.good,
}) async {
  var level = emptyLevel;
  var hasValue = false;
  for (final validation in validations) {
    final next = await validation;
    if (!hasValue || next.index > level.index) level = next;
    hasValue = true;
  }
  return level;
}

class ValidationBuilder extends StatelessWidget {
  final FutureOr<GsValidLevel> validation;
  final Widget Function(BuildContext, GsValidLevel, bool pending) builder;

  const ValidationBuilder({
    super.key,
    required this.validation,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final result = validation;
    if (result is GsValidLevel) return builder(context, result, false);
    return FutureBuilder<GsValidLevel>(
      future: result,
      builder: (context, snapshot) => builder(
        context,
        snapshot.hasError
            ? GsValidLevel.error
            : snapshot.data ?? GsValidLevel.none,
        snapshot.connectionState != ConnectionState.done,
      ),
    );
  }
}
