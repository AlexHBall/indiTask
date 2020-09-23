part of 'dashboard.dart';

class HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 15.0, top: 40.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Image.asset('assets/images/ribbon.png'),
        MaterialButton(
          onPressed: () {},
          color: Color(0xFF1C2638),
          textColor: Colors.white,
          child: Icon(
            Icons.settings,
            size: 20,
          ),
          padding: EdgeInsets.all(10),
          shape: CircleBorder(),
        )
      ]),
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
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Tasks Due:',
                style: TextStyle(
                    color: Color(0xFF272140),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              onPressed: () {
            BlocProvider.of<TabBloc>(context).add(TabUpdated(AppTab.stats));

              },
              textColor: Colors.white,
              child: Image.asset('assets/images/listicon.png'),
              padding: EdgeInsets.all(10),
              shape: ContinuousRectangleBorder(),
            )
            //
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
    return CountdownTimer(
      endTime: widget.endTime.millisecondsSinceEpoch,
      // endTime: DateTime.now().millisecondsSinceEpoch + 1000,
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
    print("remaining time being built");
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
