import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundChoice {
  final String name;
  bool isSelected;
  bool isPlaying;
  final String assetAudio;

  SoundChoice(
      {required this.name,
        required this.assetAudio,
        this.isSelected = false,
        this.isPlaying = false});
}

class OnBoardingSoundPickPage extends StatefulWidget {
  final String pageText = "The benefits of affirmations are endless";
  final VoidCallback onNext;
  final AlarmSettings alarmSettings;
  final Function(AlarmSettings) updateAlarmSettings; // Add this callback

  const OnBoardingSoundPickPage(
      {super.key,
        required this.alarmSettings,
        required this.updateAlarmSettings, // Add this line
        required this.onNext});

  @override
  _OnBoardingSoundPickPageState createState() =>
      _OnBoardingSoundPickPageState();
}

class _OnBoardingSoundPickPageState extends State<OnBoardingSoundPickPage> {
  SoundChoice soundChoice = SoundChoice(name: "Positive affirmation", assetAudio: 'male-confidence.mp3');

  final AudioPlayer audioPlayer = AudioPlayer();
  bool isSongSelected = true;

  // Add a method to play audio
  Future<void> _playAudio(String assetAudio) async {
    await audioPlayer.stop(); // Stop any currently playing audio
    await audioPlayer.play(AssetSource(assetAudio));
  }

  @override
  void initState() {
    super.initState();

    // Add a post-frame callback to show the keyboard after the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose(); // Dispose of the audio player when done
    super.dispose();
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
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.pageText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Focus on achieving your goals.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Shift negative thoughts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Improve mental health",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    soundChoice.isPlaying = !soundChoice.isPlaying;
                  });
                  if (soundChoice.isPlaying) {
                    _playAudio("assets/${soundChoice.assetAudio}");
                    isSongSelected = true;
                  } else {
                    audioPlayer.stop();
                  }
                },
                child: Text(soundChoice.isPlaying ? "Listen" : "Listen"),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 100),
            child: SizedBox(
              height: 50,
              width: 320,
              child: ElevatedButton(
                onPressed: isSongSelected
                    ? () {
                  final updatedAlarmSettings = widget.alarmSettings
                      ?.copyWith(
                      assetAudioPath:
                      "assets/${soundChoice.assetAudio}");
                  widget.updateAlarmSettings(updatedAlarmSettings!);
                  widget.onNext();
                }
                    : null, // Disable the button when no song is selected
                style: ElevatedButton.styleFrom(
                  primary: isSongSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey, // Set button color
                ),
                child: const Text(
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
