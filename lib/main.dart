import 'package:flutter/material.dart';
import 'package:inditask/ui/dashboard/dash.dart';
import 'package:inditask/utils/utils.dart';
import 'package:inditask/ui/home.dart';

void main() {
  runApp(
    ThisApp()
  );
}

class ThisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: basicTheme(),
      home: Home(),
      routes: {
        "/dash": (context) => Dash(),
      },
    );
  }
}
