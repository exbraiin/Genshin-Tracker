import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:gsdatabase/src/models/gs_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gi_account_info.g.dart';

@CopyWith(skipFields: true)
@JsonSerializable(explicitToJson: true)
class GiAccountInfo({
  @override final String id = '',
  final String monThuChar = '',
  final String tueFriChar = '',
  final String wedSatChar = '',
}) extends GsModel<GiAccountInfo> {
  static const kTableKey = 'account';

  factory GiAccountInfo.fromJson(JsonMap json) => _$GiAccountInfoFromJson(json);

  @override
  JsonMap toMap() => _$GiAccountInfoToJson(this);
}
