import 'package:flutter/material.dart';
import 'package:tracker/theme/gs_assets.dart';

class GsButton extends StatelessWidget {
  final Color? color;
  final Widget child;
  final EdgeInsets padding;
  final BoxBorder? border;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;

  const GsButton({
    super.key,
    required this.child,
    this.color,
    this.border,
    this.onPressed,
    this.borderRadius,
    this.padding = const EdgeInsets.symmetric(
      vertical: kSeparator4,
      horizontal: kSeparator8,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? context.themeColors.dimWhite,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white.withValues(alpha: 0.6),
        hoverColor: Colors.white.withValues(alpha: 0.2),
        borderRadius: borderRadius,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(border: border, borderRadius: borderRadius),
          child: child,
        ),
      ),
    );
  }
}
