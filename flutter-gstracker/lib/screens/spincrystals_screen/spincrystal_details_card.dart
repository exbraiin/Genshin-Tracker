import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_detailed_dialog.dart';
import 'package:tracker/common/widgets/gs_icon_button.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/common/widgets/gs_item_details_card.dart';
import 'package:tracker/common/widgets/static/cached_image_widget.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';

class SpincrystalDetailsCard extends StatelessWidget
    with GsDetailedDialogMixin {
  final GsSpincrystal item;

  const SpincrystalDetailsCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ValueStreamBuilder(
      stream: Database.instance.loaded,
      builder: (context, snapshot) {
        final db = Database.instance.saveOf<GiSpincrystal>();
        final owned = db.exists(item.id);
        return ItemDetailsCard(
          name: context.labels.radiantSpincrystal(item.number),
          rarity: 4,
          asset: GsAssets.spincrystal,
          banner: GsItemBanner.isNewOrUpcoming(context, item.version),
          info: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.name.isNotEmpty ? item.name : context.labels.unknown(),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: GsIconButton(
                  size: 26,
                  color: owned
                      ? context.themeColors.goodValue
                      : context.themeColors.badValue,
                  icon: owned ? Icons.check : Icons.close,
                  onPress: () => GsUtils.spincrystals
                      .update(item.number, obtained: !owned),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.all(kSeparator16),
          child: Column(
            spacing: kSeparator16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemDetailsCardInfo.section(
                title: Text(context.labels.region()),
                content: Text(item.region.label(context)),
              ),
              ItemDetailsCardInfo.section(
                title: Text(context.labels.source()),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.source),
                    Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          width: 256,
                          height: 256,
                          margin: const EdgeInsets.all(kSeparator8),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: context.themeColors.mainColor1,
                              width: kSeparator4,
                            ),
                            borderRadius: kGridRadius,
                            color: item.region.color,
                            image: DecorationImage(
                              image: AssetImage(GsAssets.getRarityBgImage(1)),
                              colorFilter: ColorFilter.mode(
                                item.region.color,
                                BlendMode.softLight,
                              ),
                            ),
                          ),
                          child: CachedImageWidget(item.imageSource),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
