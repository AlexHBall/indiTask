import 'package:flutter/material.dart';
import 'package:inditask/ui/custom/custom_widgets.dart';

class Tasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskWidget();
  }
}

class TaskWidget extends State<Tasks> {
  Column initialPage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 142.0),
          child: Image.asset('assets/images/logoSmall.png'),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 28.0, left: 55.0, right: 50.0, bottom: 20.0),
          child: Text("Create your first task",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C2638))),
        ),
        addTask(),
      ],
    );
  }

  Container addTask() {
    return Container(
        height: 520,
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
                controller: TextEditingController(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F7FB),
      body: initialPage(),
    );
  }
}

Widget buildInitialInput() {
  return Center(
    child: Text("Put first task input here"),
  );
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildLoaded() {}
