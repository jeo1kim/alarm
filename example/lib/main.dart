import 'dart:async';
import 'dart:io';
import 'package:alarm_example/screens/home.dart';
import 'package:alarm_example/screens/onboarding/onboarding.dart';
import 'package:alarm_example/theme/theme_constants.dart';
import 'package:alarm_example/theme/theme_manager.dart';
import 'package:alarm_example/utils/constant.dart';
import 'package:alarm_example/utils/store_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/purchases_configuration.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (Platform.isIOS) {
    StoreConfig(
      store: Store.appStore,
      apiKey: appleApiKey,
    );
  } else if (Platform.isAndroid) {
    StoreConfig(
      store: Store.playStore,
      apiKey: googleApiKey,
    );
  }
  WidgetsFlutterBinding.ensureInitialized();
  await _configureSDK();
  await _initFirebase();
  runApp(MyApp());
}

Future<void> _configureSDK() async {
  // Enable debug logs before calling `configure`.
  await Purchases.setLogLevel(LogLevel.debug);

  PurchasesConfiguration configuration;

  configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
    ..appUserID = null
    ..observerMode = false;

  await Purchases.configure(configuration);
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
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
  bool? isFirstTimeUser;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      isFirstTimeUser = prefs.getBool('firstTimeUser') ?? true;
      await Alarm.init(showDebugLogs: true);
      setState(() {});
    } catch (e) {
      // Handle the error, maybe show a user-friendly message or log it
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstTimeUser == null) {
      return const CircularProgressIndicator(); // Show a loading indicator while waiting
    }

    Widget homeScreen = isFirstTimeUser! ? const OnboardingScreen() : const AlarmHomeScreen();

    return MaterialApp(
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: _themeManager.themeMode,
      home: homeScreen,
    );
  }
}

