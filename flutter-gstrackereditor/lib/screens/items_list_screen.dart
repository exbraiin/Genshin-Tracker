import 'package:dartx/dartx.dart';
import 'package:data_editor/db/database.dart';
import 'package:data_editor/db/ge_enums.dart';
import 'package:data_editor/db_ext/data_validator.dart';
import 'package:data_editor/db_ext/datafield.dart';
import 'package:data_editor/style/style.dart';
import 'package:data_editor/widgets/gs_grid_item.dart';
import 'package:data_editor/widgets/gs_grid_view.dart';
import 'package:data_editor/widgets/gs_notifier_provider.dart';
import 'package:data_editor/widgets/gs_selector/gs_selector.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';

class ItemsListScreen<T extends GsModel<T>> extends StatefulWidget {
  final String title;
  final List<T> Function() list;
  final List<GsFieldFilter<T>> filters;

  final GsItemDecor Function(T i) getDecor;
  final void Function(BuildContext context, T? i)? onTap;

  const ItemsListScreen({
    super.key,
    required this.title,
    required this.list,
    required this.getDecor,
    this.filters = const [],
    this.onTap,
  });

  @override
  State<ItemsListScreen<T>> createState() => _ItemsListScreenState<T>();
}

class _ItemsListScreenState<T extends GsModel<T>>
    extends State<ItemsListScreen<T>> {
  var _warningOnly = false;
  var _sortByVersion = false;
  var _searchQuery = '';
  var _selectedFilters = <Set<String>>[];

  @override
  void initState() {
    super.initState();
    _selectedFilters = widget.filters.map((e) => <String>{}).toList();
  }

  @override
  Widget build(BuildContext context) {
    final first = widget.list().firstOrNull;
    final sortByVersion =
        first != null && widget.getDecor(first).version.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (sortByVersion)
            IconButton(
              icon:
                  _sortByVersion
                      ? const Icon(Icons.arrow_drop_down_rounded)
                      : const Icon(Icons.arrow_drop_up_rounded),
              onPressed: () => setState(() => _sortByVersion = !_sortByVersion),
            ),
          IconButton(
            color: _warningOnly ? Colors.orange : null,
            icon: const Icon(Icons.warning_amber_rounded),
            onPressed: () => setState(() => _warningOnly = !_warningOnly),
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed:
                () => _GsSearchItem(
                  _searchQuery,
                  (value) => setState(() => _searchQuery = value),
                ).show(context),
          ),
          if (widget.filters.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.filter_alt_rounded),
              onPressed: _showFiltersDialog,
            ),
          const VerticalDivider(),
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => widget.onTap?.call(context, null),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Database.i.modified,
        builder: (context, snapshot) {
          final collection =
              _sortByVersion && sortByVersion
                  ? widget
                      .list()
                      .sortedByDescending((e) => widget.getDecor(e).version)
                      .thenWith((a, b) => a.compareTo(b))
                  : widget.list();

          final list = collection.where((item) {
            // Apply filters...
            for (var i = 0; i < widget.filters.length; ++i) {
              if (_selectedFilters[i].isEmpty) continue;
              final selector = widget.filters[i].filter(item);
              if (!_selectedFilters[i].contains(selector)) {
                return false;
              }
            }

            // Apply query and warn...
            late final level = DataValidator.i.getLevel<T>(item.id);
            late final matchQuery =
                _searchQuery.isEmpty || item.id.contains(_searchQuery);
            return matchQuery && (!_warningOnly || level.isInvalid);
          });

          return GsGridView(
            children:
                list.map((item) {
                  final level = DataValidator.i.getLevel<T>(item.id);
                  final decor = widget.getDecor(item);
                  return GsGridItem.decor(
                    decor,
                    validLevel: level,
                    onTap: () => widget.onTap?.call(context, item),
                    child: decor.child,
                  );
                }).toList(),
          );
        },
      ),
    );
  }

  void _showFiltersDialog() {
    final filters = widget.filters;
    final selected = _selectedFilters;
    final pad = MediaQuery.of(context).size.width / 8;
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: pad),
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 20,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: GsNotifierProvider(
                  value: 0,
                  builder: (context, value, child) {
                    return ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      children:
                          filters.mapIndexed((i, e) {
                            return Column(
                              children: [
                                Text(e.label),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  alignment: WrapAlignment.center,
                                  children:
                                      e.filters.map((e) {
                                        final contained = selected[i].contains(
                                          e.value,
                                        );
                                        return GsSelectChip(
                                          e,
                                          selected: contained,
                                          onTap: (item) {
                                            value.value++;
                                            setState(
                                              () =>
                                                  contained
                                                      ? selected[i].remove(
                                                        e.value,
                                                      )
                                                      : selected[i].add(
                                                        e.value,
                                                      ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                ),
                                const SizedBox(height: 8),
                              ],
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GsFieldFilter<T extends GsModel<T>> {
  final String label;
  final String Function(T i) filter;
  final Iterable<GsSelectItem<String>> filters;

  GsFieldFilter(this.label, this.filters, this.filter);

  GsFieldFilter.rarity(this.label, int Function(T i) filter, [int min = 1])
    : filters = List.generate(6 - min, (index) {
        final rarity = (min + index).toString();
        return GsSelectItem(
          rarity,
          rarity,
          color: GsStyle.getRarityColor(min + index),
        );
      }),
      filter = ((i) => filter(i).toString());

  GsFieldFilter.fromEnum(
    this.label,
    List<GeEnum> filters,
    GeEnum Function(T i) filter,
  ) : filters = filters.toChips().map((e) {
        return GsSelectItem(
          e.value.id,
          e.label,
          color: e.color,
          asset: e.asset,
        );
      }),
      filter = ((i) => filter(i).id);
}

class GsItemDecor {
  final int rarity;
  final Color? color;
  final String label;
  final String version;
  final String? image;
  final Duration? duration;
  final Color? regionColor;
  final Widget? child;

  GsItemDecor.color({
    required this.label,
    required this.version,
    required this.color,
    this.image,
    this.child,
    this.duration,
    this.regionColor,
  }) : rarity = 1;

  GsItemDecor.rarity({
    required this.label,
    required this.version,
    required this.rarity,
    this.child,
    this.image,
    this.duration,
    this.regionColor,
  }) : color = null;
}

class _GsSearchItem extends StatelessWidget {
  final String initialValue;
  final void Function(String value) onSubmit;

  const _GsSearchItem(this.initialValue, this.onSubmit);

  void show(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => this,
  );

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: const Offset(1, 1),
                blurRadius: 10,
              ),
            ],
          ),
          width: w / 2,
          height: 44,
          alignment: Alignment.centerLeft,
          child: ExtendedTextField(
            autoFocus: true,
            initialValue: initialValue,
            hintText: 'Search',
            onEdit: (value) => 0,
            onSubmit: (value) {
              onSubmit(value);
              Navigator.of(context).maybePop();
            },
          ),
        ),
      ),
    );
  }
}
