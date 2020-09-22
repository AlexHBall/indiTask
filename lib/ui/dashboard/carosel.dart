part of 'dashboard.dart';

class EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 41.35,
      height: 27.57,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colors.white)),
        // color: Colors.white,
        textColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        onPressed: () {},
        child: Text(
          "Edit",
          style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class AlarmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 41.35,
      height: 27.57,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colors.white)),
        // color: Colors.white,
        textColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        onPressed: () {},
        child: Icon(Icons.add_alarm, size: 12),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final int cost;
  final String description;
  final Color backgroundColor;

  TaskCard(
      {Key key,
      @required this.cost,
      @required this.description,
      @required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 40.0, right: 40.0, top: 20.0, bottom: 38.0),
      child: Stack(children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              cost.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 149,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ), // 1C263
        ),
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor.withOpacity(0.5),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 17.0, top: 12.0),
              child: Row(
                children: [
                  EditButton(),
                  SizedBox(
                    width: 3.0,
                  ),
                  AlarmButton(),
                ],
              ),
            ),
            Padding(
              //TODO: Align this properly
              padding: const EdgeInsets.only(left: 53.0, top: 90.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  description,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
            )
          ]),
        )
      ]),
    );
  }
}

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
    _currentIndex = widget.index;

    if (widget.tasks.length < 1) {
      for (var i = 0; i < widget.tasks.length; i++) {
        TaskCard taskCard = TaskCard(
            cost: widget.tasks[i].cost,
            description: widget.tasks[i].description,
            backgroundColor: colors[i % 4]);
        taskCards.add(taskCard);
      }
    } else {
      _currentIndex =1;
      TaskCard taskCard = TaskCard(
          cost: 0,
          description: "Please add a task",
          backgroundColor: colors[0]);
      taskCards.add(taskCard);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }
      return result;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(taskCards, (index, url) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 10,
                width: 0.2 * widget.tasks.length,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  //TODO: Width needs to be 1/n where n is number of tasks
                  width: 1 / widget.tasks.length,
                  height: 6.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _currentIndex == index
                        ? Color(0xFF1C2638)
                        : Colors.grey,
                    //TODO: Get the border raduis working as inteded
                    // borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          }),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            autoPlay: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
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
