import 'package:dartx/dartx_io.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/static/cached_image_widget.dart';
import 'package:tracker/common/widgets/static/swap_widget.dart';
import 'package:tracker/domain/enums/enum_ext.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/theme/gs_assets.dart';

const _kItemSize = kSize50;

class HomeCalendarWidget extends StatelessWidget {
  const HomeCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().date;
    return GsDataBox.info(
      title: Row(
        children: [
          Text(context.labels.calendar()),
          Text(
            ' \u2022 ${DateLabels.humanizedMonth(context, now.month)}',
            style: context.themeStyles.label14b.copyWith(
              color: context.themeColors.sectionContent,
            ),
            strutStyle: context.themeStyles.label14b.toStrut(),
          ),
        ],
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(children: _getItems(context, now).toList()),
        ),
      ),
    );
  }

  Iterable<Widget> _getItems(BuildContext context, DateTime now) sync* {
    const kWeek = [
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday,
      DateTime.sunday,
    ];

    yield Row(
      mainAxisSize: MainAxisSize.min,
      children: kWeek
          .map<Widget>((i) {
            return Container(
              width: _kItemSize,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: GsSpacing.kGridSeparator),
              decoration: BoxDecoration(
                borderRadius: GsSpacing.kListRadius,
                color: context.themeColors.mainColor1,
              ),
              child: Text(
                DateLabels.humanizedWeekday(context, i).substring(0, 3),
                style: context.themeStyles.label14n,
                strutStyle: context.themeStyles.label14n.toStrut(),
              ),
            );
          })
          .separate(const SizedBox(width: GsSpacing.kGridSeparator))
          .toList(),
    );

    final dates = _getDatesInfo(now);
    final weeks = dates.length ~/ DateTime.daysPerWeek;
    yield* Iterable<Widget>.generate(weeks, (w) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: Iterable<Widget>.generate(DateTime.daysPerWeek, (d) {
          final idx = w * DateTime.daysPerWeek + d;
          final date = dates[idx];
          return _CalendarDay(info: date, now: now);
        }).separate(const SizedBox(width: GsSpacing.kGridSeparator)).toList(),
      );
    }).separate(const SizedBox(height: GsSpacing.kGridSeparator));
  }
}

class _RectClipperBuilder extends CustomClipper<Rect> {
  final Rect Function(Size size) clipper;

  const _RectClipperBuilder(this.clipper);

