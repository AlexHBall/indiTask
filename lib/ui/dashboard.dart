import 'package:flutter/material.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/models/task.dart';
import 'package:inditask/ui/tasks.dart';
import 'package:inditask/ui/widgets/timer.dart';

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
    return Scaffold(
      backgroundColor: Color(0XFFF2F7FB),
      body: Column(
        children: [
          HeaderRow(),
          TasksRow(),
          //TODO: Carosell here,
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

class TimeRemaining extends StatefulWidget {
  final DateTime endTime;
  TimeRemaining({Key key, @required this.endTime}) : super(key: key);

  @override
  _TimeRemainingState createState() => _TimeRemainingState();
}

class _TimeRemainingState extends State<TimeRemaining> {
  @override
  Widget build(BuildContext context) {
    // var t = widget.endTime.millisecondsSinceEpoch;
    // var t2 = DateTime.now().millisecondsSinceEpoch;
    // print(t - t2);
    return CountdownTimer(
      //TODO: Why is diff coming up negative here ?
      // endTime:  widget.endTime.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch,
      endTime: DateTime.now().millisecondsSinceEpoch + 100000 * 60 * 60,
      defaultDays: "==",
      defaultHours: "--",
      defaultMin: "**",
      defaultSec: "++",
      daysSymbol: "day ",
      hoursSymbol: "hr ",
      minSymbol: "min ",
      secSymbol: "sec",
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1C2638)),
    );
  }
}

class RemaingingTimeWidget extends StatelessWidget {
  final DateTime timeLeft;
  const RemaingingTimeWidget(this.timeLeft);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 65.0,
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
              child: Icon(
                Icons.alarm,
                size: 24,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                child: TimeRemaining(
                  endTime: timeLeft,
                )),
          ],
        ),
      ),
    );
  }
}

class CompleteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 65.0,
          child: Dismissible(
            onDismissed: (DismissDirection direction) async {
              print("MARK ME AS COMPLETE");
            },
            key: UniqueKey(),
            child: Row(
              children: [
                Container(
                  height: 65.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1C2638),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Image.asset('assets/images/swipeIcon.png')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text("Swipe to complete",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C2638))),
                ),
              ],
            ),
          ),
        ));
  }
}
