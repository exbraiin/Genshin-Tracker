import 'package:flutter/widgets.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';

class VersionListItem extends StatelessWidget {
  final bool selected;
  final GsVersion item;
  final VoidCallback? onTap;

  const VersionListItem(
    this.item, {
    super.key,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GsItemCardButton(
      label: item.id,
      imageUrlPath: item.image,
      selected: selected,
      banner: GsItemBanner.version(context, item.id),
      onTap: onTap,
    );
  }
}
