import 'package:flutter/material.dart';
import 'package:tracker/common/widgets/gs_divider.dart';
import 'package:tracker/theme/gs_assets.dart';

class GsDataBox extends StatelessWidget {
  final Widget? title;
  final Decoration Function(BuildContext ctx)? decoration;
  final Widget? child;
  final EdgeInsetsGeometry padding;
  final Iterable<Widget> children;
  final CrossAxisAlignment alignment;

  GsDataBox.info({
    super.key,
    this.title,
    this.child,
    Color? bgColor,
    this.children = const [],
  })  : alignment = CrossAxisAlignment.start,
        padding = const EdgeInsets.all(kSeparator8),
        decoration = ((ctx) {
          return BoxDecoration(
            color: bgColor ?? ctx.themeColors.mainColor0,
            borderRadius: GsSpacing.kGridRadius,
          );
        });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration?.call(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment,
        children: [
          if (title != null) ...[
            DefaultTextStyle(
              style: context.themeStyles.title18n,
              child: title!,
            ),
            GsDivider(),
          ],
          if (child != null) child!,
          ...children,
        ],
      ),
    );
  }
}
