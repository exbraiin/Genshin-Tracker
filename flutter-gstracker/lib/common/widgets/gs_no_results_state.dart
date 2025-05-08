import 'package:flutter/material.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';

class GsNoResultsState extends StatelessWidget {
  final double size;

  const GsNoResultsState.xSmall({super.key}) : size = 40;
  const GsNoResultsState.small({super.key}) : size = 60;
  const GsNoResultsState({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kSeparator4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemIconWidget.asset(GsAssets.emptyEmote, size: size),
            const SizedBox(height: kSeparator4),
            Text(
              context.labels.noResults(),
              style: context.themeStyles.emptyState,
            ),
          ],
        ),
      ),
    );
  }
}
