import 'package:flutter/material.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TaskLoading) {
          return CircularProgressIndicator();
        }
        else if (state is NoTasks) {
          return Text("No tasks");
        } 
        else if (state is TasksLoaded) {
          return Text("Tasks");

        }
        return Container();
      },
    );
  }
}