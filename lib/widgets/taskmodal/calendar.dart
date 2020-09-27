import 'package:flutter/material.dart';
import 'package:inditask/utils/colors.dart';

class CalendarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 527,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colour.blue.color),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white),
        child: Column(children: [
          Center(child: Text("Set Date")),
          RawMaterialButton(
            fillColor: Colour.blue.color,
            splashColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text("Next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            onPressed: null,
            shape: const StadiumBorder(),
          )
        ]));
  }
}
