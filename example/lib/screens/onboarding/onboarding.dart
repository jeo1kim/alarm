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

  AlarmSettings alarmSettings = AlarmSettings(
    id: 42,
    dateTime: DateTime.now(),
    assetAudioPath: 'assets/piano.mp3',
    loopAudio: true,
    vibrate: false,
    volumeMax: false,
    fadeDuration: 10,
    notificationTitle: 'Time to Rise',
    notificationBody: 'Daily Word of God',
    stopOnNotificationOpen: false,
  );

  void updateAlarmSettings(AlarmSettings updatedSettings) {
    setState(() {
      alarmSettings = alarmSettings.copyWith(
          id: updatedSettings.id,
          dateTime: updatedSettings.dateTime,
          assetAudioPath: updatedSettings.assetAudioPath
      );
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
    // updateAlarmSettings(alarmSettings);
    Alarm.set(alarmSettings: alarmSettings).then((res) {
      if (res) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => AlarmHomeScreen(),
          ),
        );
      }
    });
    setState(() => loading = false);
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _createAlarm();
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
                  for (int i = 0; i < 4; i++)
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
                  physics: NeverScrollableScrollPhysics(), // Disable swiping
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
                      pageText: "“What we do first thing in the morning, over time, says a lot about our true priorities.”",
                      onNext: _nextPage,
                    ),
                    OnBoardingTimePickerPage(
                      alarmSettings: alarmSettings,
                      updateAlarmSettings: updateAlarmSettings,
                      // Pass the callback
                      onNext: _nextPage,
                    ),
                    OnBoardingSoundPickPage(
                      alarmSettings: alarmSettings,
                      updateAlarmSettings: updateAlarmSettings,
                      // Pass the callback
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                pageText,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 100),
            // Add the desired bottom margin
            child: SizedBox(
              height: 50,
              width: 320, // Set the desired width
              child: ElevatedButton(
                onPressed: onNext,
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 20),
                ),),
            ),
          ),
        ),
      ],
    );
  }
}




