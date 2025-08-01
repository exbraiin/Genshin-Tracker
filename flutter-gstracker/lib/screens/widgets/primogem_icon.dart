import 'package:flutter/material.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class PrimogemIcon extends StatelessWidget {
  final double size;
  final Offset offset;

  const PrimogemIcon({
    super.key,
    this.size = 20,
    this.offset = const Offset(0, 3),
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Image.asset(
          AppAssets.primogem,
          width: size,
          height: size,
          fit: BoxFit.fitHeight,
          cacheWidth: size.toInt(),
          cacheHeight: size.toInt(),
        ),
      ),
    );
  }
}
