import 'package:data_editor/widgets/gs_progress_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BusyWidget extends StatefulWidget {
  final IconData icon;
  final String? message;
  final AsyncCallback onPressed;

  const BusyWidget({
    super.key,
    this.message,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<BusyWidget> createState() => _BusyWidgetState();
}

class _BusyWidgetState extends State<BusyWidget> {
  final notifier = ValueNotifier(false);

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        if (value) {
          return const Center(
            child: IconButton(icon: GsProgressIndicator(), onPressed: null),
          );
        }

        final button = IconButton(
          icon: Icon(widget.icon),
          onPressed: () async {
            notifier.value = true;
            await widget.onPressed();
            if (!mounted) return;
            notifier.value = false;
          },
        );

        if (widget.message != null) {
          return Tooltip(message: widget.message, child: button);
        }

        return button;
      },
    );
  }
}
