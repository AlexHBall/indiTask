part of 'dashboard.dart';

class ButtonWrapper extends StatelessWidget {
  final Widget child;
  final Function onPress;
  final bool selected;
  const ButtonWrapper(
      {@required this.child, @required this.onPress, @required this.selected});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 41.35,
      height: 27.57,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colors.white)),
        textColor: selected ? Colour.blue.color : Colors.white,
        color: selected ? Colors.white : Color(0x00000000),
        padding: EdgeInsets.all(8.0),
        onPressed: onPress,
        child: child,
      ),
    );
  }
}

class AlarmButton extends StatelessWidget {
  final Function onPress;
  const AlarmButton({this.onPress});
  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      child: Icon(Icons.add_alarm, size: 12),
      onPress: onPress,
      selected: false,
    );
  }
}

class TextButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final bool selected;
  const TextButton(
      {@required this.text, @required this.onPress, @required this.selected});
  @override
  Widget build(BuildContext context) {
    return ButtonWrapper(
      child: Text(
        text,
        style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w600),
      ),
      onPress: onPress,
      selected: selected,
    );
  }
}

class TaskCard extends StatefulWidget {
  final Task task;
  final Color backgroundColor;
  final Function onEditPress;

  TaskCard(
      {Key key,
      @required this.task,
      @required this.backgroundColor,
      @required this.onEditPress})
      : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool showAlarms;
  bool hasPreviousNotificaiton;
  int alarmSelected;
  int previousNotificationId;
  Widget score() {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.backgroundColor,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          widget.task.cost.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 149, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ), // 1C263
    );
  }

  Widget defaultButtonRow() {
    return Padding(
        padding: const EdgeInsets.only(left: 17.0, top: 12.0),
        child: Row(
          children: [
            TextButton(
              text: "Edit",
              onPress: widget.onEditPress,
              selected: false,
            ),
            SizedBox(
              width: 3.0,
            ),
            AlarmButton(
              onPress: toggleAlarmRow,
            ),
          ],
        ));
  }

  Widget editAlarmRow(int alarmSelected, Function onPress) {
    print(alarmSelected);
    List<String> texts = ["1hr", "3hr", "24hr"];
    List<Widget> elements = [];

    for (int i = 0; i < texts.length; i++) {
      if (i == alarmSelected) {
        elements.add(TextButton(
          text: texts[i],
          onPress: () => onPress(-1),
          selected: true,
        ));
      } else {
        elements.add(ButtonTheme(
          minWidth: 41.35,
          height: 27.57,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
                side: BorderSide(color: Colors.white)),
            textColor: Colors.white,
            color: Color(0x00000000),
            padding: EdgeInsets.all(8.0),
            onPressed: () => onPress(i),
            child: Text(
              texts[i],
              style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w600),
            ),
          ),
        ));
      }
    }
    elements
        .add(TextButton(text: "Done", onPress: submitAlarm, selected: false));
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: elements,
      ),
    );
  }

  Widget descriptionText() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 53.0, top: 90.0, right: 30.0, bottom: 50.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          widget.task.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  void toggleAlarmRow() {
    setState(() {
      showAlarms = !showAlarms;
    });
  }

  int switchSelected(int selected) {
    switch (selected) {
      case -1:
        return -1;
        break;
      case 0:
        return 2;
        break;
      case 1:
        return 1;
        break;
      case 2:
        return 0;
        break;
      default:
        return -1;
    }
  }

  void updateSelectedAlarm(int selected) {
    //TODO: Allow update to 0
    print('updating alarm to $selected');
    setState(() {
      widget.task.alarm = switchSelected(selected);
      alarmSelected = selected;
    });
  }

  Future<int> _getNextAlarmId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("lastAlarmId") + 1;
    prefs.setInt("lastAlarmId", id);
    return id;
  }

  void _add(int value) async {
    widget.task.alarmId = value;
    List<int> hours = [24, 3, 1];
    List<String> dueTimes = ["24 hrs", "3 hrs", "1hr"];
    String dueIn = dueTimes[alarmSelected];
    String desc = widget.task.description;
    String cost = widget.task.cost.toString();
    DateTime reminderTime =
        widget.task.getDate().subtract(Duration(hours: hours[alarmSelected]));

    await notificationPlugin.scheduleNotification(widget.task.alarmId,
        reminderTime, "Task Due in $dueIn", "$desc costing $cost");
  }

  void _addNotification() async {
    _getNextAlarmId().then((value) => _add(value));
  }

  void submitAlarm() {
    //TODO: Update alarm ????
    if (hasPreviousNotificaiton) {
      notificationPlugin.cancelNotification(previousNotificationId);
    }

    if (widget.task.alarm > -1) {}

    BlocProvider.of<TaskBloc>(context).add(EditTaskEvent(widget.task));
    toggleAlarmRow();
  }

  @override
  void initState() {
    super.initState();
    showAlarms = false;
    alarmSelected = switchSelected(widget.task.alarm);
    if (widget.task.alarmId > -1) {
      hasPreviousNotificaiton = true;
      previousNotificationId = widget.task.alarmId;
    } else {
      hasPreviousNotificaiton = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("card has alarm $alarmSelected");
    return Padding(
      padding: const EdgeInsets.only(
          left: 40.0, right: 40.0, top: 20.0, bottom: 38.0),
      child: Stack(children: [
        score(),
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.backgroundColor.withOpacity(0.5),
          ),
          child: Column(children: [
            (showAlarms)
                ? editAlarmRow(alarmSelected, updateSelectedAlarm)
                : defaultButtonRow(),
            descriptionText(),
          ]),
        )
      ]),
    );
  }
}
