import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum MouseButton { none, primary, secondary, middle, back, forward }

class MouseListener extends StatelessWidget {
  final Widget? child;
  final void Function(MouseButton button)? onButtonUp;
  final void Function(MouseButton button)? onButtonDown;

  const MouseListener({
    super.key,
    this.onButtonUp,
    this.onButtonDown,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp:
          onButtonUp != null
              ? (event) => onButtonUp!(_fromValue(event.buttons))
              : null,
      onPointerDown:
          onButtonDown != null
              ? (event) => onButtonDown!(_fromValue(event.buttons))
              : null,
      child: child,
    );
  }

  MouseButton _fromValue(int buttons) {
    return switch (buttons) {
      kMiddleMouseButton => MouseButton.middle,
      kPrimaryMouseButton => MouseButton.primary,
      kSecondaryMouseButton => MouseButton.secondary,
      kBackMouseButton => MouseButton.back,
      kForwardMouseButton => MouseButton.forward,
      _ => MouseButton.none,
    };
  }
}
