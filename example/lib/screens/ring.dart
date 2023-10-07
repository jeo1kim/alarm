import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:alarm_example/data/verse/verse_repository.dart';
import 'package:hive_flutter/adapters.dart';

import '../data/history/habit_database.dart';

class ExampleAlarmRingScreen extends StatefulWidget {
  final AlarmSettings alarmSettings;

  const ExampleAlarmRingScreen({Key? key, required this.alarmSettings})
      : super(key: key);

  @override
  _ExampleAlarmRingScreenState createState() => _ExampleAlarmRingScreenState();
}

class _ExampleAlarmRingScreenState extends State<ExampleAlarmRingScreen> {
  bool isStopButtonEnabled = false;
  String userInput = "";

  late Verse verse;
  late String verseTitle = "";
  late String correctPhrase = "";

  int currentIndex = 0;

  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");

  // Create a focus node for the hidden TextField
  final FocusNode _hiddenTextFieldFocus = FocusNode();

  getVerse() async {
    return await PhraseRepository.getRandomVerse();
  }

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    db.updateDatabase();
    super.initState();

    _initializeState();
  }

  void logHabit() {
    setState(() {
      db.todaysHabitList[0][4] = true;
      //BoxDecoration(color: Colors.amber[100]);
      //new ListTileTheme(selectedColor: Colors.amber[100],);
    });
    db.updateDatabase();
  }

  Future<void> _initializeState() async {
    Verse fetchedVerse = await getVerse();
    setState(() {
      verse = fetchedVerse;
      verseTitle = widget.alarmSettings.verse ?? verse.verse;
      correctPhrase = widget.alarmSettings.verseText ?? verse.phrase;
    });

    // Add a post-frame callback to show the keyboard after the screen is built
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_hiddenTextFieldFocus);
    });
  }


  @override
  void dispose() {
    // Dispose of the focus node when the screen is disposed
    _hiddenTextFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button action
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 50,
                    width: 320,
                    child: ElevatedButton(
                      onPressed: isStopButtonEnabled
                          ? () {
                              // Alarm.stop(widget.alarmSettings.id)
                              logHabit();
                              Alarm.set(
                                alarmSettings: widget.alarmSettings.copyWith(
                                  dateTime: widget.alarmSettings.dateTime
                                      .add(const Duration(days: 1)),
                                ),
                              ).then((_) => Navigator.pop(context));
                            }
                          : null, // Disable the button when not enabled
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(isStopButtonEnabled ? Theme.of(context).primaryColor : Colors.grey),
                      ),
                      child: Text(
                        "Type to Unlock",
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
                  padding: const EdgeInsets.all(20.0),
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
                padding: const EdgeInsets.all(20.0),
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
    );
  }

  // Update the current index based on user input
  void _updateCurrentIndex() {
    if (currentIndex < correctPhrase.length &&
        currentIndex < userInput.length) {
      if (correctPhrase[currentIndex] == userInput[currentIndex]) {
        currentIndex++;
      }
    }
  }
}
