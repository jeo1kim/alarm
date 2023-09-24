import 'dart:async';
import 'dart:io';
import 'package:alarm_example/screens/home.dart';
import 'package:alarm_example/screens/onboarding/onboarding.dart';
import 'package:alarm_example/theme/theme_constants.dart';
import 'package:alarm_example/theme/theme_manager.dart';
import 'package:alarm_example/utils/constant.dart';
import 'package:alarm_example/utils/store_config.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final ThemeManager _themeManager = ThemeManager();
  bool isFirstTimeUser = true; // Initialize this as needed

  void _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _initFirebase()
  }

  Future<void> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTimeUser = prefs.getBool('firstTimeUser') ?? true;

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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget homeScreen =
    isFirstTimeUser ? OnboardingScreen() : AlarmHomeScreen();

    return MaterialApp(
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeManager.themeMode,
      home: homeScreen,
    );
  }
}
