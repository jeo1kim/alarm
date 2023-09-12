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
  final String correctPhrase = "You raise me up, so I can stand on mountains";

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
                  onPressed: () {
                    final now = DateTime.now();
                    Alarm.set(
                      alarmSettings: widget.alarmSettings.copyWith(
                        dateTime: DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                          now.minute,
                          0,
                          0,
                        ).add(const Duration(minutes: 1)),
                      ),
                    ).then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "Snooze",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                RawMaterialButton(
                  onPressed: isStopButtonEnabled
                      ? () {
                    Alarm.stop(widget.alarmSettings.id)
                        .then((_) => Navigator.pop(context));
                  }
                      : null, // Disable the button when not enabled
                  fillColor: isStopButtonEnabled ? Colors.blue : Colors.grey,
                  child: Text(
                    "Stop",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
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
            // Text field for user input
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    userInput = text;
                    isStopButtonEnabled = userInput == correctPhrase;
                  });
                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}
