import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_material_type.dart';
import 'package:gsdatabase/src/enums/ge_region_type.dart';
import 'package:gsdatabase/src/enums/ge_weekday_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_material.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsMaterial({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final String desc = '',
  final int rarity = 0,
  @JsonKey(unknownEnumValue: GeMaterialType.none)
  final GeMaterialType group = GeMaterialType.none,
  final String image = '',
  @JsonKey(unknownEnumValue: GeRegionType.none)
  final GeRegionType region = GeRegionType.none,
  final int subgroup = 0,
  final bool ingredient = false,
  @JsonKey(unknownEnumValue: GeWeekdayType.sunday)
  final List<GeWeekdayType> weekdays = const [],
}) extends GsModel<GsMaterial> with GsVersionable {
  static const kTableKey = 'materials';

  factory GsMaterial.fromJson(JsonMap json) => _$GsMaterialFromJson(json);

  @override
  JsonMap toMap() => _$GsMaterialToJson(this);

  @override
  Iterable<Comparable Function(GsMaterial e)> get sorters => [
    (e) => e.group.index,
    (e) => e.region.index,
    (e) => e.subgroup,
    (e) => e.rarity,
    (e) => e.version,
    (e) => e.name,
  ];
}
