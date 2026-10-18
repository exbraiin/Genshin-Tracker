import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_recipe.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiRecipe({@override final String id = '', final int proficiency = 0})
    extends GsModel<GiRecipe> {
  static const kTableKey = 'recipes';

  factory GiRecipe.fromJson(JsonMap json) => _$GiRecipeFromJson(json);

  @override
  JsonMap toMap() => _$GiRecipeToJson(this);
}
