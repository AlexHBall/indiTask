import 'package:flutter/material.dart';
import 'package:inditask/utils/colors.dart';
import 'package:inditask/utils/size.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 4;
  int _currentPage = 0;
  String _text = "Next";
  PageController _pageController;
  List<Widget> onBoardPages;

  void _setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("welcome", true);
    prefs.setInt("lastAlarmId", 0);
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Colour.blue.color : Colour.grey.color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget page() {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.safeBlockVertical * 75,
      child: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              FocusScope.of(context).unfocus();
              _currentPage = page;
            });
          },
          children: onBoardPages),
    );
  }

  Widget pageIndicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildPageIndicator());
  }

  Widget nextButton() {
    SizeConfig().init(context);

    return Padding(
            padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
      child: ButtonTheme(
        minWidth: SizeConfig.safeBlockHorizontal * 85,
        height: SizeConfig.safeBlockVertical * 10,
        child: MaterialButton(
          color: Colour.blue.color,
          splashColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
            child: Text(_text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          onPressed: () async {
            setState(() async {
              _currentPage++;
              if (_currentPage == 3) {
                _text = "Get Started";
              }

              if (_currentPage == 4) {
                _setPrefs();
                Navigator.pushNamed(
                  context,
                  "/",
                );
              }

              _pageController.animateToPage(_currentPage,
                  duration: kTabScrollDuration, curve: Curves.ease);
            });
          },
          shape: const StadiumBorder(),
        ),
      ),
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    onBoardPages = [
      Screen('assets/images/onboard1.png', "No more procrastination",
          "Do the things you need to do without procrastinating", 78.0, 60.0),
      Screen(
          'assets/images/onboard2.png',
          "Points as the motivator",
          "Wage points for every task. Compare with friends and see who is most productive.",
          122.0,
          40.0),
      Screen(
          'assets/images/onboard3.png',
          "Based on loss aversion",
          "When you don’t complete a task, you lose the amount of points \nyou waged.",
          146.0,
          60.0),
      Screen('assets/images/onboard4.png', "Welcome To Inditask",
          "Motivating people through points", 183.0, 60.0),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colour.backGrey.color,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            page(),
            pageIndicator(),
            nextButton(),
          ],
        ));
  }
}

class Screen extends StatelessWidget {
  final String imagePath;
  final String headerText;
  final String bodyText;
  final double imageTopPadding;
  final double headerPadding;
  Screen(this.imagePath, this.headerText, this.bodyText, this.imageTopPadding,
      this.headerPadding);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double w = SizeConfig.safeBlockHorizontal;
    double h = SizeConfig.safeBlockVertical;
    
    Widget image() {
      return Container(
        height: h * 50,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: h * 5),
          child: Image.asset(
            imagePath,
            height: h * 30,
            width: w * 100,
          ),
        ),
      );
    }

    Widget textHeader() {
      return Text(headerText,
          style: TextStyle(
              color: Colour.blue.color,
              fontSize: 24,
              fontWeight: FontWeight.bold));
    }

    Widget textBody() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0, vertical: h * 2.5),
        child: Text(bodyText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colour.blue.color,
                fontSize: 18,
                fontWeight: FontWeight.w400)),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 5),
      child: Column(
        children: [
          image(),
          textHeader(),
          textBody(),
        ],
      ),
    );
  }
}
