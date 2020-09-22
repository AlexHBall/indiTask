import 'package:flutter/material.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/models/task.dart';
import 'package:inditask/ui/tasks.dart';
import 'package:inditask/ui/widgets/timer.dart';
import 'package:carousel_slider/carousel_slider.dart';
part 'carosel.dart';
part 'footer.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        print("State has changed to $state  ");
      },
      builder: (
        context,
        state,
      ) {
        if (state is TasksLoaded) {
          if (state.tasks.length == 0) {
            return InitialScreen();
          }
          return DashBoardDisplay(state.tasks);
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class DashBoardDisplay extends StatelessWidget {
  final List<Task> tasks;
  const DashBoardDisplay(this.tasks);
  @override
  Widget build(BuildContext context) {
    Task firstTask = tasks.first;

    return Scaffold(
      backgroundColor: Color(0XFFF2F7FB),
      body: Column(
        children: [
          HeaderRow(),
          TasksRow(),
          CarouselWithIndicatorDemo(),
          // TaskCarosel(
          //     cost: firstTask.cost,
          //     description: firstTask.description,
          //     backgroundColor: Color(0xFF1C2638)),
          RemaingingTimeWidget(this.tasks.first.getDateTime()),
          CompleteWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0XFF1C2638),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Image.asset('assets/images/ribbon.png')),
      MaterialButton(
        onPressed: () {},
        color: Colors.blue,
        textColor: Colors.white,
        child: Icon(
          Icons.settings,
          size: 24,
        ),
        padding: EdgeInsets.all(16),
        shape: CircleBorder(),
      )
    ]);
  }
}

class TasksRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 14.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tasks Due:',
              style: TextStyle(
                  color: Color(0xFF272140),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Image.asset('assets/images/listicon.png')),
          ],
        ),
      ),
    );
  }
}
