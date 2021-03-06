part of 'dashboard.dart';

class CardView extends StatefulWidget {
  final List<TaskCard> tasks;
  final PageController ctrl;
  final Function onChange;
  final int currentTask;
  const CardView(this.tasks, this.ctrl, this.onChange, this.currentTask);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    int _currentPage = widget.currentTask;
    Widget _indicator(bool isActive, int i) {
      int numberOfPages = widget.tasks.length;

      BoxDecoration getBoxDec() {
        if (isActive) {
          return BoxDecoration(
              color: Colour.blue.color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10));
        } else {
          if (i == 0) {
            return BoxDecoration(
              color: Colour.grey.color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            );
          } else if (i == numberOfPages - 1) {
            return BoxDecoration(
              color: Colour.grey.color,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10)),
            );
          } else {
            // return box no borders
            return BoxDecoration(
              color: Colour.grey.color,
              shape: BoxShape.rectangle,
            );
          }
        }
      }

      return AnimatedContainer(
          duration: Duration(milliseconds: 150),
          height: 10.0,
          width: isActive ? 300.0 / numberOfPages : 300.0 / numberOfPages,
          decoration: getBoxDec());
    }

    List<Widget> _buildPageIndicator() {
      List<Widget> list = [];
      for (int i = 0; i < widget.tasks.length; i++) {
        list.add(
            i == _currentPage ? _indicator(true, i) : _indicator(false, i));
      }
      return list;
    }

    Widget pageIndicator() {
      return Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 10,
            right: 20,
            bottom: SizeConfig.safeBlockVertical * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ),
      );
    }

    Widget page() {
      return Container(
        height: SizeConfig.safeBlockVertical * 50,
        child: PageView.builder(
            controller: widget.ctrl,
            onPageChanged: (index) {
              _currentPage = index;
              widget.onChange(index);
            },
            itemCount: widget.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.tasks[index];
            }),
      );
    }

    return Container(
      height: SizeConfig.safeBlockVertical * 56,
      // width: SizeConfig.,
      child: Column(
        children: [
          pageIndicator(),
          page(),
        ],
      ),
    );
  }
}
