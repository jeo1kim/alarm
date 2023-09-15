import 'package:alarm_example/screens/home.dart';
import 'package:alarm_example/screens/onboarding/number_page.dart';
import 'package:alarm_example/screens/onboarding/onboarding_page_2.dart';
import 'package:flutter/material.dart';
import 'onboarding_page_1.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Navigate to ExampleAlarmHomeScreen when on the last page.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ExampleAlarmHomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 5; i++)
                  Container(
                    margin: EdgeInsets.all(14),
                    width: 12,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == i
                          ? Colors.blue
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  OnBoardingIntroPage(
                    onNext: _nextPage,
                  ),
                  OnBoardingPage(
                    pageText: "Transformative mission that dispel sleep inertia",
                    onNext: _nextPage,
                  ),
                  OnBoardingTimePIckerPage(
                    onNext: _nextPage,
                  ),
                  OnBoardingSoundPickPage(
                    onNext: _nextPage,
                  ),
                  OnBoardingPage(
                    pageText: "Page 3",
                    onNext: _nextPage,
                  ),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final String pageText;
  final VoidCallback onNext;

  OnBoardingPage({required this.pageText, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              pageText,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 100), // Add the desired bottom margin
            child: SizedBox(
              height: 50,
              width: 320, // Set the desired width
              child: ElevatedButton(
                onPressed: onNext,
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 20),
                ),              ),
            ),
          ),
        ),
      ],
    );
  }
}




