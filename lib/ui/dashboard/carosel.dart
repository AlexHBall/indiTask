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
      {Key key, @required this.cost, this.description, this.backgroundColor})
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
                  //TODO: Score description here
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

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  List<Color> colors = [
    Color(0xFF1C2638),
    Color(0XFF9BBFD6),
    Color(0XFF108B00),
    Color(0XFFFF8C00)
  ];

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    List<TaskCard> taskCards = [
      TaskCard(cost: 100, description: "GG", backgroundColor: colors[0 % 4]),
      TaskCard(cost: 50, description: "GD", backgroundColor: colors[1 % 4]),
      TaskCard(cost: 50, description: "GD", backgroundColor: colors[2 % 4]),
      TaskCard(cost: 50, description: "GD", backgroundColor: colors[3 % 4])
    ];

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
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 350.0,
            autoPlay: false,
            aspectRatio: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: taskCards.map((card) {
            return Builder(builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: card,
              );
            });
          }).toList(),
        ),
      ],
    );
  }
}
