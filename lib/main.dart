import 'package:flutter/material.dart';
import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/screens/home.dart';
import 'package:inditask/utils/theme.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) {
        return TaskBloc(
          taskRepo: TaskRepository(),
        )..add(LoadTasksEvent());
      },
      child: IndiTodos(),
    ),
  );
}

class IndiTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
      title: "IndiTask",
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      // theme: themeD.theme,
      routes: {
        '/': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<TabBloc>(
                  create: (context) => TabBloc(),
                ),
                BlocProvider<StatBloc>(
                  create: (context) =>
                      StatBloc(taskBloc: BlocProvider.of<TaskBloc>(context)),
                ),
              ],
              child: HomeScreen(),
            ),
      },
    );
  }
}
