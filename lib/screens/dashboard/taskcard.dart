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

  Widget editAlarmRow(int alarmSelected) {
    print(alarmSelected);
    List<String> texts = ["1hr", "3hr", "24hr"];
    List<Widget> elements = [];

    for (int i = 0; i < texts.length; i++) {
      if (i == alarmSelected) {
        elements.add(TextButton(
          text: texts[i],
          onPress: () {}, selected: true,
          
        ));
      } else {
        elements.add(TextButton(
          text: texts[i],
          onPress: () {},
          selected: false,
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

  void submitAlarm() {
    //TODO: Update task with whatever alarm was selected
    toggleAlarmRow();
  }

  @override
  void initState() {
    super.initState();
    showAlarms = false;
  }

  @override
  Widget build(BuildContext context) {
    int alarmSelected = widget.task.alarm;
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
            (showAlarms) ? editAlarmRow(alarmSelected) : defaultButtonRow(),
            descriptionText(),
          ]),
        )
      ]),
    );
  }
}
