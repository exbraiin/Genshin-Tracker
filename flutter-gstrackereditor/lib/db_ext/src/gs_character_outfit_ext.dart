import 'package:data_editor/db_ext/datafield.dart';
import 'package:data_editor/db_ext/datafields_util.dart';
import 'package:data_editor/db_ext/src/abstract/gs_model_ext.dart';
import 'package:gsdatabase/gsdatabase.dart';

class GsCharacterSkinExt extends GsModelExt<GsCharacterSkin> {
  const GsCharacterSkinExt();

  @override
  List<DataField<GsCharacterSkin>> getFields(String? editId) {
    final vd = ValidateModels<GsCharacterSkin>();
    final vdVersion = ValidateModels.versions();
    final vdCharacters = ValidateModels<GsCharacter>();

    return [
      DataField.textField(
        'ID',
        (item) => item.id,
        (item, value) => item.copyWith(id: value),
        validator: (item) => vd.validateItemId(item, editId),
        refresh: DataButton(
          'Generate Id',
          (ctx, item) => item.copyWith(id: expectedId(item)),
        ),
      ),
      DataField.textField(
        'Name',
        (item) => item.name,
        (item, value) => item.copyWith(name: value),
      ),
      DataField.selectRarity(
        'Rarity',
        (item) => item.rarity,
        (item, value) => item.copyWith(rarity: value),
      ),
      DataField.singleSelect(
        'Version',
        (item) => item.version,
        (item) => vdVersion.filters,
        (item, value) => item.copyWith(version: value),
        validator: (item) => vdVersion.validate(item.version),
      ),
      DataField.singleSelect(
        'Character',
        (item) => item.character,
        (item) => vdCharacters.filters,
        (item, value) => item.copyWith(character: value),
        validator: (item) => vdCharacters.validate(item.character),
      ),
      DataField.validateFile(
        'Image',
        (item) => item.image,
        expectedSize: (256, 256),
      ),
    ];
  }
}
