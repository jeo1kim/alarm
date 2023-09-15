import 'package:flutter/material.dart';

class SoundChoice {
  final String name;
  bool isSelected;
  bool isPlaying;

  SoundChoice(
      {required this.name, this.isSelected = false, this.isPlaying = false});
}

class OnBoardingSoundPickPage extends StatefulWidget {
  final String pageText = "Choose the song you prefer";
  final VoidCallback onNext;

  const OnBoardingSoundPickPage({super.key, required this.onNext});

  @override
  _OnBoardingSoundPickPageState createState() =>
      _OnBoardingSoundPickPageState();
}

class _OnBoardingSoundPickPageState extends State<OnBoardingSoundPickPage> {
  List<SoundChoice> soundChoices = [
    SoundChoice(name: "Piano"),
    SoundChoice(name: "Cello"),
    SoundChoice(name: "Violin"),
    SoundChoice(name: "Quartet"),
  ];

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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.pageText,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
        Expanded(
          flex: 2, // Adjust the flex value as needed
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 40),
            // Add left and right padding
            itemCount: soundChoices.length,
            itemBuilder: (context, index) {
              final soundChoice = soundChoices[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                // Add vertical spacing
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: soundChoice.isSelected
                          ? Colors.blue
                          : Colors.white,
                      width: 1.8, // Adjust the border width as needed
                    ),
                    borderRadius:
                        BorderRadius.circular(8), // Optional: Add border radius
                  ),
                  child: ListTile(
                    selected: soundChoice.isSelected,
                    tileColor: soundChoice.isSelected
                        ? Colors.lightBlue
                        : Colors.black12,
                    onTap: () {
                      setState(() {
                        for (var choice in soundChoices) {
                          choice.isSelected = choice == soundChoice;
                        }
                      });
                    },
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      // Add vertical padding
                      child: Text(
                          soundChoice.name,
                          style: TextStyle(
                              color: soundChoice.isSelected ? Colors.blue : Colors.black,
                              fontSize: 20)),
                    ),
                    trailing: Visibility(
                      visible: soundChoice.isSelected,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            soundChoice.isPlaying = !soundChoice.isPlaying;
                          });
                          // Handle playing or stopping the sound here
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            soundChoice.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 0,
              ); // Add separators between list items
            },
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 100),
            child: SizedBox(
              height: 50,
              width: 320,
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
