import 'package:flutter/material.dart';
import 'package:inditask/models/models.dart';
import 'package:inditask/ui/dashboard/dashboard.dart';

class CardView extends StatelessWidget {
  final List<TaskCard> tasks;
  final PageController ctrl;
  final Function onChange;
  const CardView(this.tasks, this.ctrl, this.onChange);

  @override
  Widget build(BuildContext context) {
    print('page veiw building');
    List<Color> colors = [
      Color(0xFF1C2638),
      Color(0XFF9BBFD6),
      Color(0XFF108B00),
      Color(0XFFFF8C00)
    ];
    return PageView.builder(
        controller: ctrl,
        onPageChanged: (index) => onChange(index),
        itemBuilder: (BuildContext context, int index) {
          return tasks[index];
        });
  }
}
