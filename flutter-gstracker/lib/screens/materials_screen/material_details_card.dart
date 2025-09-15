import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/text_style_parser.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class MaterialDetailsCard extends StatelessWidget with GsDetailedDialogMixin {
  final GsMaterial item;

  const MaterialDetailsCard(this.item, {super.key});

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

    return ItemDetailsCard(
      name: item.name,
      image: item.image,
      rarity: item.rarity,
      version: item.version,
      info: Text(_getLabel(context)),
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
