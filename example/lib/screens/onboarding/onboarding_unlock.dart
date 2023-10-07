import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alarm_example/data/verse/verse_repository.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/history/habit_database.dart';

class OnBoardingUnlockPage extends StatefulWidget {
  final String pageText = "Type to unlock";
  final VoidCallback onNext;

  const OnBoardingUnlockPage({super.key, required this.onNext});

  @override
  _OnBoardingUnlockPageState createState() =>
      _OnBoardingUnlockPageState();
}

class _OnBoardingUnlockPageState extends State<OnBoardingUnlockPage> {

  bool isStopButtonEnabled = false;
  String userInput = "";

  late Verse verse;
  late String verseTitle;
  late String correctPhrase = "";
  int currentIndex = 0;

  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");
  // Create a focus node for the hidden TextField
  final FocusNode _hiddenTextFieldFocus = FocusNode();

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    db.updateDatabase();

    super.initState();

    verseTitle = "1 Corinthians 16:14";
    correctPhrase = kDebugMode ? "test" : "Do everything in love";

    // Add a post-frame callback to show the keyboard after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_hiddenTextFieldFocus);
    });
  }

  void logHabit() {
    setState(() {
      db.todaysHabitList[0][1] = true;
      db.todaysHabitList[0][2] = verseTitle;
      db.todaysHabitList[0][3] = correctPhrase;
      //BoxDecoration(color: Colors.amber[100]);
      //new ListTileTheme(selectedColor: Colors.amber[100],);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            logHabit();
                            isStopButtonEnabled
                                ? widget.onNext
                                : null;
                             // Disable the button when not enabled
                          },
                          style:
                          ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(isStopButtonEnabled ? Theme.of(context).primaryColor : Colors.grey),
                          ),
                          child: Text(
                            "Type to unlock",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      // Give focus to the hidden TextField when the phrase is tapped
                      FocusScope.of(context).requestFocus(_hiddenTextFieldFocus);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.grey, // Initial gray color for the phrase
                          ),
                          children: [
                            for (int i = 0; i < correctPhrase.length; i++)
                              TextSpan(
                                text: (i >= userInput.length)
                                    ? correctPhrase[i]
                                    : (correctPhrase[i] == " " &&
                                    userInput[i] != " ")
                                    ? "_"
                                    : (userInput[i] == correctPhrase[i])
                                    ? userInput[i]
                                    : correctPhrase[i],
                                // Show correct character in red
                                style: TextStyle(
                                  color: (userInput.length > i)
                                      ? (userInput[i] == correctPhrase[i])
                                      ? Colors
                                      .black // Turn black if correct or space
                                      : Colors
                                      .red // Turn red if wrong and not space
                                      : Colors.grey, // Stay gray if not typed yet
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Hidden TextField for user input
                  Text(
                    verseTitle,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: TextField(
                      focusNode: _hiddenTextFieldFocus,
                      showCursor: false,
                      onChanged: (text) {
                        setState(() {
                          userInput = text;
                          _updateCurrentIndex();
                          isStopButtonEnabled = userInput == correctPhrase;
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.transparent,
                      // Hide the cursor
                      style: const TextStyle(
                        color: Colors.transparent, // Hide the entered text
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
  void _updateCurrentIndex() {
    if (currentIndex < correctPhrase.length &&
        currentIndex < userInput.length) {
      if (correctPhrase[currentIndex] == userInput[currentIndex]) {
        currentIndex++;
      }
    }
  }
}
