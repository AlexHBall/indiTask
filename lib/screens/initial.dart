import 'package:flutter/material.dart';
import 'package:inditask/utils/colors.dart';
import 'package:inditask/utils/utils.dart';
import 'package:inditask/widgets/taskmodal/add_task.dart';

class InitialScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTaskWidget();
  }
}

class AddTaskWidget extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    Widget image() {
      return Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.safeBlockVertical * 17,
            bottom: SizeConfig.safeBlockVertical * 3),
        child: Image.asset(
          'assets/images/logoSmall.png',
          height: SizeConfig.safeBlockVertical * 8,
          width: SizeConfig.safeBlockHorizontal * 25,
        ),
      );
    }

    Widget textHeader() {
      return Padding(
        padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
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

    return Scaffold(
      backgroundColor: Colour.backGrey.color,
      resizeToAvoidBottomPadding: false,
      body: initialPage(),
    );
  }
}
