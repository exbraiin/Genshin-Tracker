import 'package:gsdatabase/src/models/gs_model.dart';

part 'gi_material.g.dart';

@BuilderGenerator()
abstract class _GiMaterial extends GsModel<GiMaterial> {
  @BuilderWire('amount')
  int get amount;
}
