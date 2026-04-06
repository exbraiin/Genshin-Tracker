import 'dart:math' as math;

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_icon_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/text_style_parser.dart';
import 'package:tracker/common/widgets/value_notifier_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class MaterialDetailsCard extends StatelessWidget with GsDetailedDialogMixin {
  final GsMaterial item;
  final bool allowEditing;

  const MaterialDetailsCard(this.item, {super.key, this.allowEditing = false});

  @override
  Widget build(BuildContext context) {
    final weekdays = item.weekdays
        .sortedBy((element) => element.index)
        .map((element) => element.getLabel(context))
        .join(', ');

    final materials = GsUtils.materials
        .getGroupMaterials(item)
        .sortedBy((e) => e.rarity)
        .thenBy((element) => element.id == item.id ? 0 : 1)
        .distinctBy((element) => element.rarity);

    late final amount = GsUtils.materials.getMaterialOwnedAmount(item.id);
    return ItemDetailsCard(
      name: item.name,
      image: item.image,
      rarity: item.rarity,
      version: item.version,
      info: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_getLabel(context)),
          Spacer(),
          if (allowEditing)
            ValueNotifierBuilder(
              value: amount,
              builder: (context, notifier, child) {
                return PopScope(
                  onPopInvokedWithResult: (didPop, result) {
                    GsUtils.materials.updateMaterialOwned(
                      item.id,
                      (_) => notifier.value,
                    );
                  },
                  child: Row(
                    spacing: kSeparator16,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GsIconButton.remove(
                        onPressed: () =>
                            notifier.value = math.max(0, notifier.value - 1),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 30),
                        child: Center(
                          child: Text(
                            notifier.value.format(),
                            style: context.themeStyles.label16b,
                          ),
                        ),
                      ),
                      GsIconButton.add(
                        onPressed: () => notifier.value = math.min(
                          notifier.value + 1,
                          10000,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          //
        ],
      ),
      contentPadding: EdgeInsets.all(kSeparator16),
      child: Column(
        spacing: kSeparator16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.desc.isNotEmpty)
            ItemDetailsCardInfo.description(text: TextParserWidget(item.desc)),
          if (item.weekdays.isNotEmpty)
            ItemDetailsCardInfo.section(
              title: Text(context.labels.weeklyTasks()),
              content: Text(weekdays),
            ),
          if (materials.length > 1 && item.group != GeMaterialType.none)
            ItemDetailsCardInfo.section(
              title: Text(context.labels.materials()),
              content: Wrap(
                spacing: kSeparator4,
                runSpacing: kSeparator4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: materials
                    .map((e) => ItemGridWidget.material(e, onTap: null))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }

  String _getLabel(BuildContext context) {
    late final group = item.group.label(context);
    late final ingredient = context.labels.ingredients();

    if (item.ingredient) {
      return item.group == GeMaterialType.none
          ? ingredient
          : '$ingredient & $group';
    }
    return group;
  }
}
