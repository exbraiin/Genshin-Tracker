import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/theme/theme.dart';

abstract class GsDatabaseExporter {
  static Future<void> export() async {
    final excel = Excel.createExcel();

    writeWishes(excel, 'Character Event', GeBannerType.character);
    writeWishes(excel, 'Weapon Event', GeBannerType.weapon);
    writeWishes(excel, 'Standard', GeBannerType.standard);
    writeWishes(excel, 'Beginners\' Wish', GeBannerType.beginner);

    writeBanners(excel, 'Banner List');

    writePaimonMoeInformation(excel, 'Information');

    excel.delete('Sheet1');
    final bytes = excel.encode()!;
    final date = DateTime.now().format().replaceAll(':', '-');
    await Directory('export').create();
    await File('export/$date.xlsx').writeAsBytes(bytes);
    if (Platform.isWindows) await Process.run('explorer', ['.']);
    if (kDebugMode) print('\x1b[31mComplete!');
  }

  static void writeWishes(Excel excel, String sheetName, GeBannerType type) {
    final db = Database.instance;
    final list = GsUtils.wishes.getSaveWishesSummaryByBannerType(type);
    final sheet = excel[sheetName];

    final rows = <_Row>[];
    final wishes = list.sortedDescending();

    for (final wish in wishes) {
      final item = wish.item;
      final banner = db.infoOf<GsBanner>().getItem(wish.wish.bannerId);
      final pity = wish.pity;

      if (banner == null) continue;
      final row = _Row(
        type: item.isWeapon ? 'Weapon' : 'Character',
        name: item.name,
        date: wish.wish.date.format(),
        rarity: item.rarity,
        pity: pity,
        roll: wish.wish.number,
        banner: banner.name,
      );
      rows.add(row);
    }

    sheet.appendRow(
      [
        'Type',
        'Name',
        'Time',
        '⭐',
        'Pity',
        '#Roll',
        'Group',
        'Banner',
      ].map(TextCellValue.new).toList(),
    );
    sheet.applyStyleToRow(
      sheet.maxRows - 1,
      CellStyle(
        bold: true,
        fontSize: 10,
        fontFamily: defaultFontFamily,
        verticalAlign: VerticalAlign.Center,
        horizontalAlign: HorizontalAlign.Center,
      ),
    );

    final st = CellStyle(
      fontSize: 10,
      fontFamily: defaultFontFamily,
      verticalAlign: VerticalAlign.Center,
    );

    var group = 0;
    var bg = false;
    final reversed = rows.reversed.toList();
    for (var i = 0; i < reversed.length; ++i) {
      final last = i > 0 ? reversed[i - 1] : null;
      final item = reversed[i];
      if (last == null || last.banner != item.banner) group = 0;
      if (last == null || last.date != item.date) {
        group++;
        bg = !bg;
      }

      final hexColor = switch (item.rarity) {
        5 => 'FFCC9832',
        4 => 'FF8A6995',
        _ => 'FF000000',
      };

      final fgColor = ExcelColor.fromHexString(hexColor);
      final bgColor = ExcelColor.fromHexString(bg ? 'FFEEEEEE' : 'none');
      final s = st.copyWith(
        fontColorHexVal: fgColor,
        boldVal: item.rarity > 3,
        backgroundColorHexVal: bgColor,
      );
      item.addToSheet(sheet, group, s);
    }
  }

  static void writeBanners(Excel excel, String sheetName) {
    final db = Database.instance;
    final list = db
        .infoOf<GsBanner>()
        .items
        .sortedBy((e) => _bannerType(e.type))
        .thenBy((e) => e.dateStart);
    final sheet = excel[sheetName];
    sheet.appendRow(['Name', 'Start', 'End'].map(TextCellValue.new).toList());
    for (final banner in list) {
      sheet.appendRow([
        TextCellValue(banner.name),
        TextCellValue(banner.dateStart.format(showHour: false)),
        TextCellValue(banner.dateEnd.format(showHour: false)),
      ]);
    }
  }

  static void writePaimonMoeInformation(Excel excel, String sheetName) {
    final sheet = excel[sheetName];

    sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('B1'));
    sheet.appendRow([TextCellValue('Paimon.moe Wish History Export')]);
    sheet.appendRow([TextCellValue('Version'), const IntCellValue(3)]);
    sheet.appendRow(
      ['Export Date', DateTime.now().format()].map(TextCellValue.new).toList(),
    );
  }
}

class _Row {
  final String type;
  final String name;
  final String date;
  final int rarity;
  final int pity;
  final int roll;
  final String banner;

  _Row({
    required this.type,
    required this.name,
    required this.date,
    required this.rarity,
    required this.pity,
    required this.roll,
    required this.banner,
  });

  void addToSheet(Sheet sheet, int group, CellStyle style) {
    final rows = sheet.maxRows;
    final data = [
      TextCellValue(type),
      TextCellValue(name),
      TextCellValue(date),
      IntCellValue(rarity),
      IntCellValue(pity),
      IntCellValue(roll),
      IntCellValue(group),
      TextCellValue(banner),
    ];
    final cStyle = style.copyWith(horizontalAlignVal: HorizontalAlign.Center);
    for (var i = 0; i < data.length; ++i) {
      final idx = CellIndex.indexByColumnRow(columnIndex: i, rowIndex: rows);
      final stl = data[i] is IntCellValue ? cStyle : style;
      sheet.updateCell(idx, data[i], cellStyle: stl);
    }
  }
}

int _bannerType(GeBannerType banner) {
  return [
    GeBannerType.beginner,
    GeBannerType.standard,
    GeBannerType.character,
    GeBannerType.weapon,
  ].indexOf(banner);
}

extension on Sheet {
  void applyStyleToRow(int index, CellStyle style) {
    final row = this.row(index);
    row.forEachIndexed(
      (_, i) =>
          cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: index))
              .cellStyle = style,
    );
  }
}
