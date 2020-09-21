import 'package:flutter/material.dart';
import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/ui/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inditask/ui/onboard/onboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/repository/task_repository.dart';
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
                  ? new BlocProvider(
                      create: (context) {
                        return TaskBloc(
                          taskRepo: TaskRepository(),
                        )..add(LoadTasksEvent());
                      },
                      child: Dashboard(),
                    )
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
