import 'package:flutter/material.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/models/task.dart';
import 'package:inditask/ui/tasks.dart';
import 'package:inditask/ui/widgets/custom_widgets.dart';
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

class DashBoardDisplay extends StatefulWidget {
  final List<Task> tasks;
  const DashBoardDisplay(this.tasks);

  @override
  _DashBoardDisplayState createState() => _DashBoardDisplayState();
}

class _DashBoardDisplayState extends State<DashBoardDisplay> {
  int currentTask;
  List<Task> incompleteTasks;
  Carousel carousel;
  void _onCarouselChange(int newIndex) {
    setState(() {
      currentTask = newIndex;
    });
  }

  void _onCompleteSwipe() {
    print('completing item $currentTask');
    Task task = incompleteTasks[currentTask];
    task.setCompleted = 1;
    BlocProvider.of<TaskBloc>(context).add(EditTaskEvent(task));
    incompleteTasks =
        widget.tasks.where((element) => element.completed == 0).toList();
    print('i have a new list of incomplete tasks: $incompleteTasks');
    carousel = Carousel(incompleteTasks, currentTask, _onCarouselChange);
  }

  @override
  void initState() {
    currentTask = 0;
    incompleteTasks =
        widget.tasks.where((element) => element.completed == 0).toList();
    print('incomplete tasks $incompleteTasks');
    if (incompleteTasks.length == 0) {
      incompleteTasks.add(
          Task("Finish financial analysis for sonly", "09-22-2020", 50, 0));
    }
    carousel = Carousel(incompleteTasks, currentTask, _onCarouselChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF2F7FB),
      body: Column(
        children: [
          HeaderRow(),
          TasksRow(),
          carousel,
          RemaingingTimeWidget(incompleteTasks[currentTask].getDateTime()),
          CompleteWidget(_onCompleteSwipe),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return BlocProvider.value(
                  value: BlocProvider.of<TaskBloc>(context),
                  child: AddTask(
                    costToggled: false,
                  ),
                );
              });
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
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 15.0, top: 40.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset('assets/images/ribbon.png'),
        MaterialButton(
          onPressed: () {},
          color: Color(0xFF1C2638),
          textColor: Colors.white,
          child: Icon(
            Icons.settings,
            size: 20,
          ),
          padding: EdgeInsets.all(10),
          shape: CircleBorder(),
        )
      ]),
    );
  }
}

class TasksRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 14.0, top: 0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text(
                'Tasks Due:',
                style: TextStyle(
                    color: Color(0xFF272140),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0, right: 18),
                child: Image.asset('assets/images/listicon.png')),
          ],
        ),
      ),
    );
  }
}
