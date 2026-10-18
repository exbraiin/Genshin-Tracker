import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_thespian_trick.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsThespianTrick({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final int rarity = 0,
  final int season = 0,
  final String character = '',
  final String image = '',
}) extends GsModel<GsThespianTrick> with GsVersionable {
  static const kTableKey = 'thespian';

  factory GsThespianTrick.fromJson(JsonMap json) =>
      _$GsThespianTrickFromJson(json);

  @override
  JsonMap toJson() => _$GsThespianTrickToJson(this);

  @override
  Iterable<Comparable Function(GsThespianTrick a)> get sorters => [
    (e) => e.season,
  ];
}
