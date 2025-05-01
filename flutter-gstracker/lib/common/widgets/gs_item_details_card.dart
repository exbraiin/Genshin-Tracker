import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/widgets/gs_item_card_button.dart';
import 'package:tracker/common/widgets/static/cached_image_widget.dart';

class ItemDetailsCard extends StatelessWidget {
  final int rarity;
  final String name;
  final DecorationImage? contentImage;
  final EdgeInsetsGeometry infoPadding;
  final EdgeInsetsGeometry contentPadding;
  final bool flexContent;
  final bool showRarityStars;
  final GsItemBanner? banner;
  final Widget? info;
  final String? asset;
  final String? image;
  final String? fgImage;
  final Widget? child;

  const ItemDetailsCard({
    super.key,
    this.name = '',
    this.rarity = 0,
    this.banner,
    this.contentImage,
    this.flexContent = false,
    this.showRarityStars = true,
    this.infoPadding = const EdgeInsets.all(kSeparator8),
    this.contentPadding = const EdgeInsets.all(kSeparator8),
    this.info,
    this.asset,
    this.image,
    this.fgImage,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _headerTitle(context),
        _headerInfo(context),
        flexContent ? Flexible(child: _content(context)) : _content(context),
      ],
    );
  }

  Widget _headerTitle(BuildContext context) {
    final rarity = this.rarity.coerceAtLeast(1);
    final color = context.themeColors.colorByRarityBg(rarity);
    final color1 = Color.lerp(Colors.black, color, 0.8)!;
    return Container(
      height: 56,
      color: color,
      child: Container(
        margin: const EdgeInsets.all(kSeparator2),
        padding: const EdgeInsets.all(kSeparator8),
        decoration: BoxDecoration(
          border: Border.all(
            color: color1,
            width: kSeparator2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SelectableText(
                      name.isNotEmpty ? name : ' ',
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              if (Navigator.of(context).canPop())
                Container(
                  margin: const EdgeInsets.only(left: 32),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white60, width: 2),
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: const AspectRatio(
                        aspectRatio: 1,
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white60,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerInfo(BuildContext context) {
    final banner = this.banner;
    final rarity = this.rarity.coerceAtLeast(1);
    final color = context.themeColors.colorByRarityBg(rarity);
    final color1 = Color.lerp(Colors.black, color, 0.8)!;
    return Stack(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(color: color1),
          foregroundDecoration: BoxDecoration(
            border: Border(
              bottom:
                  BorderSide(color: color1.withValues(alpha: 0.6), width: 4),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                left: null,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black,
                              Colors.black.withValues(alpha: 0),
                            ],
                            stops: const [0, 0.8],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: Image.asset(
                          GsAssets.getRarityBgImage(rarity.coerceAtLeast(1)),
                          alignment: Alignment.centerRight,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: () {
                          if (asset != null) {
                            return Image.asset(asset!);
                          }
                          if (image != null) {
                            return AspectRatio(
                              aspectRatio: 1,
                              child: CachedImageWidget(image!),
                            );
                          }
                          return const SizedBox();
                        }(),
                      ),
                    ],
                  ),
                ),
              ),
              if (fgImage != null)
                Positioned.fill(
                  child: CachedImageWidget(
                    fgImage,
                    showPlaceholder: false,
                    fit: BoxFit.cover,
                  ),
                ),
              Positioned.fill(
                child: Padding(
                  padding: infoPadding,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DefaultTextStyle(
                          style: context.textTheme.titleLarge!.copyWith(
                            color: context.themeColors.almostWhite,
                            fontSize: 16,
                            shadows: const [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: info ?? const SizedBox(),
                        ),
                      ),
                      if (showRarityStars)
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Row(
                            children: List.generate(
                              rarity,
                              (i) => Transform.translate(
                                offset: Offset(i * -6, 0),
                                child: const Icon(
                                  Icons.star_rounded,
                                  size: 30,
                                  color: Colors.yellow,
                                  shadows: kMainShadow,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (banner != null && banner.text.isNotEmpty)
          Positioned.fill(
            child: ClipRect(
              child: Banner(
                color: banner.color,
                message: banner.text,
                location: banner.location,
              ),
            ),
          ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: contentPadding,
      decoration: BoxDecoration(
        color: contentImage != null ? null : const Color(0xFFEDE5D8),
        image: contentImage,
        border: Border(
          bottom:
              BorderSide(color: Colors.black.withValues(alpha: 0.2), width: 4),
        ),
      ),
      child: child ?? const SizedBox(),
    );
  }
}

abstract class ItemDetailsCardInfo {
  static Widget description({required Widget text}) {
    return Builder(
      builder: (context) {
        return DefaultTextStyle(
          style: context.themeStyles.label12b.copyWith(
            color: context.themeColors.sectionContent,
            height: 1.2,
          ),
          child: text,
        );
      },
    );
  }

  static Widget section({required Widget title, required Widget content}) {
    return Builder(
      builder: (context) {
        return Column(
          spacing: kSeparator4,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: context.themeStyles.label14n.copyWith(
                fontSize: 16,
                color: context.themeColors.sectionTitle,
                fontWeight: FontWeight.bold,
              ),
              child: title,
            ),
            DefaultTextStyle(
              style: context.themeStyles.label12n.copyWith(
                color: context.themeColors.sectionContent,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
              child: content,
            ),
          ],
        );
      },
    );
  }
}
