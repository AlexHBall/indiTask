import 'package:flutter/material.dart';
import 'package:inditask/utils/colors.dart';
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
    return Container(
      height: 542.0,
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
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(),
        ));
  }

  Widget nextButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 33.0, left: 5.0, right: 5.0),
        child: Container(
            width: 320,
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colour.blue.color,
            ),
            child: RawMaterialButton(
              fillColor: Colour.blue.color,
              splashColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(22.0),
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
            )));
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
          "When you don’t complete a task, you lose the amount of points    you waged.",
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
          children: <Widget>[
            page(),
            pageIndicator(),
            SizedBox(
              height: 30,
            ),
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

  Widget image() {
    return Padding(
        padding: EdgeInsets.only(top: imageTopPadding),
        child: Image.asset(imagePath));
  }

  Widget textHeader() {
    return Padding(
      padding: EdgeInsets.only(top: headerPadding),
      child: Text(headerText,
          style: TextStyle(
              color: Colour.blue.color,
              fontSize: 24,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget textBody() {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 30, bottom: 0, right: 30),
      child: Text(bodyText,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colour.blue.color,
              fontSize: 18,
              fontWeight: FontWeight.w400)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image(),
        textHeader(),
        textBody(),
      ],
    );
  }
}
