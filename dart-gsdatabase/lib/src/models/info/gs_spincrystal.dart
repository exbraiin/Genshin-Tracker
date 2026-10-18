import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_region_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_spincrystal.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsSpincrystal({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final int number = 0,
  final String source = '',
  final String imageSource = '',
  @JsonKey(unknownEnumValue: GeRegionType.none)
  final GeRegionType region = GeRegionType.none,
}) extends GsModel<GsSpincrystal> with GsVersionable {
  static const kTableKey = 'spincrystals';

  factory GsSpincrystal.fromJson(JsonMap json) => _$GsSpincrystalFromJson(json);

  @override
  JsonMap toMap() => _$GsSpincrystalToJson(this);

  @override
  Iterable<Comparable Function(GsSpincrystal e)> get sorters => [
    (e) => e.number,
  ];
}

extension GsSpincrystalExt on GsSpincrystal {
  bool get fromChubby => source == 'Chubby';
}
