import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_icon_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/gs_number_field.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/common/widgets/value_notifier_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class RecipeDetailsCard extends StatelessWidget with GsDetailedDialogMixin {
  final GsRecipe item;

  const RecipeDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final isSpecial = item.baseRecipe.isNotEmpty;
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final db = Database.instance;
        final owned = db.saveOf<GiRecipe>().exists(item.id);
        final saved = db.saveOf<GiRecipe>().getItem(item.id);

        late final baseRecipe = db.infoOf<GsRecipe>().getItem(item.baseRecipe);
        late final char = db.infoOf<GsCharacter>().items.firstOrNullWhere(
          (e) => e.specialDish == item.id,
        );

        return ItemDetailsCard(
          name: item.name,
          rarity: item.rarity,
          image: item.image,
          version: item.version,
          info: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(item.effect.assetPath, width: 24, height: 24),
                    const SizedBox(width: kSeparator4),
                    Text(item.effect.label(context)),
                  ],
                ),
                const Spacer(),
                if (!isSpecial)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GsIconButton.owned(
                      owned: saved != null,
                      onPress:
                          (own) => GsUtils.recipes.update(item.id, own: own),
                    ),
                  ),
                if (!isSpecial && owned)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.only(top: kSeparator4),
                      padding: const EdgeInsets.all(kSeparator4),
                      decoration: BoxDecoration(
                        color: context.themeColors.mainColor0.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: GsSpacing.kGridRadius,
                      ),
                      child: Column(
                        children: [
                          GsNumberField(
                            onUpdate: _setProficiency,
                            onDbUpdate: _getProficiency,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Text(
                            '${context.labels.filterProficiency()} '
                            '${context.labels.maxProficiency(item.maxProficiency.format())}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 30,
                            child: ValueNotifierBuilder<int>(
                              value: _getProficiency(),
                              builder: (context, notifier, child) {
                                return Slider(
                                  min: 0,
                                  max: item.maxProficiency.toDouble(),
                                  activeColor: Colors.white,
                                  label: notifier.value.toString(),
                                  divisions: item.maxProficiency,
                                  value: notifier.value.toDouble(),
                                  onChanged: (i) => notifier.value = i.toInt(),
                                  onChangeEnd:
                                      (i) => _setProficiency(i.toInt()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(kSeparator16),
          child: Column(
            spacing: kSeparator16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemDetailsCardInfo.description(text: Text(item.desc)),
              ItemDetailsCardInfo.section(
                title: Text(item.effect.label(context)),
                content: Text(item.effectDesc),
              ),
              if (item.ingredients.isNotEmpty)
                ItemDetailsCardInfo.section(
                  title: Text(context.labels.ingredients()),
                  content: Wrap(
                    spacing: kSeparator4,
                    runSpacing: kSeparator4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ...item.ingredients.map((e) {
                        final item = db.infoOf<GsMaterial>().getItem(e.id);
                        if (item == null) return const SizedBox();
                        return ItemGridWidget.material(
                          item,
                          label: e.amount.format(),
                        );
                      }),
                      if (baseRecipe != null) ...[
                        Icon(
                          Icons.add_rounded,
                          color: context.themeColors.mainColor1,
                        ),
                        ItemGridWidget.recipe(baseRecipe, onTap: null),
                        if (char != null)
                          ItemGridWidget.character(char, onTap: null),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  int _getProficiency() {
    final db = Database.instance.saveOf<GiRecipe>();
    return db.getItem(item.id)?.proficiency ?? 0;
  }

  void _setProficiency(int value) {
    final amount = value.clamp(0, item.maxProficiency);
    final current = _getProficiency();
    if (amount == current) return;
    GsUtils.recipes.update(item.id, proficiency: amount);
  }
}
