import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:alarm_example/screens/home.dart';
import 'package:alarm_example/screens/onboarding/onboarding_calendar.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/history/habit_database.dart';
import '../../data/verse/verse_repository.dart';
import 'onboarding_done.dart';
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
    notificationTitle: 'Romans 15:33',
    notificationBody: 'May the God of peace be with you all. Amen.',
    stopOnNotificationOpen: false,
  );

  getVerse() async {
    return await PhraseRepository.getRandomVerse();
  }

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
            builder: (_) => NavigationScreen(),
          ),
        );
      }
    });
    setState(() => loading = false);
  }

  void _nextPage() {
    if (_currentPage < 5) {
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
            children: <Widget>[

              Visibility(
                visible: _currentPage <= 3,
                child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 15),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.amber,
                      dotColor: Colors.grey.shade400,
                    ),
                  ),
                ),
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
                    OnBoardingCalendarPage(
                      onNext: _nextPage,
                    ),
                    // OnBoardingPage(
                    //   pageText: "“What we do first thing in the morning, over time, says a lot about our true priorities.”",
                    //   onNext: _nextPage,
                    // ),
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
                    OnBoardingDonePage(
                      onNext: _nextPage,
                    )
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }
}
