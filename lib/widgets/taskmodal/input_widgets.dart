part of 'add_task.dart';

class TaskInput extends StatelessWidget {
  final TextEditingController descriptionCtrl;
  final bool focus;
  TaskInput(this.descriptionCtrl, this.focus);

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
        autofocus: focus,
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
  bool pressed;
  @override
  void initState() {
    selected = widget.selected;
    (selected > -1) ? pressed = true : pressed = false;
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
            if (i != selected) {
              widget.updateAlarm(i);
            } else {
              widget.updateAlarm(-1);
            }

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

class AddTaskButton extends StatelessWidget {
  final Function onSumbit;
  final bool isEdit;
  AddTaskButton(this.onSumbit, this.isEdit);

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
              child: Text((isEdit) ? "Update Task" : "Add Task",
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
