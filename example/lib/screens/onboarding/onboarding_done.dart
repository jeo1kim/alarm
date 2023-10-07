import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingDonePage extends StatefulWidget {
  final VoidCallback onNext;

  const OnBoardingDonePage({super.key, required this.onNext});

  @override
  State<OnBoardingDonePage> createState() => _OnBoardingDonePage();
}

class _OnBoardingDonePage extends State<OnBoardingDonePage>
    with SingleTickerProviderStateMixin {
  final String pageText = "You are all set!";
  final String additionalText = "Let's go";
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
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
                width: 150,  // Adjust as needed
                height: 150, // Adjust as needed
                child: Lottie.asset(
                  'animations/check-circle.json',
                  repeat: true,
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
