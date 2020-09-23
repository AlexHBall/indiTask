import 'package:flutter/material.dart';
import 'package:inditask/bloc/tab/tab_bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/ui/dashboard/dash.dart';
import 'package:inditask/ui/dashboard/dashboard.dart';
import 'package:inditask/ui/stats/statistics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inditask/ui/onboard/onboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/repository/task_repository.dart';

class Home extends StatelessWidget {
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
                  ? Dash()
                  : OnboardingScreen();
            } else {
              return new ErrorScreen(snapshot.error);
            }
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        // return  activeTab == AppTab.tasks ? Dash() : OnboardingScreen();
        return FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new LoadingScreen("loading");
              default:
                if (!snapshot.hasError) {
                  return snapshot.data.getBool("welcome") != null
                      ? (activeTab == AppTab.tasks) ? Dash() : StatisticsBody()
                      : OnboardingScreen();
                } else {
                  return new ErrorScreen(snapshot.error);
                }
            }
          },
        );
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
