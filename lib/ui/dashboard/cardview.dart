import 'package:flutter/material.dart';
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
    return Column(
      children: [
        PositionViewer(),
        Container(height: 400,
          child: PageView.builder(
              controller: ctrl,
              onPageChanged: (index) => onChange(index),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return tasks[index];
              }),
        ),
      ],
    );
  }
}
class PositionViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('yolo');
  }

}