import 'package:flutter/material.dart';
import 'package:inditask/bloc/task_bloc.dart';
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

        }
        else if (state is NoTasks) {

        } 
        else if (state is TasksLoaded) {

        } else {
          
        }
        return Container();
      },
    );
  }
}