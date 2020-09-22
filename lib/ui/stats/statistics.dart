import 'package:flutter/material.dart';

class StatisticsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Statistics"),
      Row(
        children: [
          Text("Dashboard"),
          Container(
            child: Text("All Time"),
          )
        ],
      )
    ]);
  }
}

class StatisticsCard extends StatelessWidget {
  final String title;
  final int number;
  final String imgPath;
  final Color backgroundColor;
  final double height;
  final double width;
  StatisticsCard(this.title, this.number, this.imgPath, this.backgroundColor,this.height,this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Center(child: Text(title)),
            Center(child: Text(number.toString())),
            Image.asset(imgPath),
          ],
        ));
  }
}

class StatisticsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
