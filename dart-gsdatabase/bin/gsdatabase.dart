import 'package:gsdatabase/gsdatabase.dart';

void main(List<String> arguments) async {
  final db = GsDatabase.info();
  await db.load(path: 'data/gsdata', encoded: true);

  final char = db.of<GsCharacter>().items.firstOrNull;
  if (char != null) {
    print(char.id);
    print(char.name);
  }

  final weap = db.of<GsWeapon>().items.lastOrNull;
  if (weap != null) {
    print(weap.id);
    print(weap.name);
  }

  final version = db.of<GsVersion>().items.firstOrNull;
  if (version != null) {
    print(version.releaseDate);
    print(version.toMap()['release_date']);
  }
}

void testVersionGetter() {
  final group = GsAchievementGroup.fromJson({'version': '1.0'});
  final char0 = GsCharacter.fromJson({'version': '1.0'});

  void test(GsModel model) {
    if (model is GsVersionable) {
      print('Is Getter ${model.runtimeType}: ${model.version}');
    }
  }

  test(group);
  test(char0);
}
