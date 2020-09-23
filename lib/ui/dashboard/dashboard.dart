import 'package:flutter/material.dart';
import 'package:inditask/bloc/tab/tab.dart';
import 'package:inditask/bloc/tab/tab_bloc.dart';
import 'package:inditask/bloc/task/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/models/task.dart';
import 'package:inditask/ui/dashboard/cardview.dart';
import 'package:inditask/ui/widgets/custom_widgets.dart';
import 'package:inditask/ui/widgets/timer.dart';
part 'taskcard.dart';
part 'widgets.dart';

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
  List<TaskCard> taskCards;
  PageController pageController;

  List<TaskCard> fillTaskCards(tasks) {
    List<Color> colors = [
      Color(0xFF1C2638),
      Color(0XFF9BBFD6),
      Color(0XFF108B00),
      Color(0XFFFF8C00)
    ];
    taskCards = <TaskCard>[];
    if (incompleteTasks.length < 1) {
      TaskCard taskCard = TaskCard(
          cost: 0,
          description: "Please add a task",
          backgroundColor: colors[0]);
      taskCards.add(taskCard);
    } else {
      for (var i = 0; i < incompleteTasks.length; i++) {
        TaskCard taskCard = TaskCard(
            cost: incompleteTasks[i].cost,
            description: incompleteTasks[i].description,
            backgroundColor: colors[i % 4]);
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
        incompleteTasks.add(Task("Please add a task", "09-25-2020", 50, 0));
        currentTask = 0;
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
      currentTask = 0;
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
      backgroundColor: Color(0XFFF2F7FB),
      body: Column(
        children: [
          HeaderRow(),
          TasksRow(),
          CardView(taskCards, pageController, _onPageChanged,currentTask),
          RemaingingTimeWidget(incompleteTasks[currentTask].getDateTime()),
          CompleteWidget(_onCompleteSwipe),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.add));

          await showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return
                 BlocProvider.value(
                  value: BlocProvider.of<TaskBloc>(context),
                  child: AddTask(
                    costToggled: false,
                    isModal: true,
                  ),
                );
              });
          _handleAddedTasks();
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0XFF1C2638),
      ),
    );
  }
}
