part of '../custom_widgets.dart';

class TaskInput extends StatelessWidget {
  final TextEditingController descriptionCtrl;
  TaskInput(this.descriptionCtrl);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        color: Colour.blue.color, fontSize: 18, fontWeight: FontWeight.w400);
    return Padding(
      padding:
          const EdgeInsets.only(top: 25.0, left: 5.0, right: 5.0, bottom: 42.0),
      child: TextField(
        cursorColor: Colour.blue.color,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colour.blue.color),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colour.blue.color),
            )),
        style: style,
        controller: descriptionCtrl,
        textAlign: TextAlign.left,
        autofocus: true,
      ),
    );
  }
}

class CostInput extends StatefulWidget {
  final Function updateCost;
  final double cost;
  CostInput({Key key, @required this.updateCost, @required this.cost})
      : super(key: key);

  @override
  _CostInputState createState() => _CostInputState();
}

class _CostInputState extends State<CostInput> {
  double _currentSliderValue;

  @override
  void initState() {
    _currentSliderValue = widget.cost;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Container scoreContainer = Container(
        width: 60.0,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colour.green.color,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 11),
          child: Text(_currentSliderValue.round().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ));

    SizedBox sliderBox = SizedBox(
        height: 21,
        width: 250,
        child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colour.green.color,
              inactiveTrackColor: Color(0xFFEFEFEF),
              trackShape: RoundSliderTrackShape(radius: 20),
              trackHeight: 9.0,
              thumbColor: Colour.green.color,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9.0),
              overlayColor: Colors.white,
              overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
            ),
            child: Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              // inactiveColor: Colors.grey,
              // activeColor: Colour.green.color,
              onChanged: (double value) {
                widget.updateCost(value.round());
                setState(() {
                  _currentSliderValue = value;
                });
              },
            )));

    return Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 25.0),
        child: Container(
          height: 60.0,
          width: 320.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              sliderBox,
              scoreContainer,
            ],
          ),
        ));
  }
}

class AlarmInput extends StatefulWidget {
  final Function updateAlarm;
  final int selected;
  const AlarmInput({@required this.updateAlarm, @required this.selected});
  @override
  _AlarmInputState createState() => _AlarmInputState();
}

class _AlarmInputState extends State<AlarmInput> {
  Widget buttonText(String text) {
    return Text(text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          // color: Colour.lightBlue.color
        ));
  }

  int selected;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var buttonTexts = [
      buttonText("24hrs before"),
      buttonText("3hrs before"),
      buttonText("1hr before")
    ];

    List<Widget> buttonList = [];
    for (int i = 0; i < buttonTexts.length; i++) {
      buttonList.add(ButtonTheme(
        minWidth: 90.0,
        height: 40.0,
        child: FlatButton(
          color: (selected == i) ? Colour.lightBlue.color : Colour.white.color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: Colour.lightBlue.color)),
          textColor: (selected == i) ? Colors.white : Colour.lightBlue.color,
          padding: EdgeInsets.all(12.0),
          onPressed: () {
            widget.updateAlarm(selected);
            setState(() {
              if (selected == i) {
                selected = -1;
              } else {
                selected = i;
              }
            });
          },
          child: buttonTexts[i],
        ),
      ));
    }

    Widget remindMeText() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Center(
          child: Text(
            "Remind me:",
            style: TextStyle(
              color: Colour.blue.color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        remindMeText(),
        Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttonList,
          ),
        ),
      ],
    );
  }
}

class TaskInfo extends StatefulWidget {
  final Function notifyParentCost;
  final Function notifyParentAlarm;
  final Function notifyParentDate;
  final AddTaskState inputState;
  final String cost;
  final String date;

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
  String _text = "100";

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
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                      title: new Text("Material Dialog"),
                      content: TimePicker(),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Close me!'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ));
            widget.notifyParentDate();
          },
          child: Text(widget.date,
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
            //TODO: change _text to color
            // setState(() {
            //   (widget.inputState != AddTaskState.cost)
            //       ? _text = "Done"
            //       : _text = widget.cost.toString();
            // });
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

class AddTaskButton extends StatelessWidget {
  final Function onSumbit;
  AddTaskButton(this.onSumbit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 33.0, left: 5.0, right: 5.0),
      child: Container(
          width: 320,
          height: 66,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colour.blue.color,
          ),
          child: RawMaterialButton(
            fillColor: Colour.blue.color,
            splashColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text("Add Task",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            onPressed: onSumbit,
            shape: const StadiumBorder(),
          )),
    );
  }
}

class AddTask extends StatefulWidget {
  final bool costToggled;
  final bool isModal;
  AddTask({
    Key key,
    @required this.costToggled,
    @required this.isModal,
  }) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String costButtonText;
  int cost = 100;
  int alarmSelected = -1;
  TextEditingController descriptionCtrl;
  TextEditingController dateCtrl;
  AddTaskState inputRowState;

  void _toggleCost() {
    setState(() {
      if (inputRowState == AddTaskState.cost) {
        inputRowState = AddTaskState.text;
      } else {
        inputRowState = AddTaskState.cost;
      }

      (inputRowState == AddTaskState.cost)
          ? costButtonText = "Done"
          : costButtonText = cost.toString();
    });
  }

  void _updateCost(int newCost) {
    setState(() {
      cost = newCost;
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

  void _updateAlarm(int selected) {
    setState(() {
      alarmSelected = selected;
    });
  }

  void _toggleDate() {}

  void _updateDate() {}

  void _addTask() {
    String desc = descriptionCtrl.text;
    if (desc.isNotEmpty) {
      int cost = this.cost;
      // TODO: Date String Properly
      // String date = dateCtrl.text;
      String date = "09-26-2020";
      int alarm = 0;
      Task taskToAdd = Task(desc, date, cost, alarm);
      print('Adding Task $taskToAdd');
      if (!widget.isModal) {
        BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.tasks));
      }
      BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(taskToAdd));
      descriptionCtrl.clear();
    }
  }

  _getInputRow() {
    if (inputRowState == AddTaskState.text) {
      return TaskInput(descriptionCtrl);
    } else if (inputRowState == AddTaskState.alarm) {
      return AlarmInput(
        updateAlarm: _updateAlarm,
        selected: alarmSelected,
      );
    } else if (inputRowState == AddTaskState.cost) {
      return CostInput(
        updateCost: _updateCost,
        cost: cost.toDouble(),
      );
    }
  }

  @override
  void initState() {
    costButtonText = cost.toString();
    descriptionCtrl = TextEditingController();
    dateCtrl = TextEditingController();
    inputRowState = AddTaskState.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 527,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colour.blue.color),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0),
          child: Column(children: <Widget>[
            // _getInputRow(),
            // TaskInfo(
            //   notifyParentCost: _toggleCost,
            //   notifyParentAlarm: _toggleAlarm,
            //   notifyParentDate: _toggleDate,
            //   inputState: inputRowState,
            //   cost: costButtonText,
            //   date: "26 Apr at 12:00AM",
            // ),
            // AddTaskButton(_addTask),
            TimePicker(),
          ]),
        ));
  }
}