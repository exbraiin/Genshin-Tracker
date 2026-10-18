import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_character.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiCharacter({
  @override final String id = '',
  final int ascension = 0,
  final int friendship = 1,
  final int talent1 = 1,
  final int talent2 = 1,
  final int talent3 = 1,
}) extends GsModel<GiCharacter> {
  static const kTableKey = 'characters';

  factory GiCharacter.fromJson(JsonMap json) => _$GiCharacterFromJson(json);

  @override
  JsonMap toJson() => _$GiCharacterToJson(this);
}
