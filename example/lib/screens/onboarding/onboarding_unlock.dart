import 'package:flutter/material.dart';
import 'package:alarm_example/data/verse_repository.dart';

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
  late String correctPhrase;
  int currentIndex = 0;

  // Create a focus node for the hidden TextField
  final FocusNode _hiddenTextFieldFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    verse = PhraseRepository.getRandomFreeVerse();
    verseTitle = "Psalm 119:147";
    correctPhrase = "I rise before dawn and cry for help. I wait for your words.";

    // Add a post-frame callback to show the keyboard after the screen is built
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_hiddenTextFieldFocus);
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 320,
                        child: ElevatedButton(
                          onPressed: isStopButtonEnabled
                              ? widget.onNext
                              : null, // Disable the button when not enabled
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
