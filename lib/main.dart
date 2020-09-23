import 'package:flutter/material.dart';
import 'package:inditask/bloc/stat/stat_bloc.dart';
import 'package:inditask/bloc/tab/tab_bloc.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:inditask/repository/task_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/ui/home.dart';
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
      title: "IndiTask",
      debugShowCheckedModeBanner: true,
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
        // '/stats' : (context) => MultiBlocProvider(
        //   providers: [
        //     BlocProvider(
        //       create: (context) => SubjectBloc(),
        //     ),
        //     BlocProvider(
        //       create: (context) => SubjectBloc(),
        //     ),
        //   ],
        //   child: Stats(),
        // )
      },
    );
  }
}
