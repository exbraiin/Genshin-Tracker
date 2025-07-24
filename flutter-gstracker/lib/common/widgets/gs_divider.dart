import 'package:flutter/material.dart';
import 'package:tracker/theme/gs_assets.g.dart';

class GsDivider extends StatelessWidget {
  final double height;
  final double spacing;

  const GsDivider({super.key, this.height = 12, this.spacing = 4});

  @override
  Widget build(BuildContext context) {
    final h = height * 3 / 27;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing),
      child: Row(
        children: [
          Image.asset(AppAssets.pageBdLt, height: height),
          Expanded(
            child: Container(
              height: h,
              color: Colors.white.withValues(alpha: 0.09),
            ),
          ),
          Image.asset(AppAssets.pageBdRt, height: height),
        ],
      ),
    );
  }
}
