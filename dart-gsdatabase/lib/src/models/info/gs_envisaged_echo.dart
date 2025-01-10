import 'package:gsdatabase/src/models/gs_model.dart';

part 'gs_envisaged_echo.g.dart';

@BuilderGenerator()
abstract class _GsEnvisagedEcho extends GsModel<GsEnvisagedEcho> {
  @BuilderWire('name')
  String get name;
  @BuilderWire('desc')
  String get description;
  @BuilderWire('character')
  String get character;
  @BuilderWire('rarity')
  int get rarity;
  @BuilderWire('icon')
  String get icon;
  @BuilderWire('version')
  String get version;
}
