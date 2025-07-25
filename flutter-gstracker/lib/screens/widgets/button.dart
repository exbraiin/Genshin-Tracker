import 'package:flutter/material.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/theme/gs_assets.dart';

class MainButton extends StatelessWidget {
  final Color? color;
  final String? label;
  final Widget? child;
  final bool selected;
  final VoidCallback? onPress;

  const MainButton({
    super.key,
    this.selected = false,
    this.color,
    this.label,
    this.child,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPress != null ? 1 : kDisableOpacity,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        decoration: BoxDecoration(
          borderRadius: GsSpacing.kGridRadius,
          color:
              Color.lerp(color, Colors.black, 0.25) ??
              context.themeColors.mainColor0,
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: GsSpacing.kGridRadius,
          border:
              selected
                  ? Border.all(color: context.themeColors.almostWhite, width: 2)
                  : null,
        ),
        child: InkWell(
          onTap: onPress,
          child: DefaultTextStyle(
            style: context.textTheme.titleSmall!.copyWith(color: Colors.white),
            child: label != null ? Text(label!) : (child ?? SizedBox()),
          ),
        ),
      ),
    );
  }
}
