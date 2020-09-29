import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/utils/utils.dart';
import 'package:inditask/widgets/taskmodal/timepicker.dart';
import 'package:flutter/material.dart';
import 'package:inditask/widgets/widgets.dart';
import 'package:intl/intl.dart';

part 'widgets.dart';
part 'input_widgets.dart';

class AddTask extends StatefulWidget {
  final bool costToggled;
  final bool isModal;
  final Task task;
  AddTask(
      {Key key, @required this.costToggled, @required this.isModal, this.task})
      : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool visited = false;
  String costButtonText;
  int alarmSelected = -1;
  TextEditingController descriptionCtrl;
  TextEditingController dateCtrl;
  AddTaskState inputRowState;
  DateTime dueDate = DateTime.now();
  bool selectingDate = false;
  Task task;
  bool isEdit = false;

 

  void _toggleCost() {
    setState(() {
      if (inputRowState == AddTaskState.cost) {
        inputRowState = AddTaskState.text;
      } else {
        inputRowState = AddTaskState.cost;
      }

      (inputRowState == AddTaskState.cost)
          ? costButtonText = "Done"
          : costButtonText = task.cost.toString();
    });
  }

  void _updateCost(int newCost) {
    setState(() {
      task.cost = newCost;
      costButtonText = newCost.toString();
    });
  }

  void _toggleAlarm() {
    setState(() {
      if (inputRowState == AddTaskState.alarm) {
        inputRowState = AddTaskState.text;
      } else {
        inputRowState = AddTaskState.alarm;
      }
    });
  }

  void _updateAlarm(int selected, bool pressed) {
    setState(() {
      if (pressed) {
        print("updating alarm $selected");
        alarmSelected = selected;
      }
    });
  }

  void _toggleDate() {
    setState(() {
      selectingDate = !selectingDate;
    });
  }

  void _updateDate(DateTime selectedDateTime) {
    setState(() {
      dueDate = selectedDateTime;
    });
    _toggleDate();
  }

  void _addNotification() async {
    List<int> hours = [24, 3, 1];
    List<String> dueTimes = ["24 hrs", "3 hrs", "1hr"];
    String dueIn = dueTimes[alarmSelected];
    String desc = task.description;
    String cost = task.cost.toString();
    DateTime reminderTime =
        task.getDate().subtract(Duration(hours: hours[alarmSelected]));

    await notificationPlugin.scheduleNotification(
        reminderTime, "Task Due in $dueIn", "$desc costing $cost");
  }

  void _addTask() {
    String desc = descriptionCtrl.text;
    if (desc.isNotEmpty) {
      task.date = dueDate;
      task.description = desc;
      task.alarm = alarmSelected;
      print('Adding Task $task');
      if (!widget.isModal) {
        BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.tasks));
      }
      if (isEdit) {
        BlocProvider.of<TaskBloc>(context).add(EditTaskEvent(task));
        //TODO: Edit notification
        Navigator.pop(context);
      } else {
        if (alarmSelected > -1) {
          _addNotification();
        }
        BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(task));
      }
      descriptionCtrl.clear();
      alarmSelected = -1;
      dueDate = DateTime.now();
    }
  }

  _getInputRow() {
    if (inputRowState == AddTaskState.text) {
      return TaskInput(descriptionCtrl, !visited);
    } else if (inputRowState == AddTaskState.alarm) {
      return AlarmInput(
        updateAlarm: _updateAlarm,
        selected: alarmSelected,
      );
    } else if (inputRowState == AddTaskState.cost) {
      return CostInput(
        updateCost: _updateCost,
        cost: task.cost.toDouble(),
      );
    }
  }

  int toNearestFive(int x) {
    double rem = x.toDouble() % 5;

    double rounded = (rem < 2.5) ? x - rem : x + rem;
    return rounded.round();
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
  }

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      task = widget.task;
      isEdit = true;
    } else {
      task = Task("", dueDate.toString(), 100, 0);
    }
    costButtonText = task.cost.toString();
    descriptionCtrl = TextEditingController(text: task.description);
    dateCtrl = TextEditingController(text: task.getDateString());
    inputRowState = AddTaskState.text;
    int roundedMins = toNearestFive(dueDate.minute);
    dueDate = new DateTime(dueDate.year, dueDate.month, dueDate.day + 1,
        dueDate.hour, roundedMins);
    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> inputWidgets = [
      _getInputRow(),
      TaskInfo(
        notifyParentCost: _toggleCost,
        notifyParentAlarm: _toggleAlarm,
        notifyParentDate: _toggleDate,
        inputState: inputRowState,
        cost: costButtonText,
        date: dueDate,
      ),
      AddTaskButton(_addTask, isEdit)
    ];
    visited = true;
    return Container(
        height: 527,
        width: 375,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colour.blue.color),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: selectingDate
            ? DateTimeModal(
                onSubmit: _updateDate,
              )
            : Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(children: inputWidgets),
              ));
  }
}
