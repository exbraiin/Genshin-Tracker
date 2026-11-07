import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tracker/theme/gs_assets.g.dart';

final _emptyPixelBytes = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=',
);

class GsFileImage extends StatelessWidget {
  final BoxFit fit;
  final File? image;
  final Alignment alignment;
  final bool showPlaceholder;

  const GsFileImage(
    this.image, {
    super.key,
    this.showPlaceholder = true,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    late final placeholder = showPlaceholder
        ? Image.asset(AppAssets.missingIcon, fit: BoxFit.contain)
        : SizedBox();
    if (image == null) return placeholder;

    return FadeInImage(
      image: FileImage(image!).resizeIfNeeded(),
      placeholder: showPlaceholder
          ? AssetImage(AppAssets.missingIcon).resizeIfNeeded()
          : MemoryImage(_emptyPixelBytes),
      fit: fit,
      alignment: alignment,
      placeholderFit: BoxFit.contain,
      imageErrorBuilder: (context, error, stackTrace) => placeholder,
    );
  }
}

extension ImageProviderExt on ImageProvider<Object> {
  ImageProvider<Object> resizeIfNeeded() =>
      ResizeImage.resizeIfNeeded(null, null, this);
}
