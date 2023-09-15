import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:alarm_example/screens/home.dart';
import 'package:flutter/material.dart';
import 'onboarding_intro.dart';
import 'onboarding_sound_picker.dart';
import 'onboarding_time_picker.dart';
import 'onboarding_unlock.dart';


class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  late bool creating;
  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool volumeMax;
  late bool showNotification;
  late String assetAudio;
  bool loading = false;

  bool isToday() {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );

    return now.isBefore(dateTime);
  }

  AlarmSettings alarmSettings = AlarmSettings(
    id: 42,
    dateTime: DateTime.now(),
    assetAudioPath: 'assets/piano.mp3',
    vibrate: false,
    volumeMax: false,
  );

  void updateAlarmSettings(AlarmSettings? updatedSettings) {
    setState(() {
      alarmSettings = updatedSettings!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Add a post-frame callback to show the keyboard after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  void _createAlarm() {
    setState(() => loading = true);
    updateAlarmSettings(alarmSettings);

    Alarm.set(alarmSettings: alarmSettings);
    setState(() => loading = false);
  }

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _createAlarm();
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
                  OnBoardingTimePickerPage(
                    alarmSettings: alarmSettings,
                    updateAlarmSettings: updateAlarmSettings, // Pass the callback
                    onNext: _nextPage,
                  ),
                  OnBoardingSoundPickPage(
                    alarmSettings: alarmSettings,
                    updateAlarmSettings: updateAlarmSettings, // Pass the callback
                    onNext: _nextPage,
                  ),
                  OnBoardingUnlockPage(
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




