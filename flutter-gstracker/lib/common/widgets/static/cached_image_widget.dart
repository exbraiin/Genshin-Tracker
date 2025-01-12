import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tracker/common/graphics/gs_style.dart';

final _emptyPixelBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=',
);

class CachedImageWidget extends StatelessWidget {
  final BoxFit fit;
  final String? imageUrl;
  final Alignment alignment;
  final bool scaleToSize;
  final bool showPlaceholder;
  final double? imageAspectRatio;

  const CachedImageWidget(
    this.imageUrl, {
    super.key,
    this.scaleToSize = true,
    this.showPlaceholder = true,
    this.imageAspectRatio,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    late final placeholder = showPlaceholder
        ? Image.asset(GsAssets.iconMissing, fit: BoxFit.contain)
        : SizedBox();
    if (imageUrl == null || imageUrl!.isEmpty) return placeholder;

    return LayoutBuilder(
      builder: (context, layout) {
        final url = _getScaleUrl(layout.biggest);
        return FadeInImage(
          image: CachedNetworkImageProvider(url).resizeIfNeeded(),
          placeholder: showPlaceholder
              ? AssetImage(GsAssets.iconMissing).resizeIfNeeded()
              : MemoryImage(_emptyPixelBytes),
          fit: fit,
          alignment: alignment,
          placeholderFit: BoxFit.contain,
          imageErrorBuilder: (context, error, stackTrace) => placeholder,
        );
      },
    );
  }

  int? _getCacheSize(Size size) {
    late final width = size.width;
    late final height = size.height;
    late final useW = width.isFinite && (width >= height || height.isInfinite);
    late final useH = height.isFinite && (height >= width || width.isInfinite);
    late final toCacheWidth = useW ? width.toInt() : null;
    late final toCacheHeight = useH ? height.toInt() : null;
    return toCacheWidth ?? toCacheHeight;
  }

  String _getScaleUrl(Size size) {
    final url = imageUrl ?? '';
    if (!scaleToSize) return url;
    if (!url.startsWith('https://static.wikia.')) return url;
    final s = _getCacheSize(size);
    if (s == null) return url;
    final ratio = imageAspectRatio ?? 0;
    final ns = (ratio > 0 ? s * ratio : s).toInt();
    return '$url/revision/latest/scale-to-width-down/$ns';
  }
}

extension ImageProviderExt on ImageProvider<Object> {
  ImageProvider<Object> resizeIfNeeded() =>
      ResizeImage.resizeIfNeeded(null, null, this);
}
