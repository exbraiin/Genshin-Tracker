import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/graphics/gs_style.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/characters_screen/character_details_card.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';

class CharactersTable extends StatefulWidget {
  final bool showTodo;
  final List<GsCharacter> characters;

  const CharactersTable({
    super.key,
    this.showTodo = false,
    required this.characters,
  });

  @override
  State<CharactersTable> createState() => _CharactersTableState();
}

class _CharactersTableState extends State<CharactersTable> {
  var _sorter = false;
  _TableItem? _sortItem;
  var _idSortedList = <String>[];
  late final List<_TableItem> _builders;

  @override
  void initState() {
    super.initState();
    _builders = _getBuilders(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        columnWidths: Map.fromEntries(
          _builders.mapIndexed(
            (i, e) => MapEntry(
              i,
              e.expand ? const FlexColumnWidth() : const IntrinsicColumnWidth(),
            ),
          ),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.symmetric(
          inside: BorderSide(
            color: context.themeColors.mainColor0,
          ),
        ),
        children: [
          TableRow(
            children: _builders.map((item) {
              return InkWell(
                onTap: item.sortBy != null
                    ? () {
                        setState(() {
                          if (_sortItem == null || _sortItem != item) {
                            _sorter = true;
                            _sortItem = item;
                          } else if (_sorter) {
                            _sorter = false;
                          } else {
                            _sorter = true;
                            _sortItem = null;
                          }
                          _idSortedList = _getCharsIdsSorted();
                        });
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kSeparator4,
                    horizontal: kSeparator8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        item.label,
                        textAlign: !item.expand ? TextAlign.center : null,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        _sortItem == item
                            ? _sorter
                                ? Icons.arrow_drop_up_rounded
                                : Icons.arrow_drop_down_rounded
                            : null,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          ..._getCharsSorted().map((item) {
            return TableRow(
              children: _builders.map<Widget>((e) {
                final child = Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kSeparator4,
                    horizontal: kSeparator8,
                  ),
                  child: Opacity(
                    opacity: item.isOwned ? 1 : kDisableOpacity,
                    child: e.builder(item),
                  ),
                );

                if (e.onTap != null && (e.allowTap || item.isOwned)) {
                  return InkWell(
                    onTap: () => e.onTap!(item),
                    child: child,
                  );
                }

                return child;
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  List<_TableItem> _getBuilders(BuildContext context) {
    double unowned() => _sorter ? double.infinity : double.negativeInfinity;
    return [
      _TableItem(
        label: 'Icon',
        builder: (info) => ItemCircleWidget(
          image: info.iconImage,
          size: ItemSize.large,
          rarity: info.item.rarity,
        ),
        allowTap: true,
        onTap: (info) => CharacterDetailsCard(info.item).show(context),
      ),
      _TableItem(
        label: 'Element',
        sortBy: (e) => e.item.element.index,
        builder: (info) => ItemIconWidget.asset(
          info.item.element.assetPath,
          size: ItemSize.medium,
        ),
      ),
      _TableItem(
        label: 'Name',
        sortBy: (e) => e.item.name,
        builder: (info) => Text(info.item.name),
        expand: true,
      ),
      _TableItem(
        label: 'Friendship',
        sortBy: (e) => e.isOwned ? e.friendship : unowned(),
        builder: (info) => Text(
          info.isOwned ? '${info.friendship}' : '-',
          textAlign: TextAlign.center,
        ),
        onTap: (info) =>
            GsUtils.characters.increaseFriendshipCharacter(info.item.id),
      ),
      _TableItem(
        label: 'Ascension',
        sortBy: (e) => e.isOwned ? e.ascension : unowned(),
        builder: (info) => Text(
          info.isOwned ? '${info.ascension} ✦' : '-',
          textAlign: TextAlign.center,
        ),
        onTap: (info) => GsUtils.characters.increaseAscension(info.item.id),
      ),
      _TableItem(
        label: 'Constellations',
        sortBy: (e) => e.isOwned ? e.totalConstellations : unowned(),
        builder: (info) => Text.rich(
          info.isOwned
              ? TextSpan(
                  children: [
                    TextSpan(text: 'C${info.constellations}'),
                    if (info.extraConstellations > 0)
                      TextSpan(
                        text: ' (+${info.extraConstellations})',
                        style: const TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                )
              : const TextSpan(text: '-'),
          textAlign: TextAlign.center,
        ),
      ),
      ...CharTalentType.values.map((e) => _talentTableItem(e)),
      _TableItem(
        label: 'Tal. T',
        sortBy: (e) => e.talents?.total ?? unowned(),
        builder: (info) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                info.talents?.total.toString() ?? '-',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      (info.talents?.total ?? 0) >= 30 ? Colors.yellow : null,
                ),
              ),
              if ((info.talents?.total ?? 0) >= 30)
                const Padding(
                  padding: EdgeInsets.only(left: kSeparator2),
                  child: Icon(
                    Icons.star_rounded,
                    color: Colors.yellow,
                  ),
                ),
            ],
          );
        },
      ),
    ];
  }

  _TableItem _talentTableItem(CharTalentType tal) {
    double unowned() => _sorter ? double.infinity : double.negativeInfinity;

    /// TODO: Localize labels...
    final label = switch (tal) {
      CharTalentType.attack => 'Tal. A',
      CharTalentType.skill => 'Tal. E',
      CharTalentType.burst => 'Tal. Q',
    };

    return _TableItem(
      label: label,
      sortBy: (e) => e.talents?.talent(tal) ?? unowned(),
      builder: (info) {
        final value = info.talents?.talentWithExtra(tal);
        final hasExtra = info.talents?.hasExtra(tal) ?? false;
        return Text(
          value?.toString() ?? '-',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: hasExtra ? Colors.lightBlue : null,
          ),
        );
      },
      onTap: (info) => GsUtils.characters.increaseTalent(info.item.id, tal),
    );
  }

  Iterable<CharInfo> _getCharsSorted() {
    final info = GsUtils.characters.getCharInfo;
    var chars = widget.characters.map((e) => info(e.id)).whereNotNull();
    if (_idSortedList.isNotEmpty) {
      chars = chars.sortedBy((e) => _idSortedList.indexOf(e.item.id));
    }
    return chars;
  }

  List<String> _getCharsIdsSorted() {
    if (_sortItem == null) return const [];

    final info = GsUtils.characters.getCharInfo;
    final chars = widget.characters.map((e) => info(e.id)).whereNotNull();
    final sorted = _sorter ? chars.sortedBy : chars.sortedByDescending;

    return sorted((e) => _sortItem!.sortBy?.call(e) ?? 0)
        .thenBy((e) => e.item.name)
        .map((e) => e.item.id)
        .toList();
  }
}

class _TableItem {
  final String label;
  final bool expand;
  final bool allowTap;
  final Comparable Function(CharInfo)? sortBy;
  final void Function(CharInfo info)? onTap;
  final Widget Function(CharInfo info) builder;

  _TableItem({
    this.sortBy,
    required this.label,
    required this.builder,
    this.onTap,
    this.expand = false,
    this.allowTap = false,
  });
}
