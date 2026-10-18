import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/enums/ge_artifact_piece_type.dart';
import 'package:gsdatabase/src/enums/ge_region_type.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gs_artifact.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsArtifact({
  @override final String id = '',
  @override final String version = '',
  final String name = '',
  @JsonKey(unknownEnumValue: GeRegionType.none)
  final GeRegionType region = GeRegionType.none,
  final int rarity = 0,
  final String pc1 = '',
  final String pc2 = '',
  final String pc4 = '',
  final String domain = '',
  final List<GsArtifactPiece> pieces = const [],
}) extends GsModel<GsArtifact> with GsVersionable {
  static const kTableKey = 'artifacts';

  factory GsArtifact.fromJson(JsonMap json) => _$GsArtifactFromJson(json);

  @override
  JsonMap toMap() => _$GsArtifactToJson(this);

  @override
  Iterable<Comparable Function(GsArtifact e)> get sorters => [
    (e) => e.region.index,
    (e) => e.rarity,
    (e) => e.version,
  ];
}

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GsArtifactPiece({
  @override final String id = '',
  final String name = '',
  final String icon = '',
  final String desc = '',
  @JsonKey(unknownEnumValue: GeArtifactPieceType.flowerOfLife)
  final GeArtifactPieceType type = GeArtifactPieceType.flowerOfLife,
}) extends GsModel<GsArtifactPiece> {
  factory GsArtifactPiece.fromJson(JsonMap json) =>
      _$GsArtifactPieceFromJson(json);

  @override
  JsonMap toMap() => _$GsArtifactPieceToJson(this);
}
