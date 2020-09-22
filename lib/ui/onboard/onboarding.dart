import 'package:flutter/material.dart';
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
      //TODO: Align the text here properly
      Screen(
          'assets/images/onboard3.png',
          "Based on loss aversion",
          "When you don’t complete a task, you lose the amount of points you waged.",
          146.0,
          60.0),
      Screen('assets/images/onboard4.png', "Welcome To Inditask",
          "Motivating people through points", 183.0, 60.0),
    ];
    super.initState();
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
        color: isActive ? Color(0xFF1C2638) : Color(0xFFE8E8E8),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F7FB),
        body: Column(
          children: <Widget>[
            Container(
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
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                )),
            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () async {
                int _nextPage = _currentPage++;
                if (_nextPage == 3) {
                  setState(() {
                    _text = 'Get Started';
                  });
                }
                if (_nextPage == 4) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("welcome", true);
                  
                  Navigator.pushNamedAndRemoveUntil(context, "/tasks",
                      (Route<dynamic> route) {
                    return false;
                  });
                }

                _pageController.animateToPage(_nextPage,
                    duration: kTabScrollDuration, curve: Curves.ease);
              },
              child: Container(
                width: 321,
                height: 66,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xFF1C2638),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Text(_text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
            ),
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
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(top: imageTopPadding),
            child: Image.asset(imagePath)),
        Padding(
          padding: EdgeInsets.only(top: headerPadding),
          child: Text(headerText,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Color(0xFF1C2638),
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, left: 30, bottom: 0, right: 30),
          child: Text(bodyText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Color(0xFF1C2638),
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
