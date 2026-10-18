import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_event_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_event.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsEvent({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  @JsonKey(unknownEnumValue: GeEventType.none)
  final GeEventType type = GeEventType.none,
  final String image = '',
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime dateStart,
  @JsonKey(fromJson: modelDateFromJson, toJson: modelDateToJson)
  required final DateTime dateEnd,
  final String rewardsOther = '',
  final List<String> rewardsWeapons = const [],
  final List<String> rewardsCharacters = const [],
}) extends GsModel<GsEvent> with GsVersionable {
  static const kTableKey = 'events';

  factory GsEvent.fromJson(JsonMap json) => _$GsEventFromJson(json);

  @override
  JsonMap toJson() => _$GsEventToJson(this);

  @override
  Iterable<Comparable Function(GsEvent e)> get sorters => [
    (e) => e.version,
    (e) => e.dateStart,
    (e) => e.type.index,
  ];
}
