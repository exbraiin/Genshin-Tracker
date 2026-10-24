import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tracker/common/lang/lang.dart';
import 'package:tracker/screens/main_screen/main_screen.dart';
import 'package:tracker/theme/gs_assets.dart';
import 'package:tracker/theme/gs_langs.g.dart';
import 'package:tracker/theme/windows_bar.dart';

void main() {
  Widget app = const MyApp();
  if (Platform.isWindows) {
    app = ExcludeSemantics(child: app);
  }
  runApp(app);
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
            scrollBehavior: CupertinoScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse},
              scrollbars: false,
            ),
            localizationsDelegates: [
              AppLocalization.createDelegate(
                assets: {Locale('en'): AppLangs.en},
                fallback: Locale('en'),
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
