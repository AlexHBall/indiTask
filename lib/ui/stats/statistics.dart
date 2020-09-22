import 'package:flutter/material.dart';

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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "All Time",
                        style: TextStyle(
                            color: Color(0xFF1C2638), fontWeight: FontWeight.bold,fontSize: 12.0),
                      ),
                      Text(">"),
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
                  const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
              child: Image.asset(imgPath, scale: 0.1

                  // height: 3,
                  // width: 3,
                  ),
            ),
          ],
        ));
  }
}

class StatisticsBody extends StatelessWidget {
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
                  StatisticsCard("Tasks Entered", "147",
                      "assets/images/charts.png", Color(0xFF1C2638), 261),
                  SizedBox(
                    height: 16.0,
                  ),
                  StatisticsCard("Loss/Wage %", "8%", "assets/images/rate.png",
                      Color(0XFF108B00), 226),
                ],
              ),
              SizedBox(
                width: 16.0,
              ),
              Column(
                children: [
                  StatisticsCard("Total Points", "1080",
                      "assets/images/running.png", Color(0XFF9BBFD6), 179),
                  SizedBox(
                    height: 16.0,
                  ),
                  StatisticsCard("% Complete", "81%",
                      "assets/images/calories.png", Color(0XFFFF8C00), 309),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
