import 'package:flutter/material.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class GsNoResultsState extends StatelessWidget {
  final double size;
  final Color? color;

  const GsNoResultsState.xSmall({super.key, this.color}) : size = 40;
  const GsNoResultsState.small({super.key, this.color}) : size = 60;
  const GsNoResultsState({super.key, this.size = 100, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kSeparator4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemIconWidget.asset(AppAssets.empty, size: size),
            const SizedBox(height: kSeparator4),
            Text(
              context.labels.noResults(),
              style: context.themeStyles.emptyState.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
