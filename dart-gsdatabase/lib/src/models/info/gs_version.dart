import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_version.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsVersion({
  @override final String id = '',
  final String label = '',
  final String name = '',
  final String image = '',
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime releaseDate,
}) extends GsModel<GsVersion> {
  static const kTableKey = 'versions';

  factory GsVersion.fromJson(JsonMap json) => _$GsVersionFromJson(json);

  @override
  JsonMap toMap() => _$GsVersionToJson(this);

  @override
  Iterable<Comparable Function(GsVersion e)> get sorters => [
    (e) => e.releaseDate,
  ];
}
