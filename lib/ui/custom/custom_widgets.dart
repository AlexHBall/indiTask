import 'package:flutter/material.dart';

class RoundSliderTrackShape extends SliderTrackShape {
  const RoundSliderTrackShape(
      {this.disabledThumbGapWidth = 2.0, this.radius = 0});

  final double disabledThumbGapWidth;
  final double radius;

  @override
  Rect getPreferredRect({
    RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData sliderTheme,
    bool isEnabled,
    bool isDiscrete,
  }) {
    final double overlayWidth =
        sliderTheme.overlayShape.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight;
    assert(overlayWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= overlayWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackLeft = offset.dx + overlayWidth / 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;

    final double trackWidth = parentBox.size.width - overlayWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    Animation<double> enableAnimation,
    TextDirection textDirection,
    Offset thumbCenter,
    bool isDiscrete,
    bool isEnabled,
  }) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation);
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation);
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    double horizontalAdjustment = 0.0;
    if (!isEnabled) {
      final double disabledThumbRadius =
          sliderTheme.thumbShape.getPreferredSize(false, isDiscrete).width /
              2.0;
      final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
      horizontalAdjustment = disabledThumbRadius + gap;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    //Modify this side
    final RRect leftTrackSegment = RRect.fromLTRBR(
        trackRect.left,
        trackRect.top,
        thumbCenter.dx - horizontalAdjustment,
        trackRect.bottom,
        Radius.circular(radius));
    context.canvas.drawRRect(leftTrackSegment, leftTrackPaint);
    final RRect rightTrackSegment = RRect.fromLTRBR(
        thumbCenter.dx + horizontalAdjustment,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
        Radius.circular(radius));
    context.canvas.drawRRect(rightTrackSegment, rightTrackPaint);
  }
}

class ScoreInput extends StatefulWidget {
  final Function updateScore;
  final double score;
  ScoreInput({Key key, @required this.updateScore, @required this.score})
      : super(key: key);

  @override
  _ScoreInputState createState() => _ScoreInputState();
}

class _ScoreInputState extends State<ScoreInput> {
  double _currentSliderValue;

  @override
  void initState() {
    _currentSliderValue = widget.score;
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
                widget.updateScore(value.round());
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
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text("Add Task",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )));
  }
}

class TaskInput extends StatelessWidget {
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
        controller: TextEditingController(text: "Finish financial analysis"),
        onSubmitted: (String text) async {},
        textAlign: TextAlign.left,
      ),
    );
  }
}

class AddTask extends StatefulWidget {
  final bool scoreToggled;

  AddTask(this.scoreToggled, {Key key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool scoreToggled = false;
  int score = 100;
  String scoreButtonText;

  void _toggleScore() {
    setState(() {
      scoreToggled = !scoreToggled;
      (scoreToggled)
          ? scoreButtonText = score.toString()
          : scoreButtonText = "Done";
    });
  }

  void _updateScore(int newScore) {
    setState(() {
      score = newScore;
      scoreButtonText = newScore.toString();
    });
  }

  @override
  void initState() {
    scoreToggled = widget.scoreToggled;
    scoreButtonText = score.toString();
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
            (scoreToggled)
                ? ScoreInput(
                    updateScore: _updateScore, score: score.toDouble(),
                  )
                : TaskInput(),
            TaskInfo(
              notifyParent: _toggleScore,
              toggle: scoreToggled,
              score: scoreButtonText,
            ),
            AddTaskButton(),
          ]),
        ));
  }
}
