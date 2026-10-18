import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_battlepass.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsBattlepass({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final String image = '',
  final String namecardId = '',
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime dateStart,
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime dateEnd,
}) extends GsModel<GsBattlepass> with GsVersionable {
  static const kTableKey = 'battlepass';

  factory GsBattlepass.fromJson(JsonMap json) => _$GsBattlepassFromJson(json);

  @override
  JsonMap toJson() => _$GsBattlepassToJson(this);

  @override
  Iterable<Comparable Function(GsBattlepass e)> get sorters => [
    (e) => e.dateStart,
  ];
}
