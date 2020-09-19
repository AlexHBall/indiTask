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
      // //textTheme: Typography().white,
      // primaryColor: Color(0xff01579b),
      // //primaryColor: Color(0xff4829b2),
      // indicatorColor: Color(0xFF807A6B),
      // scaffoldBackgroundColor: Color(0xFFF2F7FB),
      // accentColor: Color(0xFF4f83cc),
      // iconTheme: IconThemeData(
      //   color: Colors.white,
      //   size: 20.0,
      // ),
      // buttonColor: Colors.amber,
      // backgroundColor: Color(0xFFffc107),
      // tabBarTheme: base.tabBarTheme.copyWith(
      //   labelColor: Color(0xffce107c),
      //   unselectedLabelColor: Colors.grey,
      // ));
}