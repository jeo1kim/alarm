import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class OnBoardingTimePIckerPage extends StatefulWidget {
  final VoidCallback onNext;

  const OnBoardingTimePIckerPage({super.key, required this.onNext});

  @override
  State<OnBoardingTimePIckerPage> createState() => _OnBoardingTimePIckerPageState();
}

class _OnBoardingTimePIckerPageState extends State<OnBoardingTimePIckerPage> {
  var hour = 0;
  var minute = 0;

  @override
  void initState() {
    super.initState();

    // Add a post-frame callback to show the keyboard after the screen is built
    WidgetsBinding.instance?.addPostFrameCallback((_) {
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
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            hour = value;
                          });
                        },
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                        selectedTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 30),
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
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            minute = value;
                          });
                        },
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 20),
                        selectedTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 30),
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
              onPressed: widget.onNext,
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
