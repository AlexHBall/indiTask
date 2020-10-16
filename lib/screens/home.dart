import 'package:flutter/material.dart';
import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/screens/dashboard/dashboard.dart';
import 'package:inditask/screens/screens.dart';
import 'package:inditask/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inditask/screens/onboard/onboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        Widget _getActivePage() {
          if (activeTab == AppTab.tasks) {
            return Dashboard();
          } else if (activeTab == AppTab.stats) {
            return StatsDash();
          } else if (activeTab == AppTab.add) {
            return InitialScreen();
          }
          return OnboardingScreen();
        }

        return FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new CircleIndicator();
              default:
                if (!snapshot.hasError) {
                  bool onboardCompleted = snapshot.data.getBool("welcome");
                  print('onboard $onboardCompleted');
                  if (onboardCompleted == null) {
                    activeTab = AppTab.onboard;
                  }
                  return _getActivePage();
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

class ErrorScreen extends StatelessWidget {
  final error;
  ErrorScreen(this.error);

  @override
  Widget build(BuildContext context) {
    return Text("Error");
  }
}