  @override
  Rect getClip(Size size) {
    return clipper(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class _ImagesTooltip extends StatelessWidget {
  final Size size;
  final Widget child;
  final String? message;
  final Iterable<String> images;

  const _ImagesTooltip({
    this.message,
    this.size = const Size(150, 85),
    required this.images,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final image0 = images.elementAtOrNull(0);
    final image1 = images.elementAtOrNull(1);
    return Tooltip(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: context.themeColors.almostWhite,
        borderRadius: BorderRadius.circular(kSeparator4),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 62, 59, 59),
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      richMessage: WidgetSpan(
        child: Container(
          width: size.width,
          height: size.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kSeparator4),
          ),
          child: Stack(
            children: [
              if (image0 != null && image1 == null)
                Positioned.fill(
                  bottom: null,
                  child: CachedImageWidget(image0, fit: BoxFit.fitWidth),
                ),
              if (image0 != null && image1 != null)
                Positioned.fill(
                  child: SwapWidgets(
                    child0: CachedImageWidget(image0, fit: BoxFit.cover),
                    child1: CachedImageWidget(image1, fit: BoxFit.cover),
                  ),
                ),
              if (message != null)
                Positioned.fill(
                  top: null,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 2),
                    color: Colors.white54,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        message!,
                        style: TooltipTheme.of(context).textStyle,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      child: child,
    );
  }
}

List<DateTime> _generateCalendarDays(DateTime now) {
  final weekday = now.firstDayOfMonth.weekday;

  final date = DateTime(now.year, now.month, 2 - weekday);
  final last = now.firstDayOfMonth;
  final diff = last.difference(date).inDays;
  final weeks = ((now.daysInMonth + diff) / DateTime.daysPerWeek).ceil();

  return List.generate(weeks * DateTime.daysPerWeek, (i) {
    final idx = i - weekday + 2;
    return DateTime(now.year, now.month, idx);
  });
}

List<_DayInfo> _getDatesInfo(DateTime now) {
  final dates = _generateCalendarDays(now);

  final banners = Database.instance.infoOf<GsBanner>();
  final versions = Database.instance.infoOf<GsVersion>();
  final characters = Database.instance.infoOf<GsCharacter>();
  final battlepasses = Database.instance.infoOf<GsBattlepass>();

  final mVersions = <DateTime, GsVersion>{};
  for (final version in versions.items) {
    mVersions[version.releaseDate] = version;
  }

  final mCharacters = <DateTime, List<GsCharacter>>{};
  for (final character in characters.items) {
    final date = character.birthday.copyWith(year: now.year);
    mCharacters[date] = [...?mCharacters[date], character];
  }

  final stDay = dates.first;
  final edDay = dates.last;
  final mBattlepasses = battlepasses.items
      .where((e) => datesIntersect(e.dateStart, e.dateEnd, stDay, edDay))
      .toList(growable: false);

  final mBanners = banners.items
      .where((e) => e.type == GeBannerType.character)
      .where((e) => datesIntersect(e.dateStart, e.dateEnd, stDay, edDay))
      .groupBy((e) => e.dateStart)
      .values;

  Color getBannersColor(List<GsBanner> banners) {
    return banners
        .map((e) => characters.getItem(e.feature5.firstOrNull ?? ''))
        .whereNotNull()
        .map((e) => e.element.color)
        .fold(Colors.white, (p, e) => Color.lerp(p, e, 0.5)!);
  }

  return dates
      .map((d) {
        return (
          date: d,
          version: mVersions[d],
          banners: mBanners
              .where((e) => d.between(e.first.dateStart, e.first.dateEnd))
              .map((e) => (getBannersColor(e), e))
              .toList(),
          battlepasses: mBattlepasses
              .where((e) => d.between(e.dateStart, e.dateEnd))
              .toList(),
          birthdays: mCharacters[d] ?? [],
        );
      })
      .sortedBy((e) => e.date);
}

bool datesIntersect(DateTime st0, DateTime ed0, DateTime st1, DateTime ed1) {
  return !st0.isAfter(ed1) && !st1.isAfter(ed0);
}

typedef _DayInfo = ({
  DateTime date,
  GsVersion? version,
  List<GsCharacter> birthdays,
  List<GsBattlepass> battlepasses,
  List<(Color, List<GsBanner>)> banners,
});

class _CalendarDay extends StatelessWidget {
  final _DayInfo info;
  final DateTime now;

  _CalendarDay({required this.info, DateTime? now})
    : now = now ?? DateTime.now().date;

  @override
  Widget build(BuildContext context) {
    final date = info.date;
    final version = info.version;
    final banners = info.banners;
    final birthdays = info.birthdays;
    final battlepasses = info.battlepasses;

    final showVersion = version != null;
    final showBirthday = birthdays.isNotEmpty;
    final tooltip = birthdays.map((e) => e.name).join(' | ');

    return Opacity(
      opacity: date.isAtSameMonthAs(now) ? 1 : kDisableOpacity,
      child: Container(
        width: _kItemSize,
        height: _kItemSize,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: GsSpacing.kGridRadius,
          color: context.themeColors.mainColor1,
        ),
        foregroundDecoration: now.isAtSameDayAs(date)
            ? BoxDecoration(
                borderRadius: GsSpacing.kGridRadius,
                border: Border.all(
                  color: context.themeColors.almostWhite,
                  width: 2,
                ),
              )
            : null,
        child: Tooltip(
          message: tooltip,
          child: Stack(
            children: [
              if (showBirthday)
                ...birthdays.mapIndexed((i, e) {
                  return Positioned.fill(
                    child: ClipRect(
                      clipper: _RectClipperBuilder(
                        (size) => Rect.fromLTWH(
                          i * size.width / birthdays.length,
                          0,
                          size.width / birthdays.length,
                          size.height,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              GsAssets.getRarityBgImage(e.rarity),
                            ),
                          ),
                        ),
                        child: CachedImageWidget(e.image),
                      ),
                    ),
                  );
                }),
              ...battlepasses.map((info) {
                final src = info.dateStart.isAtSameDayAs(date);
                final end = info.dateEnd.isAtSameDayAs(date);
                final msg = info.name;

                return Positioned.fill(
                  top: null,
                  left: src ? _kItemSize / 2 + 4 : 0,
                  right: end ? _kItemSize / 2 + 4 : 0,
                  bottom: 5,
                  child: _ImagesTooltip(
                    images: [info.image],
                    message: msg,
                    size: const Size(150, 54),
                    child: Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.themeColors.primary,
                        borderRadius: BorderRadius.horizontal(
                          left: src ? const Radius.circular(8) : Radius.zero,
                          right: end ? const Radius.circular(8) : Radius.zero,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              ...banners.map((info) {
                final (color, list) = info;

                final banner = list.first;
                final src = banner.dateStart.isAtSameDayAs(date);
                final end = banner.dateEnd.isAtSameDayAs(date);
                final message = list.map((e) => e.name).join('\n');

                return Positioned.fill(
                  top: null,
                  left: src ? _kItemSize / 2 + 4 : 0,
                  right: end ? _kItemSize / 2 + 4 : 0,
                  child: _ImagesTooltip(
                    images: list.map((e) => e.image),
                    message: message,
                    child: Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.horizontal(
                          left: src ? const Radius.circular(8) : Radius.zero,
                          right: end ? const Radius.circular(8) : Radius.zero,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              Positioned(
                right: 2,
                bottom: 2,
                child: Icon(
                  showBirthday ? Icons.cake_rounded : null,
                  size: 20,
                  color: context.themeColors.almostWhite,
                  shadows: const [
                    BoxShadow(offset: Offset(1, 1), blurRadius: 5),
                  ],
                ),
              ),
              if (showVersion)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Transform.translate(
                    offset: const Offset(12, 12),
                    child: Banner(
                      message: GsUtils.versions.getName(version.id),
                      color: context.themeColors.primary80,
                      location: BannerLocation.bottomEnd,
                    ),
                  ),
                ),
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(kSeparator2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.themeColors.mainColor0.withValues(alpha: 0.4),
                  border: Border.all(
                    color: context.themeColors.mainColor1,
                    width: 2,
                  ),
                ),
                child: Text(
                  date.day.toString(),
                  style: context.themeStyles.label12n,
                  strutStyle: context.themeStyles.label12n.toStrut(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
