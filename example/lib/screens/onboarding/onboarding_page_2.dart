import 'package:alarm_example/animation/sunrise_animation.dart';
import 'package:flutter/material.dart';

import 'number_page.dart';

class OnboardingPageSetTime extends StatelessWidget {
  final String pageText = "Choose the instrument you prefer";
  final VoidCallback onNext;

  OnboardingPageSetTime({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                onPressed: onNext,
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
