import 'package:flutter/material.dart';

abstract final class GsSpacing {
  static const kMainShadow = [
    BoxShadow(color: Color(0x80111111), blurRadius: 1, offset: Offset(1, 1)),
  ];

  static const kMainShadowText = [
    BoxShadow(color: Colors.black38, offset: Offset(1, 1)),
  ];

  static const kListPadding = EdgeInsets.all(4);
  static const kGridSeparator = 4.0;
  static const kListSeparator = 2.0;
  static const kGridRadius = BorderRadius.all(Radius.circular(4));
  static const kListRadius = BorderRadius.all(Radius.circular(4));
}

const double kSeparator2 = 2;
const double kSeparator4 = 4;
const double kSeparator6 = 6;
const double kSeparator8 = 8;
const double kSeparator16 = 16;
const double kDisableOpacity = 0.4;

const double kSize44 = 44;
const double kSize50 = 50;
const double kSize56 = 56;
const double kSize70 = 70;
