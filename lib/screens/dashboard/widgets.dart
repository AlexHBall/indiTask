part of 'dashboard.dart';

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 15.0, top: 40.0),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.stats));
        },
        child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/images/ribbon.png')),
      ),
    );
  }
}

class TasksRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 14.0, top: 0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Tasks Due:',
                style: TextStyle(
                    color: Colour.darkPurple.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeRemaining extends StatefulWidget {
  final DateTime endTime;
  TimeRemaining({Key key, @required this.endTime}) : super(key: key);

  @override
  _TimeRemainingState createState() => _TimeRemainingState();
}

class _TimeRemainingState extends State<TimeRemaining> {
  @override
  Widget build(BuildContext context) {
    int time = widget.endTime.millisecondsSinceEpoch;
    return CountdownTimer(
      endTime: time,
      defaultDays: "==",
      defaultHours: "--",
      defaultMin: "**",
      defaultSec: "++",
      daysSymbol: "day ",
      hoursSymbol: "hr ",
      minSymbol: "min ",
      secSymbol: "sec",
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colour.blue.color),
    );
  }
}

class RemaingingTimeWidget extends StatelessWidget {
  final DateTime timeLeft;
  const RemaingingTimeWidget(this.timeLeft);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 65.0,
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
              child: Icon(
                Icons.alarm,
                size: 24,
              ),
            ),
            Flexible(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6.0),
                  child: TimeRemaining(
                    endTime: timeLeft,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class CompleteWidget extends StatelessWidget {
  final Function onSwipe;
  const CompleteWidget(this.onSwipe);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 18.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 65.0,
          child: Dismissible(
            onDismissed: (DismissDirection direction) async {
              onSwipe();
            },
            key: UniqueKey(),
            child: Row(
              children: [
                Container(
                  height: 65.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colour.blue.color,
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Image.asset('assets/images/swipeIcon.png')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text("Swipe to complete",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colour.blue.color)),
                ),
              ],
            ),
          ),
        ));
  }
}
