import 'package:gsdatabase/src/models/gs_model.dart';

part 'gi_account_info.g.dart';

@BuilderGenerator()
abstract class _GiAccountInfo extends GsModel<GiAccountInfo> {
  @BuilderWire('mon_thu_char', value: '')
  String get monThuChar;
  @BuilderWire('tue_fri_char', value: '')
  String get tueFriChar;
  @BuilderWire('wed_sat_char', value: '')
  String get wedSatChar;
}
