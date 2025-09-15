import 'package:flutter/material.dart';
import 'package:tracker/common/widgets/gs_incrementer.dart';
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

class GsIconButtonHold extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final void Function(int i)? onPress;

  const GsIconButtonHold({
    super.key,
    required this.icon,
    this.size = 24,
    this.onPress,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GsIncrementer(
      onTap: onPress != null ? () => onPress!(1) : null,
      onHold: onPress != null ? (i) => onPress!(_intFromTick(i)) : null,
      child: Opacity(
        opacity: onPress != null ? 1 : kDisableOpacity,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GsCircleIcon(size: size, icon: icon, color: color),
        ),
      ),
    );
  }
}

int _intFromTick(int tick) {
  if (tick < 50) return 1;
  if (tick < 100) return 10;
  if (tick < 150) return 100;
  return 1000;
}
