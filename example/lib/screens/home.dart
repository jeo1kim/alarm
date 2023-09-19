import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm_example/screens/edit_alarm.dart';
import 'package:alarm_example/screens/paywall/paywall.dart';
import 'package:alarm_example/screens/ring.dart';
import 'package:alarm_example/screens/settings/settings.dart';
import 'package:alarm_example/widgets/tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../app_data.dart';
import '../utils/constant.dart';
import '../utils/store_config.dart';

class AlarmHomeScreen extends StatefulWidget {
  const AlarmHomeScreen({Key? key}) : super(key: key);

  @override
  State<AlarmHomeScreen> createState() => _AlarmHomeScreenState();
}

class _AlarmHomeScreenState extends State<AlarmHomeScreen> {
  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;

  void performMagic() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    if (customerInfo.entitlements.all[entitlementID] != null &&
        customerInfo.entitlements.all[entitlementID]?.isActive == true) {
      // User has subscription, show them the feature
    } else {
      Offerings? offerings;
      try {
        offerings = await Purchases.getOfferings();
      } on PlatformException catch (e) {
        // Error finding the offerings, handle the error.
      }

      if (offerings == null || offerings.current == null) {
        // offerings are empty, show a message to your user
      } else {
        // current offering is available, show paywall
        // ignore: use_build_context_synchronously
        await showModalBottomSheet(
          useRootNavigator: true,
          isDismissible: true,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return PaywallScreen(
                offering: offerings?.current,
              );
            });
          },
        );
      }
    }
  }

  Future<void> initPlatformState() async {
    // Enable debug logs before calling `configure`.
    await Purchases.setDebugLogsEnabled(true);

    /*
    - appUserID is nil, so an anonymous ID will be generated automatically by the Purchases SDK. Read more about Identifying Users here: https://docs.revenuecat.com/docs/user-ids

    - observerMode is false, so Purchases will automatically handle finishing transactions. Read more about Observer Mode here: https://docs.revenuecat.com/docs/observer-mode
    */
    PurchasesConfiguration configuration;
    if (StoreConfig.isForGooglePlay()) {
      configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
        ..appUserID = null
        ..observerMode = false;
    } else {
      configuration = PurchasesConfiguration(StoreConfig.instance.apiKey)
        ..appUserID = null
        ..observerMode = false;
    }
    await Purchases.configure(configuration);

    appData.appUserID = await Purchases.appUserID;

    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      appData.appUserID = await Purchases.appUserID;

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      (customerInfo.entitlements.all[entitlementID] != null &&
              customerInfo.entitlements.all[entitlementID]!.isActive)
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;

      setState(() {});
    });
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) {
        if (alarmSettings.id != 42) {
          navigateToRingScreen(alarmSettings);
        }
      },
    );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
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
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: ExampleAlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rise Alarm'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () {
              performMagic();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              navigateToSettingsScreen();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: alarms.isNotEmpty
            ? ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ExampleAlarmTile(
                    key: Key(alarms[index].id.toString()),
                    title: TimeOfDay(
                      hour: alarms[index].dateTime.hour,
                      minute: alarms[index].dateTime.minute,
                    ).format(context),
                    onPressed: () => navigateToAlarmScreen(alarms[index]),
                    onDismissed: () {
                      Alarm.stop(alarms[index].id).then((_) => loadAlarms());
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
      floatingActionButton: kDebugMode
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  FloatingActionButton(
                    onPressed: () => navigateToAlarmScreen(null),
                    child: const Icon(Icons.alarm_add_rounded, size: 33),
                  ),
                ],
              ),
            )
          : null, // Set the FloatingActionButton to null in production mode
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
