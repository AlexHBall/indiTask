import 'package:flutter/material.dart';
import 'package:inditask/bloc/tab/tab_bloc.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/ui/dashboard/dashboard.dart';
import 'package:inditask/ui/stats/statistics.dart';
import 'package:inditask/ui/widgets/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inditask/ui/onboard/onboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        Widget _getActivePage() {
          if (activeTab == AppTab.tasks) {
            return Dashboard();
          } else if (activeTab == AppTab.add) {
            return InitialScreen();
          } else if (activeTab == AppTab.stats) {
            return StatsDash();
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
                return new LoadingScreen("loading");
              default:
                if (!snapshot.hasError) {
                  bool onboardCompleted = snapshot.data.getBool("welcome");

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

class InitialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskWidget();
  }
}

class TaskWidget extends State<InitialScreen> {
  Column initialPage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 142.0),
          child: Image.asset('assets/images/logoSmall.png'),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 28.0, left: 55.0, right: 50.0, bottom: 20.0),
          child: Text("Create your first task",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C2638))),
        ),
        AddTask(costToggled: false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F7FB),
      resizeToAvoidBottomPadding: false,
      body: initialPage(),
    );
  }
}
