import 'package:gsdatabase/src/models/gs_model.dart';

part 'gs_thespian_trick.g.dart';

@BuilderGenerator()
abstract class _GsThespianTrick extends GsModel<GsThespianTrick>
    with GsVersionable {
  @BuilderWire('name')
  String get name;
  @BuilderWire('rarity')
  int get rarity;
  @BuilderWire('season')
  int get season;
  @BuilderWire('character')
  String get character;
  @BuilderWire('image')
  String get image;
  @override
  @BuilderWire('version')
  String get version;

  @override
  Iterable<Comparable Function(GsThespianTrick a)> get sorters => [
        (e) => e.season,
      ];
}
