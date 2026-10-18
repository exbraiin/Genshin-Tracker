import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_lunar_arcana.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsLunarArcana({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final int number = 0,
  final String image = '',
  final String description = '',
}) extends GsModel<GsLunarArcana> with GsVersionable {
  static const kTableKey = 'lunar_arcana';

  factory GsLunarArcana.fromJson(JsonMap json) => _$GsLunarArcanaFromJson(json);

  @override
  JsonMap toMap() => _$GsLunarArcanaToJson(this);

  @override
  Iterable<Comparable Function(GsLunarArcana a)> get sorters => [
    (e) => e.number,
    (e) => e.version,
    (e) => e.name,
  ];
}
