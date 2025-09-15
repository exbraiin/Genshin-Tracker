import 'package:flutter/material.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/theme/gs_assets.dart';

class MainButton extends StatefulWidget {
  final Color? color;
  final String? label;
  final Widget? child;
  final VoidCallback? onPress;
  final EdgeInsetsGeometry? padding;

  const MainButton({
    super.key,
    this.color,
    this.label,
    this.child,
    this.onPress,
    this.padding,
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  var _hover = false;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.onPress != null ? 1 : kDisableOpacity,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: GsSpacing.kGridRadius,
          color:
              Color.lerp(widget.color, Colors.black, 0.25) ??
              context.themeColors.mainColor0,
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: GsSpacing.kGridRadius,
          border: Border.all(
            color: _hover
                ? context.themeColors.almostWhite.withValues(alpha: 0.8)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: MouseRegion(
          onEnter: (event) => setState(() => _hover = true),
          onExit: (event) => setState(() => _hover = false),
          child: InkWell(
            onTap: widget.onPress,
            child: Padding(
              padding:
                  widget.padding ?? const EdgeInsets.fromLTRB(12, 6, 12, 6),
              child: DefaultTextStyle(
                style: context.textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
                child: widget.label != null
                    ? Text(widget.label!)
                    : (widget.child ?? SizedBox()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
