import 'package:flutter/material.dart';
import 'package:gsdatabase/gsdatabase.dart';
import 'package:tracker/common/extensions/extensions.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/common/widgets/static/cached_image_widget.dart';
import 'package:tracker/domain/gs_database.dart';
import 'package:tracker/screens/home_screen/widgets/home_ascension_widget.dart';
import 'package:tracker/screens/home_screen/widgets/home_calendar_widget.dart';
import 'package:tracker/screens/home_screen/widgets/home_friends_widget.dart';
import 'package:tracker/screens/home_screen/widgets/home_last_banner_widget.dart';
import 'package:tracker/screens/home_screen/widgets/home_player_info_widget.dart';
import 'package:tracker/screens/home_screen/widgets/home_player_progress.dart';
import 'package:tracker/screens/home_screen/widgets/home_talents_widget.dart';
import 'package:tracker/screens/home_screen/widgets/home_wish_values.dart';
import 'package:tracker/screens/widgets/inventory_page.dart';
import 'package:tracker/theme/gs_assets.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _notifier = ValueNotifier(true);

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InventoryPage(
      appBar: InventoryAppBar(
        iconAsset: AppAssets.appIcon,
        label: context.labels.home(),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _notifier,
            builder: (context, value, child) {
              return IconButton(
                icon: Icon(
                  value
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
                onPressed: () => _notifier.value = !_notifier.value,
              );
            },
          ),
        ],
      ),
      child: InventoryBox(
        child: Stack(
          children: [
            Positioned.fill(
              child: ValueListenableBuilder<bool>(
                valueListenable: _notifier,
                builder: (context, value, child) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: value ? 0.05 : 1,
                    child: child,
                  );
                },
                child: CachedImageWidget(
                  GsUtils.versions.getCurrentVersion()?.image,
                  fit: BoxFit.cover,
                  scaleToSize: false,
                  showPlaceholder: false,
                ),
              ),
            ),
            Positioned.fill(
              child: ValueListenableBuilder<bool>(
                valueListenable: _notifier,
                builder: (context, value, child) {
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: value ? 1 : 0,
                    child: child,
                  );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: _widgets(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgets(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children:
                <Widget>[
                      const HomeWishesValues(banner: GeBannerType.character),
                      const HomeWishesValues(banner: GeBannerType.chronicled),
                      const HomeWishesValues(banner: GeBannerType.beginner),
                    ]
                    .separate(const SizedBox(height: GsSpacing.kGridSeparator))
                    .toList(),
          ),
        ),
        const SizedBox(width: GsSpacing.kGridSeparator),
        Expanded(
          child: Column(
            children:
                <Widget>[
                      const HomeWishesValues(banner: GeBannerType.weapon),
                      const HomeWishesValues(banner: GeBannerType.standard),
                      const HomeCalendarWidget(),
                    ]
                    .separate(const SizedBox(height: GsSpacing.kGridSeparator))
                    .toList(),
          ),
        ),
        const SizedBox(width: GsSpacing.kGridSeparator),
        Expanded(
          child: Column(
            children:
                <Widget>[
                      const HomePlayerInfoWidget(),
                      const HomePlayerProgress(),
                      const HomeTalentsWidget(),
                      const HomeFriendsWidget(),
                      const HomeAscensionWidget(),
                      const HomeLastBannerWidget(),
                    ]
                    .separate(const SizedBox(height: GsSpacing.kGridSeparator))
                    .toList(),
          ),
        ),
      ],
    );
  }
}
