import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inditask/bloc/bloc.dart';
import 'package:inditask/bloc/tab/tab.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/ui/widgets/widgets.dart';

class StatisticsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 40.0, left: 30.0),
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Statistics",
            style: TextStyle(
                color: Color(0xFF1C2638),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: TextStyle(
                  color: Color(0xFF1C2638),
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
            ),
            SizedBox(
              width: 18.0,
            ),
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 1.0, color: Color(0xFF1C2638)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "All Time",
                        style: TextStyle(
                            color: Color(0xFF1C2638),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        "assets/images/filterSelector.png",
                        scale: 1.2,
                      ),
                    ],
                  ),
                )),
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
                // scale: 0.1,
                // height: 3,
                // width: 3,
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
  StatisticsBody(this.totalTasks, this.totalPoints, this.percentComplete);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          StatisticsHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 16.0),
            child: Row(
              children: [
                Column(
                  children: [
                    StatisticsCard2("Tasks Entered", totalTasks.toString(),
                        "assets/images/charts.png", Color(0xFF1C2638), 261),
                    SizedBox(
                      height: 16.0,
                    ),
                    StatisticsCard("Loss/Wage %", "?", "assets/images/rate.png",
                        Color(0XFF108B00), 226),
                  ],
                ),
                SizedBox(
                  width: 16.0,
                ),
                Column(
                  children: [
                    StatisticsCard("Total Points", totalPoints.toString(),
                        "assets/images/running.png", Color(0XFF9BBFD6), 179),
                    SizedBox(
                      height: 16.0,
                    ),
                    StatisticsCard("% Complete", "$percentComplete%",
                        "assets/images/calories.png", Color(0XFFFF8C00), 309),
                  ],
                ),
              ],
            ),
          ),
        ]),
        floatingActionButton: MaterialButton(
          color: Colors.red,
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
        return StatisticsBody(
            state.tasksEntered, state.totalPoints, state.percentageComplete);
      }
      return CircleIndicator();
    });
  }
}
