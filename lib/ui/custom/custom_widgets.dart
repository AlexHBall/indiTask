import 'package:flutter/material.dart';

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

Container scoreDisplay(double w, double h, String text, Color backgroundColor) {
  return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
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
                color: Colors.white)),
      ));
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

Padding taskInput() {
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

Padding scoreInput() {
  return Padding(
    padding:
        const EdgeInsets.only(top: 49.0, left: 12.0, right: 12.0, bottom: 27.0),
    child: TextField(
      cursorColor: Colors.white,
      controller: TextEditingController(text: "Your task name"),
      onSubmitted: (String text) async {},
      textAlign: TextAlign.center,
    ),
  );
}

Padding taskInfo() {
  return Padding(
    padding: const EdgeInsets.only(left: 7.0, right: 7.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          alarmTimeDisplay(140.0, 40.0, "26 Apr at 12:00AM", Color(0xFFFFFFFF)),
          alarmIconDisplay(60.0, 40.0),
          scoreDisplay(60.0, 40.0, "100", Color(0xFF108B00)),
        ]),
  );
}

Padding addTaskButton() {
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

Container addTask() {
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
          taskInput(),
          taskInfo(),
          addTaskButton(),
        ]),
      ));
}
