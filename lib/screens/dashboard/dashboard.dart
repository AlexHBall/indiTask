import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/screens/initial.dart';
import 'package:inditask/utils/colors.dart';
import 'package:inditask/utils/notification_handler.dart';
import 'package:inditask/utils/utils.dart';
import 'package:inditask/widgets/taskmodal/add_task.dart';
import 'package:inditask/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'taskcard.dart';
part 'widgets.dart';
part 'cardview.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {},
      builder: (
        context,
        state,
      ) {
        if (state is TasksLoaded) {
          List<Task> incompleteTasks =
              state.tasks.where((t) => t.completed == 0).toList();
          if (incompleteTasks.length < 1) {
            return InitialScreen();
          } else {
            return DashBoardDisplay(incompleteTasks);
          }
        }
        return CircleIndicator();
      },
    );
  }
}

class Dash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          List<Task> tasks =
              state.tasks.where((element) => element.completed == 0).toList();
          print("incomplete tasks $tasks");
          return Scaffold(
            backgroundColor: Colors.pink,
            body: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Container(
                      color: Colors.purple,
                      child: Text(
                        tasks[index].toString(),
                        style: TextStyle(color: Colors.white),
                      ));
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                print("I'm waiting for modal");

                await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext bc) {
                      return BlocProvider.value(
                        value: BlocProvider.of<TaskBloc>(context),
                        child: AddTask(
                          costToggled: false,
                          isModal: true,
                        ),
                      );
                    });
                print("I've waited for modal");
              },
              child: Icon(Icons.add),
              backgroundColor: Colour.blue.color,
            ),
          );
        }
        return Container();
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
  List<TaskCard> taskCards;
  PageController pageController;

  void editTask() async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return BlocProvider.value(
            value: BlocProvider.of<TaskBloc>(context),
            child: AddTask(
              costToggled: false,
              isModal: true,
              task: widget.tasks[currentTask],
            ),
          );
        });
    _handleAddedTasks();
    // incompleteTasks[currentTask];
  }

  List<TaskCard> fillTaskCards(tasks) {
    List<Color> colors = [
      Colour.blue.color,
      Colour.lightBlue.color,
      Colour.green.color,
      Colour.orange.color
    ];
    taskCards = <TaskCard>[];

    for (var i = 0; i < widget.tasks.length; i++) {
      TaskCard taskCard = TaskCard(
        task: widget.tasks[i],
        backgroundColor: colors[i % 4],
        onEditPress: editTask,
      );
      taskCards.add(taskCard);
    }

    return taskCards;
  }

  void _onCompleteSwipe() {
    setState(() {
      print("remaing task length " + widget.tasks.length.toString());

      Task task = widget.tasks[pageController.page.toInt()];
      task.setCompleted = 1;
      BlocProvider.of<TaskBloc>(context).add(EditTaskEvent(task));
      print("remaing task length " + widget.tasks.length.toString());
      if (currentTask == widget.tasks.length) {
        currentTask -= 1;
      }
      if (widget.tasks.length == 0) {
        BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.add));
      }
    });
  }

  void _onPageChanged(index) {
    setState(() {
      currentTask = index;
    });
  }

  void _handleAddedTasks() {
    print("I'm handling added tasks before $widget.tasks");
    setState(() {
      print("tasks now $widget.tasks");
      taskCards = fillTaskCards(widget.tasks);
    });
  }

  @override
  void initState() {
    currentTask = 0;
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    taskCards = fillTaskCards(widget.tasks);
    return Scaffold(
      backgroundColor: Colour.backGrey.color,
      body: Column(
        children: [
          HeaderRow(),
          TasksRow(),
          CardView(taskCards, pageController, _onPageChanged, currentTask),
          RemaingingTimeWidget(widget.tasks[currentTask].getDate()),
          CompleteWidget(_onCompleteSwipe),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("I'm waiting for modal");

          await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext bc) {
                return BlocProvider.value(
                  value: BlocProvider.of<TaskBloc>(context),
                  child: AddTask(
                    costToggled: false,
                    isModal: true,
                  ),
                );
              });
          print("I've waited for modal");
          _handleAddedTasks();
        },
        child: Icon(Icons.add),
        backgroundColor: Colour.blue.color,
      ),
    );
  }
}
