import 'package:flutter/material.dart';
import 'package:tracker/theme/gs_spacing.dart';

class ExpandWidget extends StatefulWidget {
  final Widget child;

  const ExpandWidget({super.key, required this.child});

  @override
  State<ExpandWidget> createState() => _ExpandWidgetState();
}

class _ExpandWidgetState extends State<ExpandWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: kSeparator6,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: IconButton(
            onPressed: () => setState(() => _expanded = !_expanded),
            padding: const EdgeInsets.all(kSeparator4),
            constraints: const BoxConstraints.tightFor(),
            icon: AnimatedRotation(
              turns: _expanded ? 0.5 : 1,
              duration: const Duration(milliseconds: 200),
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
        ClipRect(
          child: AnimatedAlign(
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 400),
            alignment: Alignment.topCenter,
            heightFactor: _expanded ? 1 : 0,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
