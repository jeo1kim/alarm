import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';

import '../../data/history/habit_database.dart';

class OnBoardingDonePage extends StatefulWidget {
  final VoidCallback onNext;

  const OnBoardingDonePage({super.key, required this.onNext});

  @override
  State<OnBoardingDonePage> createState() => _OnBoardingDonePage();
}

class _OnBoardingDonePage extends State<OnBoardingDonePage>
    with SingleTickerProviderStateMixin {
  final String pageText = "You are all set!";
  final String additionalText = "";
  late final AnimationController _controller;
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
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    _controller.forward();

    // Add a post-frame callback to show the keyboard after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void logHabit() {
    setState(() {
      db.todaysHabitList[0][4] = true;
      //BoxDecoration(color: Colors.amber[100]);
      //new ListTileTheme(selectedColor: Colors.amber[100],);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200, // Adjust as needed
                height: 200, // Adjust as needed
                child: Lottie.asset(
                  'animations/check-circle.json',
                  controller: _controller, // Use the controller
                  repeat: false, // Set repeat to false
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                // Add left and right margins
                child: Text(
                  pageText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20), // Adjust the spacing between the texts
              Text(
                additionalText,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
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
                onPressed: () {
                  logHabit();
                  widget.onNext();
                },
                child: Text(
                  "Let's go",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
