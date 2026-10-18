import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_region_type.dart';
import 'package:gsdatabase/src/enums/ge_serenitea_set_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_furniture_chest.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsFurnitureChest({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  @JsonKey(unknownEnumValue: GeSereniteaSetType.none)
  final GeSereniteaSetType type = GeSereniteaSetType.none,
  final String image = '',
  final int rarity = 0,
  final int energy = 0,
  @JsonKey(unknownEnumValue: GeRegionType.none)
  final GeRegionType region = GeRegionType.none,
}) extends GsModel<GsFurnitureChest> with GsVersionable {
  static const kTableKey = 'remarkable_chests';

  factory GsFurnitureChest.fromJson(JsonMap json) =>
      _$GsFurnitureChestFromJson(json);

  @override
  JsonMap toMap() => _$GsFurnitureChestToJson(this);

  @override
  Iterable<Comparable Function(GsFurnitureChest e)> get sorters => [
    (e) => e.region.index,
    (e) => e.rarity,
  ];
}
