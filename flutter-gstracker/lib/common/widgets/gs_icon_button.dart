import 'package:flutter/material.dart';
import 'package:tracker/theme/gs_assets.dart';

class GsCircleIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const GsCircleIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 2),
        ],
      ),
      child: Center(child: Icon(icon, color: color, size: 16)),
    );
  }
}

class GsIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final Color Function(BuildContext color)? onColor;
  final VoidCallback? onPress;

  const GsIconButton({
    super.key,
    required this.icon,
    this.size = 24,
    this.onPress,
    this.onColor,
    this.color,
  });

  factory GsIconButton.owned({
    required bool owned,
    required void Function(bool own) onPress,
  }) {
    return GsIconButton(
      size: 26,
      onColor: (context) =>
          owned ? context.themeColors.goodValue : context.themeColors.badValue,
      icon: owned ? Icons.check : Icons.close,
      onPress: () => onPress(!owned),
    );
  }

  factory GsIconButton.add({VoidCallback? onPress}) {
    return GsIconButton(icon: Icons.add, onPress: onPress);
  }

  factory GsIconButton.remove({VoidCallback? onPress}) {
    return GsIconButton(icon: Icons.remove, onPress: onPress);
  }

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? onColor?.call(context) ?? Colors.black;
    return Opacity(
      opacity: onPress != null ? 1 : kDisableOpacity,
      child: InkWell(
        onTap: () => onPress?.call(),
        child: GsCircleIcon(size: size, icon: icon, color: color),
      ),
    );
  }
}
