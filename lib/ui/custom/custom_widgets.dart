import 'package:flutter/material.dart';

Container containerButtonText(double w, double h, String text, Color backgroundColor) {
  return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Color(0xFF1C2638)),
        borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:
                    // Color(0xFF1C2638)
                    Colors.purple)),
      ));
}

Container containerButtonTextNoSolidBorder(double w, double h, String text, Color backgroundColor) {
  return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:
                    // Color(0xFF1C2638)
                    Colors.purple)),
      ));
}

Container containerButtonIcon(double w, double h) {
  return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Color(0xFF9BBFD6)),
        borderRadius: BorderRadius.circular(50),
        color: Color(0xFFFF),
      ),
      child: Padding(
          padding: const EdgeInsets.all(22.0), child: Icon(Icons.alarm)));
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
          padding: const EdgeInsets.only(left: 35.0, right: 35.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 49.0, left: 5.0, right: 5.0, bottom: 27.0),
              child: TextField(
                cursorColor: Colors.white,
                controller: TextEditingController(text: "Your task name"),
                onSubmitted: (String text) async {},
                textAlign: TextAlign.center,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  containerButtonText(140.0, 40.0, "DATE", Color(0xFFFFFFFF)),
                  containerButtonIcon(60.0, 40.0),
                  containerButtonTextNoSolidBorder(
                      60.0, 40.0, "SCORE", Color(0xFF108B00)),
                ]),
            Padding(
                padding: const EdgeInsets.only(
                    top: 33.0, left: 5.0, right: 5.0),
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
                  ),
                )),
          ]),
        ));
  }