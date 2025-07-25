import 'package:data_editor/db/ge_enums.dart';
import 'package:data_editor/db_ext/data_validator.dart';
import 'package:data_editor/db_ext/datafield.dart';
import 'package:data_editor/db_ext/datafields_util.dart';
import 'package:data_editor/db_ext/src/abstract/gs_model_ext.dart';
import 'package:gsdatabase/gsdatabase.dart';

class GsSereniteaSetExt extends GsModelExt<GsSereniteaSet> {
  const GsSereniteaSetExt();

  @override
  List<DataField<GsSereniteaSet>> getFields(String? editId) {
    final vd = ValidateModels<GsSereniteaSet>();
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
      DataField.singleEnum<GsSereniteaSet, GeSereniteaSetType>(
        'Category',
        GeSereniteaSetType.values.toChips(),
        (item) => item.category,
        (item, value) => item.copyWith(category: value),
        invalid: [GeSereniteaSetType.none],
      ),
      DataField.textImage(
        'Image',
        (item) => item.image,
        (item, value) => item.copyWith(image: value),
      ),
      DataField.intField(
        'Energy',
        (item) => item.energy,
        (item, value) => item.copyWith(energy: value),
        range: (1, null),
      ),
      DataField.multiSelect<GsSereniteaSet, String>(
        'Chars',
        (item) => item.chars,
        (item) => vdCharacters.filters,
        (item, value) => item.copyWith(chars: value),
        validator:
            (item) =>
                item.chars.isEmpty
                    ? GsValidLevel.warn1
                    : vdCharacters.validateAll(item.chars),
      ),
    ];
  }
}
