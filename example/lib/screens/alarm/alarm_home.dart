import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm_example/screens/edit_alarm.dart';
import 'package:alarm_example/screens/ring.dart';
import 'package:alarm_example/screens/settings/settings.dart';
import 'package:alarm_example/screens/verses/category_container.dart';
import 'package:alarm_example/widgets/tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_data.dart';
import '../../data/verse/verse_repository.dart';
import '../../main.dart';
import '../../theme/theme_constants.dart';
import '../../utils/constant.dart';
import '../../utils/premium_user.dart';

class AlarmHomeScreen extends StatefulWidget {
  const AlarmHomeScreen({Key? key}) : super(key: key);

  @override
  State<AlarmHomeScreen> createState() => _AlarmHomeScreenState();
}

class _AlarmHomeScreenState extends State<AlarmHomeScreen> {
  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;
  int alarmCount = 0;
  bool isPremium = false;

  Future<void> initPlatformState() async {
    // Enable debug logs before calling `configure`.
    await Purchases.setDebugLogsEnabled(true);

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      appData.appUserID = await Purchases.appUserID;

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      (customerInfo.entitlements.all[entitlementID] != null &&
              customerInfo.entitlements.all[entitlementID]!.isActive)
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;

      setState(() {});
    });
    isPremium = await isPremiumUser();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstTimeUser', false);
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      alarmCount = alarms.length;
    });
  }

  Future<void> navigateToSettingsScreen() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        ));
  }

  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ExampleAlarmRingScreen(alarmSettings: alarmSettings),
      ),
    );
    loadAlarms();
  }


  Future<void> launchCreateAlarmDialog(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        backgroundColor: kBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: AlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  @override
  void dispose() {
    // subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rise Alarm'),
        leading: Builder(
          // Add this Builder widget
          builder: (context) => IconButton(
            icon: Icon(Icons.menu), // Hamburger menu icon
            onPressed: () {
              navigateToSettingsScreen();
            },
          ),
        ),
        actions: [
          if (!isPremium)
            IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () => performMagic(context),
            ),
          IconButton(
            icon: Icon(Icons.add_alarm),
            onPressed: () => launchCreateAlarmDialog(null),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: alarms.isNotEmpty
                  ? ListView.separated(
                      itemCount: alarms.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return AlarmItemTile(
                          key: Key(alarms[index].id.toString()),
                          title: TimeOfDay(
                            hour: alarms[index].dateTime.hour,
                            minute: alarms[index].dateTime.minute,
                          ).format(context),
                          onPressed: () =>
                              launchCreateAlarmDialog(alarms[index]),
                          onDismissed: () {
                            Alarm.stop(alarms[index].id)
                                .then((_) => loadAlarms());
                          },
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "No alarms set",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
            ),
            Container(
              height: 200, // Adjust the height as needed
              width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: PhraseRepository.getVerseCategories().keys.length,
                itemBuilder: (context, index) {
                  final categoryTitle = PhraseRepository.getVerseCategories()
                      .keys
                      .elementAt(index);
                  final verses =
                      PhraseRepository.getVerseCategories()[categoryTitle]!;
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      right: index == PhraseRepository.getVerseCategories().keys.length - 1 ? 20 : 0,
                    ),
                    child: VerseCategoryContainer(
                      category: VerseCategory(
                        title: categoryTitle,
                        verseCount: verses.length,
                        isUnlocked: categoryTitle == "Free verses" ? true : isPremium,
                        verses: verses
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ... [rest of your Scaffold code]
      floatingActionButton: kDebugMode
          ? Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                final alarmSettings = AlarmSettings(
                  id: 42,
                  dateTime: DateTime.now(),
                  assetAudioPath: 'assets/piano.mp3',
                  vibrate: false,
                  volumeMax: false,
                );
                Alarm.set(alarmSettings: alarmSettings);
              },
              backgroundColor: Colors.red,
              heroTag: null,
              child: const Text("RING NOW", textAlign: TextAlign.center),
            ),

          ],
        ),
      )
          : null, // Set the FloatingActionButton to null in production mode
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
