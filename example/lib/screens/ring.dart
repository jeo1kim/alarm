import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

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
  final String correctPhrase = "You raise me up";
  int currentIndex = 0;

  // Create a focus node for the hidden TextField
  final FocusNode _hiddenTextFieldFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RawMaterialButton(
                  onPressed: isStopButtonEnabled
                      ? () {
                    Alarm.stop(widget.alarmSettings.id)
                        .then((_) => Navigator.pop(context));
                  }
                      : null, // Disable the button when not enabled
                  fillColor: isStopButtonEnabled ? Colors.blue : Colors.grey,
                  child: Text(
                    "Rise",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
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
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey, // Initial gray color for the phrase
                    ),
                    children: [
                      for (int i = 0; i < correctPhrase.length; i++)
                        TextSpan(
                          text: correctPhrase[i],
                          style: TextStyle(
                            color: (userInput.length > i)
                                ? (userInput[i] == correctPhrase[i]
                                ? Colors.black // Turn black if correct
                                : Colors.red) // Turn red if wrong
                                : Colors.grey, // Stay gray if not typed yet
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // Hidden TextField for user input
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                cursorColor: Colors.transparent, // Hide the cursor
                style: TextStyle(
                  color: Colors.transparent, // Hide the entered text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Update the current index based on user input
  void _updateCurrentIndex() {
    if (currentIndex < correctPhrase.length && currentIndex < userInput.length) {
      if (correctPhrase[currentIndex] == userInput[currentIndex]) {
        currentIndex++;
      }
    }
  }
}
