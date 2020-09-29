import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/utils/colors.dart';
import 'package:inditask/widgets/taskmodal/add_task.dart';
import 'package:inditask/widgets/widgets.dart';

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
          return DashBoardDisplay(state.tasks);
        }
        return CircleIndicator();
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
              task: incompleteTasks[currentTask],
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
    if (incompleteTasks.length < 1) {
      // TaskCard taskCard = TaskCard(
      //   cost: 0,
      //   description: "Please add a task",
      //   backgroundColor: colors[0],
      //   onEditPress: () => {},
      // );
      // taskCards.add(taskCard);
    } else {
      for (var i = 0; i < incompleteTasks.length; i++) {
        TaskCard taskCard = TaskCard(
          task: incompleteTasks[i],
          backgroundColor: colors[i % 4],
          onEditPress: editTask,
        );
        taskCards.add(taskCard);
      }
    }
    return taskCards;
  }

  void _onCompleteSwipe() {
    setState(() {
      Task task = incompleteTasks[pageController.page.toInt()];
      task.setCompleted = 1;
      BlocProvider.of<TaskBloc>(context).add(EditTaskEvent(task));
      incompleteTasks =
          widget.tasks.where((element) => element.completed == 0).toList();

      if (currentTask == incompleteTasks.length) {
        currentTask -= 1;
      }
      if (incompleteTasks.length == 0) {
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
    setState(() {
      incompleteTasks =
          widget.tasks.where((element) => element.completed == 0).toList();
      taskCards = fillTaskCards(incompleteTasks);
    });
  }

  @override
  void initState() {
    currentTask = 0;
    incompleteTasks =
        widget.tasks.where((element) => element.completed == 0).toList();
    if (incompleteTasks.length == 0) {
      incompleteTasks.add(
          Task("Finish financial analysis for sonly", "09-25-2020", 50, 0));
    }
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskCards = fillTaskCards(incompleteTasks);
    return Scaffold(
      backgroundColor: Colour.backGrey.color,
      body: Column(
        children: [
          HeaderRow(),
          TasksRow(),
          CardView(taskCards, pageController, _onPageChanged, currentTask),
          RemaingingTimeWidget(incompleteTasks[currentTask].getDate()),
          CompleteWidget(_onCompleteSwipe),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return BlocProvider.value(
                  value: BlocProvider.of<TaskBloc>(context),
                  child: AddTask(
                    costToggled: false,
                    isModal: true,
                  ),
                  // child: LocalNotificationScreen(),
                );
              });
          _handleAddedTasks();
        },
        child: Icon(Icons.add),
        backgroundColor: Colour.blue.color,
      ),
    );
  }
}
