import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/widgets/button.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.dart';

class GsTimeDialog extends StatefulWidget {
  final DateTime? date;

  const GsTimeDialog._(this.date);

  static Future<DateTime?> show(BuildContext context, [DateTime? date]) {
    return showDialog<DateTime?>(
      context: context,
      builder: (_) => GsTimeDialog._(date),
    );
  }

  @override
  State<GsTimeDialog> createState() => _GsTimeDialogState();
}

typedef _Scroller = ({FixedExtentScrollController ctrl, int min, int max});

class _GsTimeDialogState extends State<GsTimeDialog>
    with SingleTickerProviderStateMixin {
  // This needs to be static for lock system.
  static DateTime? _savedTime;
  late final _Scroller year, month, day;
  late final _Scroller hour, minute, second;

  bool get _isLocked => _savedTime != null;

  @override
  void initState() {
    super.initState();

    final initial = _savedTime ?? widget.date ?? DateTime.now();
    _Scroller scroller(int value, int min, int max) {
      final ctrl = FixedExtentScrollController(initialItem: value - min);
      return (ctrl: ctrl, min: min, max: max);
    }

    year = scroller(initial.year, 2010, 2050);
    month = scroller(initial.month, 1, 12);
    day = scroller(initial.day, 1, 31);

    hour = scroller(initial.hour, 0, 23);
    minute = scroller(initial.minute, 0, 59);
    second = scroller(initial.second, 0, 59);
  }

  @override
  void dispose() {
    final controllers = [year, month, day, hour, minute, second];
    for (final element in controllers) {
      element.ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.titleSmall!.copyWith(color: Colors.white);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: GsSpacing.kListPadding,
          constraints: const BoxConstraints(maxHeight: 210, maxWidth: 300),
          decoration: BoxDecoration(
            color: context.themeColors.mainColor0,
            borderRadius: GsSpacing.kGridRadius,
          ),
          child: Column(
            children: [
              InventoryBox(
                child: Center(
                  child: Text(
                    context.labels.selectDate(),
                    style: context.themeStyles.title18n,
                  ),
                ),
              ),
              const SizedBox(height: GsSpacing.kGridSeparator),
              Expanded(
                child: InventoryBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: kSeparator4),
                            constraints: const BoxConstraints(minWidth: 56),
                            child: Text(
                              context.labels.dateDialogDate(),
                              style: style,
                            ),
                          ),
                          _selector(year, style),
                          SizedBox(
                            width: 20,
                            child: Center(child: Text(' - ', style: style)),
                          ),
                          _selector(month, style),
                          SizedBox(
                            width: 20,
                            child: Center(child: Text(' - ', style: style)),
                          ),
                          _selector(day, style),
                        ],
                      ),
                      const SizedBox(height: GsSpacing.kGridSeparator),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: kSeparator4),
                            constraints: const BoxConstraints(minWidth: 56),
                            child: Text(
                              context.labels.dateDialogHour(),
                              style: style,
                            ),
                          ),
                          _selector(hour, style),
                          SizedBox(
                            width: 20,
                            child: Center(child: Text(' : ', style: style)),
                          ),
                          _selector(minute, style),
                          SizedBox(
                            width: 20,
                            child: Center(child: Text(' : ', style: style)),
                          ),
                          _selector(second, style),
                        ],
                      ),
                      const SizedBox(height: kSeparator8),
                      Row(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(),
                          Expanded(
                            child: SizedBox(
                              width: 30,
                              child: AnimatedOpacity(
                                opacity: _isLocked ? kDisableOpacity : 1,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.fastOutSlowIn,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints.tightFor(),
                                  onPressed: _isLocked ? null : _pasteDate,
                                  iconSize: 24,
                                  color: Colors.white.withValues(alpha: 0.5),
                                  icon: Column(
                                    children: [
                                      Icon(Icons.paste_rounded),
                                      Text(
                                        'Paste',
                                        style: context.themeStyles.emptyState
                                            .copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          MainButton(
                            color: context.themeColors.goodValue,
                            label: context.labels.ok(),
                            padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                            onPress: () {
                              final date = _getDate();
                              Navigator.of(context).maybePop(date);
                            },
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 30,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints.tightFor(),
                                onPressed: () => setState(() {
                                  _savedTime = _isLocked ? null : _getDate();
                                }),
                                iconSize: 24,
                                color: Colors.white.withValues(alpha: 0.5),
                                icon: Column(
                                  children: [
                                    Icon(
                                      _isLocked
                                          ? Icons.lock_outline
                                          : Icons.lock_open,
                                    ),
                                    Text(
                                      _isLocked ? 'Unlock' : 'Lock',
                                      style: context.themeStyles.emptyState
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selector(_Scroller scroller, TextStyle style) {
    return AnimatedOpacity(
      opacity: _isLocked ? kDisableOpacity : 1,
      duration: Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: context.themeColors.mainColor0,
          borderRadius: GsSpacing.kGridRadius,
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: GsSpacing.kGridRadius,
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
            colors: [
              Colors.white.withValues(alpha: 0.2),
              Colors.white.withValues(alpha: 0.1),
              Colors.black.withValues(alpha: 0.1),
              Colors.black.withValues(alpha: 0.2),
            ],
            stops: const [0, 0.2, 0.8, 1],
          ),
        ),
        child: ListWheelScrollView.useDelegate(
          childDelegate: ListWheelChildLoopingListDelegate(
            children: List.generate(
              scroller.max - scroller.min + 1,
              (index) => Center(
                child: Text(
                  (scroller.min + index).toString().padLeft(2, '0'),
                  style: style,
                  strutStyle: style.toStrut(),
                ),
              ),
            ),
          ),
          controller: scroller.ctrl,
          scrollBehavior: const ScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse},
            scrollbars: false,
          ),
          itemExtent: 44,
          physics: _isLocked
              ? const NeverScrollableScrollPhysics()
              : const FixedExtentScrollPhysics(),
        ),
      ),
    );
  }

  void _pasteDate() async {
    final clip = await Clipboard.getData(Clipboard.kTextPlain);
    final text = clip?.text;
    if (text == null) return;

    final date = DateTime.tryParse(text);
    if (date == null) return;

    setState(() => _setDate(date));
  }

  void _setDate(DateTime date) {
    year.value = date.year;
    month.value = date.month;
    day.value = date.day;
    hour.value = date.hour;
    minute.value = date.minute;
    second.value = date.second;
  }

  DateTime _getDate() {
    return DateTime(
      year.value,
      month.value,
      day.value,
      hour.value,
      minute.value,
      second.value,
    );
  }
}

extension on _Scroller {
  set value(int value) => ctrl.animateToItem(
    (value - min) % (max + 1 - min),
    duration: Duration(milliseconds: 400),
    curve: Curves.easeOut,
  );
  int get value => (ctrl.selectedItem % (max + 1 - min)) + min;
}
