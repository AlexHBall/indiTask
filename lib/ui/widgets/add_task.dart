part of 'custom_widgets.dart';

class TaskInput extends StatelessWidget {
  final TextEditingController descriptionCtrl;
  TaskInput(this.descriptionCtrl);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        color: Color(0xFF1C2638), fontSize: 18, fontWeight: FontWeight.w400);
    return Padding(
      padding:
          const EdgeInsets.only(top: 25.0, left: 5.0, right: 5.0, bottom: 27.0),
      child: TextField(
        cursorColor: Colors.white,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1C2638)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF1C2638)),
            )),
        style: style,
        controller: descriptionCtrl,
        onSubmitted: (String text) async {
          // onSubmit(text);
        },
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
          color: Color(0xFF108B00),
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
              activeTrackColor: Color(0xFF108B00),
              inactiveTrackColor: Color(0xFFEFEFEF),
              trackShape: RoundSliderTrackShape(radius: 20),
              trackHeight: 9.0,
              thumbColor: Color(0xFF108B00),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9.0),
              overlayColor: Colors.white,
              overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
            ),
            child: Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              // inactiveColor: Colors.grey,
              // activeColor: Color(0xFF108B00),
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

class TaskInfo extends StatefulWidget {
  final Function notifyParent;
  final bool toggle;
  final String score;
  TaskInfo(
      {Key key,
      @required this.notifyParent,
      @required this.toggle,
      @required this.score})
      : super(key: key);

  @override
  TaskInfoState createState() => TaskInfoState();
}

class TaskInfoState extends State<TaskInfo> {
  TaskInfoState();
  String _text = "100";

  //TODO: Make this a switch
  Container alarmTimeDisplay(
      double w, double h, String text, Color backgroundColor) {
    return Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Color(0xFF1C2638)),
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor,
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 11),
            child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1C2638)))));
  }

  Container alarmIconDisplay(double w, double h) {
    return Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Color(0xFF9BBFD6)),
          borderRadius: BorderRadius.circular(50),
          color: Color(0xFFFF),
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Icon(
              Icons.add_alarm,
              color: Color(0xFF9BBFD6),
            )));
  }

  @override
  Widget build(BuildContext context) {
    GestureDetector scoreDisplay(double w, double h, Color backgroundColor) {
      return GestureDetector(
        onTap: () {
          widget.notifyParent();

          setState(() {
            (widget.toggle) ? _text = widget.score.toString() : _text = "Done";
          });
        },
        child: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 11),
              child: Text(_text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            )),
      );
    }

    return Padding(
        padding: const EdgeInsets.only(left: 7.0, right: 7.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              alarmTimeDisplay(
                  140.0, 40.0, "26 Apr at 12:00AM", Color(0xFFFFFFFF)),
              alarmIconDisplay(60.0, 40.0),
              scoreDisplay(60.0, 40.0, Color(0xFF108B00)),
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
            color: Color(0xFF1C2638),
          ),
          child: RawMaterialButton(
            fillColor: Color(0xFF1C2638),
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

  AddTask({
    Key key,
    @required this.costToggled,
  }) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool costToggled = false;
  String costButtonText;
  int cost = 100;
  TextEditingController descriptionCtrl;
  TextEditingController dateCtrl;

  void _toggleCost() {
    setState(() {
      costToggled = !costToggled;
      (costToggled)
          ? costButtonText = cost.toString()
          : costButtonText = "Done";
    });
  }

  void _updateCost(int newCost) {
    setState(() {
      cost = newCost;
      costButtonText = newCost.toString();
    });
  }

  void _addTask() {
    String desc = descriptionCtrl.text;
    int cost = this.cost;
    // TODO: Date String Properly
    // String date = dateCtrl.text;
    String date = "09-26-2020";
    int alarm = 0;
    Task taskToAdd = Task(desc, date, cost, alarm);
    print('Adding Task $taskToAdd');
    BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(taskToAdd));
    BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.tasks));
  }

  @override
  void initState() {
    costToggled = widget.costToggled;
    costButtonText = cost.toString();
    descriptionCtrl = TextEditingController();
    dateCtrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 527,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Color(0xFF1C2638)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0),
          child: Column(children: <Widget>[
            (costToggled)
                ? CostInput(
                    updateCost: _updateCost,
                    cost: cost.toDouble(),
                  )
                : TaskInput(descriptionCtrl),
            TaskInfo(
              notifyParent: _toggleCost,
              toggle: costToggled,
              score: costButtonText,
            ),
            AddTaskButton(_addTask),
          ]),
        ));
  }
}
