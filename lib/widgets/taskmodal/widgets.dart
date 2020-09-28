part of 'add_task.dart';

class TaskInfo extends StatefulWidget {
  final Function notifyParentCost;
  final Function notifyParentAlarm;
  final Function notifyParentDate;
  final AddTaskState inputState;
  final String cost;
  final DateTime date;

  TaskInfo({
    Key key,
    @required this.notifyParentCost,
    @required this.notifyParentAlarm,
    @required this.notifyParentDate,
    @required this.inputState,
    @required this.cost,
    @required this.date,
  }) : super(key: key);

  @override
  TaskInfoState createState() => TaskInfoState();
}

class TaskInfoState extends State<TaskInfo> {
  TaskInfoState();
  String _text;

  String _formatDateString(DateTime dueDate) {
    final DateFormat firstFormatter = DateFormat('dd MMM');
    String partOne = firstFormatter.format(dueDate);
    final DateFormat secondFormatter = DateFormat('jm');
    String partTwo = secondFormatter.format(dueDate);
    return ("$partOne at $partTwo");
  }

  @override
  void initState() {
    _text = widget.cost.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget dateButton() {
      return ButtonTheme(
        minWidth: 140.0,
        height: 40,
        child: FlatButton(
          color: Colour.white.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colour.blue.color),
          ),
          padding: EdgeInsets.all(8.0),
          onPressed: widget.notifyParentDate,
          child: Text(_formatDateString(widget.date),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colour.blue.color)),
        ),
      );
    }

    Widget alarmButton() {
      return ButtonTheme(
        minWidth: 60,
        height: 40,
        child: FlatButton(
          color: Colour.white.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colour.lightBlue.color),
          ),
          padding: EdgeInsets.all(8.0),
          onPressed: () {
            widget.notifyParentAlarm();
          },
          child: Icon(Icons.add_alarm, color: Colour.lightBlue.color),
        ),
      );
    }

    Widget costButton() {
      return ButtonTheme(
        minWidth: 60,
        height: 40,
        child: FlatButton(
          color: Colour.green.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          textColor: Colors.white,
          padding: EdgeInsets.all(12.0),
          onPressed: () {
            widget.notifyParentCost();

            setState(() {
              (widget.inputState != AddTaskState.cost)
                  ? _text = "Done"
                  : _text = widget.cost.toString();
            });
          },
          child: Text(_text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ),
      );
    }

    return Padding(
        padding: const EdgeInsets.only(left: 7.0, right: 7.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              dateButton(),
              alarmButton(),
              costButton(),
            ]));
  }
}
