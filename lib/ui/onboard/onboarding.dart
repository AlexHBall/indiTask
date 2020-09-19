import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          "Do the things you need to do without procrastinating"),
      Screen('assets/images/onboard2.png', "Points as the motivator",
          "Wage points for every task. Compare with friends and see who is most productive."),
      Screen('assets/images/onboard3.png', "Based on loss aversion",
          "When you don’t complete a task, you lose the amount of points you waged."),
      Screen('assets/images/onboard4.png', "Welcome To Inditask",
          "Motivating people through points"),
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

  void _handlePageChange() {
    int _nextPage = _currentPage++;
    if (_nextPage == 3) {
      setState(() {
        _text = 'Get Started';
      });
    }
    _pageController.animateToPage(_nextPage,
        duration: kTabScrollDuration, curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: 600.0,
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
          onTap: () {  int _nextPage = _currentPage++;
    if (_nextPage == 3) {
      setState(() {
        _text = 'Get Started';
      });
    }
    _pageController.animateToPage(_nextPage,
        duration: kTabScrollDuration, curve: Curves.ease);},
          child: Container(
            width: 321,
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xFF1C2638),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(_text, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ),
        // RaisedButton(
        //   onPressed: ,
        //   textColor: Colors.white,
        //   padding: const EdgeInsets.all(0.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Color(0xFF1C2638),
        //       border: Border.all(width: 20.0),
        //       borderRadius: BorderRadius.all(
        //           Radius.circular(5.0) //         <--- border radius here
        //           ),
        //     ),
        //     // padding: const EdgeInsets.all(10.0),
        //     child: Text(_text,
        //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        //   ),
        // ),
      ],
    ));
  }
}

class Screen extends StatelessWidget {
  final String imagePath;
  final String headerText;
  final String bodyText;
  Screen(this.imagePath, this.headerText, this.bodyText);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 78),
          child: Image(image: AssetImage(imagePath)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Text(headerText,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Color(0xFF1C2638),
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 55, bottom: 62, right: 55),
          child: Text(bodyText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Color(0xFF1C2638),
                  fontSize: 18,
                  fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }
}
