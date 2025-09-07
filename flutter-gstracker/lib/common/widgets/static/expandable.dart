import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  final bool expand;
  final Widget? child;
  final AlignmentGeometry alignment;

  const Expandable({
    super.key,
    this.child,
    this.expand = true,
    this.alignment = Alignment.center,
  });

  @override
  State<Expandable> createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: widget.expand ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Expandable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expand != widget.expand) {
      _controller.animateTo(
        widget.expand ? 1 : 0,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Expansible;

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final value = _controller.value;
        return ClipRect(
          child: Align(
            alignment: widget.alignment,
            heightFactor: value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
