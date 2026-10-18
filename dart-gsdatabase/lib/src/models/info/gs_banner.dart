import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_banner_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_banner.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsBanner({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final String image = '',
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime dateStart,
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime dateEnd,
  @JsonKey(unknownEnumValue: GeBannerType.standard)
  final GeBannerType type = GeBannerType.standard,
  final int subtype = 0,
  final List<String> feature4 = const [],
  final List<String> feature5 = const [],
}) extends GsModel<GsBanner> with GsVersionable {
  static const kTableKey = 'banners';

  factory GsBanner.fromJson(JsonMap json) => _$GsBannerFromJson(json);

  @override
  JsonMap toJson() => _$GsBannerToJson(this);

  @override
  Iterable<Comparable Function(GsBanner e)> get sorters => [
    (e) => e.type.index,
    (e) => e.dateStart,
    (e) => e.subtype,
  ];
}
