import 'package:flutter/material.dart';
import 'package:inditask/ui/widgets/custom_widgets.dart';

class InitialScreen extends StatefulWidget {
  //TODO: When onboarding make sure bloc exists
  @override
  State<StatefulWidget> createState() {
    return TaskWidget();
  }
}

class TaskWidget extends State<InitialScreen> {
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
        AddTask(scoreToggled: false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F7FB),
      resizeToAvoidBottomPadding: false,
      body: initialPage(),
    );
  }
}