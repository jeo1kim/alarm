import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class OnBoardingTimePickerPage extends StatefulWidget {
  final VoidCallback onNext;
  final AlarmSettings? alarmSettings;
  final Function(AlarmSettings?) updateAlarmSettings; // Add this callback

  const OnBoardingTimePickerPage({
    super.key,
    this.alarmSettings,
    required this.updateAlarmSettings, // Add this line
    required this.onNext
  });

  @override
  State<OnBoardingTimePickerPage> createState() => _OnBoardingTimePickerPageState();
}

class _OnBoardingTimePickerPageState extends State<OnBoardingTimePickerPage> {
  var hour = 7;
  var minute = 0;

  @override
  void initState() {
    super.initState();

    // Add a post-frame callback to show the keyboard after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Set the time to Rise",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        value: hour,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 80,
                        onChanged: (value) {
                          setState(() {
                            hour = value;
                          });
                        },
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 30),
                        selectedTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 40),
                        decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                color: Colors.blue,
                              ),
                              bottom: BorderSide(color: Colors.blue)),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        ":",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(width: 15),
                      NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        value: minute,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 80,
                        onChanged: (value) {
                          setState(() {
                            minute = value;
                          });
                        },
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 30),
                        selectedTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 40),
                        decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                color: Colors.blue,
                              ),
                              bottom: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                final now = DateTime.now();
                final updatedAlarmSettings = widget.alarmSettings?.copyWith(
                  dateTime: DateTime(
                    now.year,
                    now.month,
                    now.day,
                    hour,
                    minute,
                    0,
                    0,
                  ),
                );
                widget.updateAlarmSettings(updatedAlarmSettings);

                widget.onNext();
              },
              child: Text(
                "Set",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
