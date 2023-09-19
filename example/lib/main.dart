import 'dart:async';
import 'dart:io';
import 'package:alarm_example/screens/home.dart';
import 'package:alarm_example/screens/onboarding/onboarding.dart';
import 'package:alarm_example/utils/constant.dart';
import 'package:alarm_example/utils/store_config.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Check if onboarding has already been completed
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isFirstTimeUser = prefs.getBool('firstTimeUser') ?? true;

  if (Platform.isIOS) {
    StoreConfig(
      store: Store.appleStore,
      apiKey: appleApiKey,
    );
  } else if (Platform.isAndroid) {
    StoreConfig(
      store: Store.googlePlay,
      apiKey: googleApiKey,
    );
  }
  await Alarm.init(showDebugLogs: true);
  if (isFirstTimeUser) {
    // Show OnboardingScreen for first-time users
    await prefs.setBool('firstTimeUser', false); // Mark onboarding as completed
    runApp(const MaterialApp(
      home: OnboardingScreen(),
    ));
  } else {
    // Directly navigate to AlarmHomeScreen for subsequent runs
    await Alarm.init(showDebugLogs: true);
    runApp(const MaterialApp(
      home: AlarmHomeScreen(),
    ));
  }
}
