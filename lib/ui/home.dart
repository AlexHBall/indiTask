import 'package:flutter/material.dart';
import 'package:inditask/ui/tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inditask/ui/onboard/onboard.dart';

class Home extends StatelessWidget {
  Home();

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new LoadingScreen("loading");
          default:
            if (!snapshot.hasError) {
              return snapshot.data.getBool("welcome") != null
                  ? new Tasks()
                  : new OnboardingScreen();
            } else {
              return new ErrorScreen(snapshot.error);
            }
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  final String text;
  LoadingScreen(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class ErrorScreen extends StatelessWidget {
  final error;
  ErrorScreen(this.error);

  @override
  Widget build(BuildContext context) {
    return Text("Error");
  }
}
