import 'package:flutter/material.dart';
import 'package:inditask/utils/colors.dart';
import 'package:inditask/widgets/taskmodal/add_task.dart';


class InitialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTaskWidget();
  }
}

class AddTaskWidget extends State<InitialScreen> {
  Widget image() {
    return Padding(
      padding: EdgeInsets.only(top: 142.0),
      child: Image.asset('assets/images/logoSmall.png'),
    );
  }

  Widget textHeader() {
    return Padding(
      padding:
          EdgeInsets.only(top: 28.0, left: 55.0, right: 50.0, bottom: 20.0),
      child: Text("Create your first task",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colour.blue.color)),
    );
  }

  Column initialPage() {
    return Column(
      children: <Widget>[
        image(),
        textHeader(),
        AddTask(
          costToggled: false,
          isModal: false,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.backGrey.color,
      resizeToAvoidBottomPadding: false,
      body: initialPage(),
    );
  }
}
