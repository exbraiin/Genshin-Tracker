import 'package:dartx/dartx.dart';
import 'package:data_editor/db_ext/data_validator.dart';
import 'package:data_editor/db_ext/datafield.dart';
import 'package:data_editor/style/utils.dart';
import 'package:gsdatabase/gsdatabase.dart' hide GsRecipeExt, GsSpincrystalExt;

abstract class GsModelExt<T extends GsModel<T>> {
  static final kPermanentDate = DateTime(2199, 12, 31);
  const GsModelExt();

  List<DataField<T>> getFields(String? editId);

  GsValidLevel vdContains<E>(E value, Iterable<E> values) {
    return values.contains(value) ? GsValidLevel.good : GsValidLevel.warn3;
  }

  GsValidLevel vdPermanentDate(DateTime date) {
    return date.isAtSameDayAs(kPermanentDate)
        ? GsValidLevel.good
        : GsValidLevel.warn2;
  }

  GsValidLevel vdDateInterval(DateTime start, DateTime end) {
    return !end.isBefore(start) ? GsValidLevel.good : GsValidLevel.warn2;
  }
}

String expectedId(GsModel item) {
  String bannerId(GsBanner item) {
    final date = item.dateStart.toString().split(' ').firstOrNull ?? '';
    return '${item.name}_${date.replaceAll('-', '_')}'.toDbId();
  }

  return switch (item) {
    final GsVersion item => item.id,
    final GsBanner item => bannerId(item),
    final GsEvent item => '${item.name}_${item.version}'.toDbId(),
    final GsAchievement item => '${item.group}_${item.name}'.toDbId(),
    final GsSpincrystal item => item.number.toString(),
    final GsThespianTrick item => '${item.name}_${item.character}'.toDbId(),
    _ => (((item as dynamic)?.name as String?) ?? '').toDbId(),
  };
}
