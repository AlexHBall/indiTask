part of 'dashboard.dart';



class Carousel extends StatefulWidget {
  final List<Task> tasks;
  final int index;
  final Function onChange;
  const Carousel(this.tasks, this.index, this.onChange);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<Carousel> {
  List<Color> colors = [
    Color(0xFF1C2638),
    Color(0XFF9BBFD6),
    Color(0XFF108B00),
    Color(0XFFFF8C00)
  ];
  int _currentIndex;
  List<TaskCard> taskCards = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    taskCards = [];
    _currentIndex = widget.index;
    if (widget.tasks.length < 1) {
      _currentIndex = 1;
      TaskCard taskCard = TaskCard(
          cost: 0,
          description: "Please add a task",
          backgroundColor: colors[0]);
      taskCards.add(taskCard);
    } else {
      for (var i = 0; i < widget.tasks.length; i++) {
        TaskCard taskCard = TaskCard(
            cost: widget.tasks[i].cost,
            description: widget.tasks[i].description,
            backgroundColor: colors[i % 4]);
        taskCards.add(taskCard);
      }
      print("task cards now $taskCards");
    }
    print('Carousel built with index $_currentIndex');

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: map<Widget>(taskCards, (index, url) {
        //     return Padding(
        //       padding: const EdgeInsets.only(top: 20),
        //       child: Container(
        //         height: 10,
        //         width: 150,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.rectangle,
        //           color: Colors.grey,
        //           borderRadius: BorderRadius.circular(50),
        //         ),
        //         child: Container(
        //           //TODO: Width needs to be 1/n where n is number of tasks
        //           width: 1 / widget.tasks.length,
        //           height: 10.0,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.rectangle,
        //             color: _currentIndex == index
        //                 ? Color(0xFF1C2638)
        //                 : Colors.grey,
        //             //TODO: Get the border raduis working as inteded
        //             // borderRadius: BorderRadius.circular(10),
        //           ),
        //         ),
        //       ),
        //     );
        //   }),
        // ),
        CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            autoPlay: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                widget.onChange(index);
              });
            },
          ),
          items: taskCards,
        ),
      ],
    );
  }
}
