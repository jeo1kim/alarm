import 'dart:async';
import 'package:alarm_example/screens/home.dart';
import 'package:alarm_example/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Alarm.init(showDebugLogs: true);
  runApp(const MaterialApp(
      // theme: ThemeData(
      //   primaryColor: Colors.yellow,
      // ),

      home: OnboardingScreen()));
}
