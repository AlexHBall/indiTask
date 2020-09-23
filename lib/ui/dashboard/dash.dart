import 'package:flutter/material.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/ui/dashboard/dashboard.dart';
import 'package:inditask/ui/widgets/custom_widgets.dart';

class Dash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          List<Task> incompleteTasks =
              state.tasks.where((element) => element.completed == 0).toList();

          if (incompleteTasks.length == 0) {
            return InitialScreen();
          }
          return Dashboard();
        } else {
          return Center(
            child: Text("Error"),
          );
        }
      },
    );
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