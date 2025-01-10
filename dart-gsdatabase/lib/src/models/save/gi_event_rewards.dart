import 'package:gsdatabase/src/models/gs_model.dart';

part 'gi_event_rewards.g.dart';

@BuilderGenerator()
abstract class _GiEventRewards extends GsModel<GiEventRewards> {
  @BuilderWire('obtained_weapons')
  List<String> get obtainedWeapons;
  @BuilderWire('obtained_characters')
  List<String> get obtainedCharacters;
}
