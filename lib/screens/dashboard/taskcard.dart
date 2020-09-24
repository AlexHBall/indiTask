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
              padding: const EdgeInsets.only(
                  left: 53.0, top: 90.0, right: 30.0, bottom: 50.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  description,
                  overflow: TextOverflow.ellipsis,  maxLines: 3,

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
