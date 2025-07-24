import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tracker/common/lang/localization.dart';
import 'package:tracker/screens/main_screen/main_screen.dart';
import 'package:tracker/theme/theme.dart';
import 'package:tracker/theme/windows_bar.dart';

// TODO:
// - Move hide empty banners to filters
// - Make spincrystal sort by version sort by descending number

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: theme,
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: WindowBar(title: 'Genshin Tracker'),
          ),
        ),
        Expanded(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse},
              scrollbars: false,
              physics: const BouncingScrollPhysics(),
            ),
            localizationsDelegates: [
              AppLocalization.createDelegate(
                assets: {Locale('en'): 'assets/lang/en.json'},
              ),
            ],
            theme: theme,
            home: const MainScreen(),
          ),
        ),
      ],
    );
  }
}
