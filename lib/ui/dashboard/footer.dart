part of 'dashboard.dart';

class TimeRemaining extends StatefulWidget {
  final DateTime endTime;
  TimeRemaining({Key key, @required this.endTime}) : super(key: key);

  @override
  _TimeRemainingState createState() => _TimeRemainingState();
}

class _TimeRemainingState extends State<TimeRemaining> {
  @override
  Widget build(BuildContext context) {
    // var t = widget.endTime.millisecondsSinceEpoch;
    // var t2 = DateTime.now().millisecondsSinceEpoch;
    // print(t - t2);
    return CountdownTimer(
      //TODO: Why is diff coming up negative here ?
      // endTime:  widget.endTime.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch,
      endTime: DateTime.now().millisecondsSinceEpoch + 100000 * 60 * 60,
      defaultDays: "==",
      defaultHours: "--",
      defaultMin: "**",
      defaultSec: "++",
      daysSymbol: "day ",
      hoursSymbol: "hr ",
      minSymbol: "min ",
      secSymbol: "sec",
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1C2638)),
    );
  }
}

class RemaingingTimeWidget extends StatelessWidget {
  final DateTime timeLeft;
  const RemaingingTimeWidget(this.timeLeft);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                child: TimeRemaining(
                  endTime: timeLeft,
                )),
          ],
        ),
      ),
    );
  }
}

class CompleteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 65.0,
          child: Dismissible(
            onDismissed: (DismissDirection direction) async {
              print("MARK ME AS COMPLETE");
            },
            key: UniqueKey(),
            child: Row(
              children: [
                Container(
                  height: 65.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF1C2638),
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
                          color: Color(0xFF1C2638))),
                ),
              ],
            ),
          ),
        ));
  }
}
