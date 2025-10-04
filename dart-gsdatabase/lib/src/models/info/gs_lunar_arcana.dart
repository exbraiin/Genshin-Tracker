import 'package:gsdatabase/src/models/gs_model.dart';

part 'gs_lunar_arcana.g.dart';

@BuilderGenerator()
abstract class _GsLunarArcana extends GsModel<GsLunarArcana>
    with GsVersionable {
  @BuilderWire('name')
  String get name;
  @BuilderWire('number')
  int get number;
  @BuilderWire('image')
  String get image;
  @BuilderWire('desc')
  String get description;
  @override
  @BuilderWire('version')
  String get version;

  @override
  Iterable<Comparable Function(GsLunarArcana a)> get sorters => [
    (e) => e.number,
    (e) => e.version,
    (e) => e.name,
  ];
}
