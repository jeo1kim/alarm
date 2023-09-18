import 'dart:async';
import 'dart:io';
import 'package:alarm_example/screens/home.dart';
import 'package:alarm_example/screens/onboarding/onboarding.dart';
import 'package:alarm_example/utils/constant.dart';
import 'package:alarm_example/utils/store_config.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
  runApp(const MaterialApp(
      // theme: ThemeData(
      //   primaryColor: Colors.yellow,
      // ),
      home: AlarmHomeScreen()));
      // home: OnboardingScreen()));
}
