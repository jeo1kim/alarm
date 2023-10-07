import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/history/habit_database.dart';
import '../../data/verse/verse_repository.dart';
import '../../theme/theme_constants.dart';
import '../../utils/premium_user.dart';
import '../../widgets/tile.dart';
import '../edit_alarm.dart';
import '../settings/settings.dart';
import 'month_summary.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreen();
}

class _HistoryScreen extends State<HistoryScreen> {
  bool isPremium = false;
  late List<AlarmSettings> alarms;
  int alarmCount = 0;

  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    db.updateDatabase();
    super.initState();
    initLocal();
  }

  Future<void> initLocal() async {
    isPremium = await isPremiumUser();
  }

  Future<void> navigateToSettingsScreen() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        ));
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
      alarmCount = alarms.length;
    });
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
      body: ListView(
        children: [
          MonthlySummary(
            datasets: db.heatMapDataSet,
            startDate: _myBox.get("START_DATE"),
          ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: db.todaysHabitList.length,
          //   itemBuilder: (context, index) {
          //     return HabitTile(
          //       habitName: db.todaysHabitList[index][0],
          //       habitCompleted: db.todaysHabitList[index][1],
          //       onChanged: (value) => checkBoxTapped(value, index),
          //       settingsTapped: (context) => openHabitSettings(index),
          //       deleteTapped: (context) => deleteHabit(index),
          //     );
          //   },
          // ),
        ],
      ),
      // floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
    );
  }
}
