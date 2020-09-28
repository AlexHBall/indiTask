import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/bloc/tab/tab.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/utils/colors.dart';
import 'package:inditask/widgets/widgets.dart';

class StatisticsHeader extends StatelessWidget {
  Widget statsHeaderText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Statistics",
        style: TextStyle(
            color: Colour.blue.color,
            fontWeight: FontWeight.bold,
            fontSize: 18.0),
      ),
    );
  }

  Widget dashboardSubtitleText() {
    return Text(
      "Dashboard",
      style: TextStyle(
          color: Colour.blue.color,
          fontWeight: FontWeight.bold,
          fontSize: 40.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 40.0, left: 30.0),
      child: Column(children: [
        statsHeaderText(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            dashboardSubtitleText(),
            SizedBox(
              width: 18.0,
            ),
          ],
        )
      ]),
    );
  }
}

class StatisticsCard extends StatelessWidget {
  final String title;
  final String body;
  final String imgPath;
  final Color backgroundColor;
  final double height;
  StatisticsCard(
    this.title,
    this.body,
    this.imgPath,
    this.backgroundColor,
    this.height,
  );

  Widget titleText() {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Center(
          child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
      )),
    );
  }

  Widget bodyText() {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Center(
          child: Text(
        body,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40.0),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: 165.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imgPath),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            titleText(),
            bodyText(),
          ],
        ));
  }
}

class StatisticsCard2 extends StatelessWidget {
  final String title;
  final String body;
  final String imgPath;
  final Color backgroundColor;
  final double height;
  StatisticsCard2(
    this.title,
    this.body,
    this.imgPath,
    this.backgroundColor,
    this.height,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: 165.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: Center(
                  child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Center(
                  child: Text(
                body,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0),
              )),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
              child: Image.asset(
                imgPath,
              ),
            ),
          ],
        ));
  }
}

class StatisticsBody extends StatelessWidget {
  final int totalTasks;
  final int totalPoints;
  final int percentComplete;
  final int percentLost;
  StatisticsBody(this.totalTasks, this.totalPoints, this.percentComplete,
      this.percentLost);

  Widget statsLeftCol() {
    return Column(
      children: [
        StatisticsCard2("Tasks Entered", totalTasks.toString(),
            "assets/images/charts.png", Colour.blue.color, 261),
        SizedBox(
          height: 16.0,
        ),
        StatisticsCard("Loss/Wage %", "$percentLost%", "assets/images/rate.png",
            Colour.green.color, 226),
      ],
    );
  }

  Widget statsRightCol() {
    return Column(
      children: [
        StatisticsCard("Total Points", totalPoints.toString(),
            "assets/images/running.png", Colour.lightBlue.color, 179),
        SizedBox(
          height: 16.0,
        ),
        StatisticsCard("% Complete", "$percentComplete%",
            "assets/images/calories.png", Colour.orange.color, 309),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          StatisticsHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 16.0),
            child: Row(
              children: [
                statsLeftCol(),
                SizedBox(
                  width: 16.0,
                ),
                statsRightCol(),
              ],
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          backgroundColor: Colour.blue.color,
          onPressed: () {
            BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.tasks));
          },
        ));
  }
}

class StatsDash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatBloc, StatState>(builder: (context, state) {
      if (state is StatsLoading) {
        return CircleIndicator();
      } else if (state is StatsLoaded) {
        return StatisticsBody(state.tasksEntered, state.totalPoints,
            state.percentageComplete, state.percentageLoss);
      }
      return CircleIndicator();
    });
  }
}
