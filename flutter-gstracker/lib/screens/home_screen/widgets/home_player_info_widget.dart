import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/utils/logger.dart';
import 'package:tracker/common/widgets/cards/gs_data_box.dart';
import 'package:tracker/common/widgets/gs_no_results_state.dart';
import 'package:tracker/common/widgets/gs_number_field.dart';
import 'package:tracker/common/widgets/static/cached_image_widget.dart';
import 'package:tracker/common/widgets/static/value_stream_builder.dart';
import 'package:tracker/common/widgets/value_notifier_builder.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/remote/enka_service.dart';
import 'package:tracker/screens/widgets/item_info_widget.dart';
import 'package:tracker/theme/gs_assets.dart';

class HomePlayerInfoWidget extends StatelessWidget {
  const HomePlayerInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueNotifierBuilder<bool>(
      value: false,
      builder: (context, notifier, child) {
        final busy = notifier.value;

        void busyFetch(String id) {
          notifier.value = true;
          _fetchAndInsert(id)
              .onError((_, _) => GsUtils.playerConfigs.deletePlayerInfo())
              .whenComplete(() => notifier.value = false);
        }

        return ValueStreamBuilder<bool>(
          stream: Database.instance.loaded,
          builder: (context, snapshot) {
            final info = GsUtils.playerConfigs.getPlayerInfo();
            final hasValidId = info?.uid.length == 9;
            return GsDataBox.info(
              title: Row(
                children: [
                  Text(context.labels.cardPlayerInfo()),
                  Expanded(
                    child: GsNumberField(
                      enabled: !busy,
                      align: TextAlign.right,
                      onDbUpdate: () {
                        final info = GsUtils.playerConfigs.getPlayerInfo();
                        return int.tryParse(info?.uid ?? '') ?? 0;
                      },
                      onUpdate: (i) {
                        if (i == 0) {
                          GsUtils.playerConfigs.deletePlayerInfo();
                          return;
                        }

                        if (info?.uid == i.toString()) return;
                        busyFetch(i.toString());
                      },
                    ),
                  ),
                  busy
                      ? Container(
                          width: 24,
                          height: 24,
                          margin: const EdgeInsets.all(8),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : IconButton(
                          color: Colors.white,
                          disabledColor: context.themeColors.dimWhite,
                          onPressed: info != null && hasValidId
                              ? () => busyFetch(info.uid)
                              : null,
                          icon: const Icon(Icons.refresh_rounded),
                        ),
                ],
              ),
              child: info == null || info.nickname.isEmpty
                  ? const GsNoResultsState.small()
                  : _getWidgetContent(context, info),
            );
          },
        );
      },
    );
  }

  Widget _getWidgetContent(BuildContext context, GiPlayerInfo info) {
    final child = DefaultTextStyle(
      style:
          context.textTheme.bodyMedium?.copyWith(color: Colors.white) ??
          const TextStyle(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kSeparator8,
          vertical: kSeparator4,
        ),
        child: Column(
          children: [
            Row(
              children: [
                FutureBuilder(
                  future: EnkaService.i.getProfilePictureUrl(info.avatarId),
                  builder: (context, snapshot) {
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      foregroundDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: context.themeColors.almostWhite,
                        ),
                      ),
                      child: ItemGridWidget(
                        rarity: 0,
                        size: kSize70,
                        urlImage: snapshot.data ?? '',
                      ),
                    );
                  },
                ),
                const SizedBox(width: kSeparator8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.nickname,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        context.labels.cardPlayerArWl(
                          info.level,
                          info.worldLevel,
                        ),
                        maxLines: 1,
                        style: TextStyle(color: context.themeColors.dimWhite),
                      ),
                      Text(
                        info.signature,
                        maxLines: 1,
                        style: TextStyle(color: context.themeColors.dimWhite),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: kSeparator8),
                _playerInfoTable(context, info),
              ],
            ),
            const SizedBox(height: kSeparator8),
            ...info.avatars.entries
                .chunked(6)
                .map<Widget>((list) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: list
                        .map((e) {
                          final char = Database.instance
                              .infoOf<GsCharacter>()
                              .items
                              .firstOrNullWhere((c) => c.enkaId == e.key);
                          if (char == null) return const SizedBox();
                          return ItemGridWidget.character(char, size: kSize56);
                        })
                        .separate(
                          const SizedBox(width: GsSpacing.kGridSeparator),
                        )
                        .toList(),
                  );
                })
                .separate(const SizedBox(height: GsSpacing.kGridSeparator)),
          ],
        ),
      ),
    );

    return FutureBuilder<String>(
      future: EnkaService.i.getNamecardUrl(info.namecardId),
      builder: (context, snaphot) {
        final url = snaphot.data;
        return Container(
          decoration: url != null
              ? BoxDecoration(
                  borderRadius: GsSpacing.kGridRadius,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(url).resizeIfNeeded(),
                    fit: BoxFit.cover,
                    opacity: 0.5,
                  ),
                )
              : null,
          padding: const EdgeInsets.all(kSeparator4),
          child: child,
        );
      },
    );
  }

  Widget _playerInfoTable(BuildContext context, GiPlayerInfo info) {
    final labelStyle = TextStyle(color: context.themeColors.dimWhite);
    const valueStyle = TextStyle(
      shadows: [BoxShadow(blurRadius: 2, offset: Offset(2, 2))],
    );

    TableRow row({
      required String label,
      required String asset,
      required String content,
    }) {
      return TableRow(
        children: [
          Text(content, textAlign: TextAlign.end, style: valueStyle),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
            child: Image.asset(asset, width: 16, height: 16),
          ),
          Text(label, textAlign: TextAlign.start, style: labelStyle),
        ],
      );
    }

    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: IntrinsicColumnWidth(),
        2: IntrinsicColumnWidth(),
      },
      children: [
        row(
          label: context.labels.cardPlayerAchievements(),
          content: context.labels.cardPlayerAchievementsValue(
            info.achievements.format(),
          ),
          asset: AppAssets.playerAchievements,
        ),
        row(
          label: context.labels.cardPlayerAbyss(),
          content: context.labels.cardPlayerAbyssValue(
            info.towerFloor,
            info.towerChamber,
            info.towerStars,
          ),
          asset: AppAssets.playerAbyss,
        ),
        row(
          label: context.labels.cardPlayerTheater(),
          content: context.labels.cardPlayerTheaterValue(
            info.theaterAct,
            info.theaterStars,
          ),
          asset: AppAssets.playerTheater,
        ),
        row(
          label: context.labels.cardPlayerStygian(),
          content: context.labels.cardPlayerStygianValue(
            info.stygianSeconds,
            info.stygianIndex,
          ),
          asset: GsAssets.getStygianIcon(info.stygianIndex),
        ),
      ],
    );
  }
}

Future<void> _fetchAndInsert(String uid) async {
  try {
    Monitor.debug('Fetching profile $uid');
    final player = await EnkaService.i.getPlayerInfo(uid);
    final item = player.toGiPlayerInfo();
    GsUtils.playerConfigs.update(item);
  } catch (error) {
    Monitor.error('Error fetching profile: $error');
  }
}
