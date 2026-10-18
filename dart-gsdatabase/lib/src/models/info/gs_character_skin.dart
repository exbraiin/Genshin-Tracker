import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_character_skin.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsCharacterSkin({
  @override final String id = '',
  @override final String version = '',
  final int rarity = 0,
  final String name = '',
  final String image = '',
  final String character = '',
  final String sideImage = '',
  final String fullImage = '',
}) extends GsModel<GsCharacterSkin> with GsVersionable {
  static const kTableKey = 'characters_outfits';

  factory GsCharacterSkin.fromJson(JsonMap json) =>
      _$GsCharacterSkinFromJson(json);

  @override
  JsonMap toJson() => _$GsCharacterSkinToJson(this);
}
