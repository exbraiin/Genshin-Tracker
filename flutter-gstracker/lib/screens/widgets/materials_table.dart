import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/gs_divider.dart';
import 'package:tracker/common/widgets/static/expandable.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

typedef MatEntry = MapEntry<GsMaterial, int>;

class MaterialsTable extends StatefulWidget {
  final Color? color;
  final Map<GsMaterial, int> matsTotal;
  final String Function(int l)? levelLabel;
  final List<(int, Map<GsMaterial, int>)> matsByLevel;
  final SortedList<MatEntry> Function(Iterable<MatEntry> list) sort;

  const MaterialsTable({
    super.key,
    this.color,
    this.levelLabel,
    required this.matsTotal,
    required this.matsByLevel,
    this.sort = _toSorted,
  });

  @override
  State<MaterialsTable> createState() => _MaterialsTableState();
}

class _MaterialsTableState extends State<MaterialsTable> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getTable(
          children: [
            _getTableRow(
              Row(
                children: [
                  Text(context.labels.total()),
                  IconButton(
                    color: widget.color,
                    onPressed: () => setState(() => _expanded = !_expanded),
                    icon:
                        _expanded
                            ? Icon(Icons.expand_less_rounded)
                            : Icon(Icons.expand_more_rounded),
                  ),
                ],
              ),
              widget.matsTotal,
            ),
          ],
        ),
        Expandable(
          expand: _expanded,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              GsDivider(color: widget.color),
              _getTable(
                children:
                    widget.matsByLevel
                        .map(
                          (e) => _getTableRow(
                            Text('${widget.levelLabel?.call(e.$1) ?? e.$1}'),
                            e.$2,
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Table _getTable({required List<TableRow> children}) {
    return Table(
      columnWidths: const {0: IntrinsicColumnWidth()},
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        horizontalInside: BorderSide(
          color: context.themeColors.divider,
          width: 0.4,
        ),
      ),
      children: children,
    );
  }

  TableRow _getTableRow(Widget label, Map<GsMaterial, int> mats) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(kSeparator8),
          child: DefaultTextStyle(
            style:
                context.textTheme.titleSmall?.copyWith(
                  color: widget.color ?? Colors.white,
                ) ??
                TextStyle(),
            child: label,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kSeparator4),
          child: Wrap(
            spacing: kSeparator4,
            runSpacing: kSeparator4,
            textDirection: TextDirection.rtl,
            children:
                widget
                    .sort(mats.entries)
                    .thenBy((e) => e.key.group.index)
                    .thenBy((e) => e.key.subgroup)
                    .thenBy((e) => e.key.rarity)
                    .thenBy((e) => e.key.name)
                    .reversed
                    .map(
                      (e) => ItemGridWidget.material(
                        e.key,
                        label: e.value.compact(),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

SortedList<E> _toSorted<E>(Iterable<E> list) {
  return list.sortedBy((e) => 0);
}
