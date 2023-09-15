import 'package:alarm_example/animation/sunrise_animation.dart';
import 'package:flutter/material.dart';


class OnBoardingIntroPage extends StatefulWidget {
  final VoidCallback onNext;

  const OnBoardingIntroPage({super.key, required this.onNext});

  @override
  State<OnBoardingIntroPage> createState() => _OnBoardingIntroPage();
}

class _OnBoardingIntroPage extends State<OnBoardingIntroPage> {
  final String pageText = "Awaken to the Wisdom of His Word";
  final String additionalText = "RISE, your faithful morning call";

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SunriseAnimation(),
              SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20), // Add left and right margins
                child: Text(
                  pageText,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40), // Adjust the spacing between the texts
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
                onPressed: widget.onNext,
                child: Text(
                  "Next",
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
