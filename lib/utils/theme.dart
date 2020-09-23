import 'package:flutter/material.dart';

//The purpose here is COLOURS, FONTS, TEXT STYLES
ThemeData basicTheme() {
  String fontFamily = 'MontSerrat';
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        bodyText1: base.bodyText1.copyWith(
            color: Color(0xFF1C2638),
            fontFamily: fontFamily,
            fontSize: 18,
            fontStyle: FontStyle.normal
        ),
        bodyText2: base.bodyText2.copyWith(
            color: Color(0xFFFFF),
            fontFamily: fontFamily,
            fontSize: 18,
            fontStyle: FontStyle.normal));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),);
}