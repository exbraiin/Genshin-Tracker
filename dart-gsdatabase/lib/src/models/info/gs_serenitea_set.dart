import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_serenitea_set_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_serenitea_set.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsSereniteaSet({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  @JsonKey(unknownEnumValue: GeSereniteaSetType.none)
  final GeSereniteaSetType category = GeSereniteaSetType.none,
  final String image = '',
  final int rarity = 0,
  final int energy = 0,
  final List<String> chars = const [],
}) extends GsModel<GsSereniteaSet> with GsVersionable {
  static const kTableKey = 'serenitea_sets';

  factory GsSereniteaSet.fromJson(JsonMap json) =>
      _$GsSereniteaSetFromJson(json);

  @override
  JsonMap toMap() => _$GsSereniteaSetToJson(this);

  @override
  Iterable<Comparable Function(GsSereniteaSet e)> get sorters => [
    (e) => e.category.index,
    (e) => e.version,
  ];
}
