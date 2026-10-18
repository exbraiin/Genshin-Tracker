import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_namecard_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_namecard.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsNamecard({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  final int rarity = 0,
  @JsonKey(unknownEnumValue: GeNamecardType.none)
  final GeNamecardType type = GeNamecardType.none,
  final String image = '',
  final String fullImage = '',
  final String desc = '',
}) extends GsModel<GsNamecard> with GsVersionable {
  static const kTableKey = 'namecards';

  factory GsNamecard.fromJson(JsonMap json) => _$GsNamecardFromJson(json);

  @override
  JsonMap toJson() => _$GsNamecardToJson(this);

  @override
  Iterable<Comparable Function(GsNamecard e)> get sorters => [
    (e) => e.type.index,
    (e) => e.version,
  ];
}
