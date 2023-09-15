import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundChoice {
  final String name;
  bool isSelected;
  bool isPlaying;
  final String assetAudio;

  SoundChoice({
    required this.name,
    required this.assetAudio,
    this.isSelected = false,
    this.isPlaying = false
  });
}

class OnBoardingSoundPickPage extends StatefulWidget {
  final String pageText = "Choose the song you prefer";
  final VoidCallback onNext;
  final AlarmSettings? alarmSettings;
  final Function(AlarmSettings?) updateAlarmSettings; // Add this callback

  const OnBoardingSoundPickPage({
    super.key, this.alarmSettings,
    required this.updateAlarmSettings, // Add this line
    required this.onNext
  });

  @override
  _OnBoardingSoundPickPageState createState() =>
      _OnBoardingSoundPickPageState();
}

class _OnBoardingSoundPickPageState extends State<OnBoardingSoundPickPage> {
  List<SoundChoice> soundChoices = [
    SoundChoice(name: "Piano", assetAudio: 'piano.mp3'),
    SoundChoice(name: "Cello", assetAudio: 'cello.mp3'),
    SoundChoice(name: "Violin", assetAudio: 'violin.mp3'),
    SoundChoice(name: "Quartet", assetAudio: 'quartet.mp3'),
  ];
  SoundChoice? selectedSoundChoice; // Add this variable

  final AudioPlayer audioPlayer = AudioPlayer();

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
              SizedBox(height: 10),
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
              return GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  // Add vertical spacing
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            soundChoice.isSelected ? Colors.blue : Colors.white,
                        width: 1.8, // Adjust the border width as needed
                      ),
                      borderRadius: BorderRadius.circular(
                          8), // Optional: Add border radius
                    ),
                    child: ListTile(
                      selected: soundChoice.isSelected,
                      tileColor: soundChoice.isSelected
                          ? Colors.lightBlue
                          : Colors.black12,
                      onTap: () {
                        setState(() {
                          selectedSoundChoice = soundChoice;
                          for (var choice in soundChoices) {
                            choice.isSelected = choice == soundChoice;
                            choice.isPlaying =
                                false; // Set isPlaying to false for all choices
                          }
                          audioPlayer.stop();
                        });
                      },
                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        // Add vertical padding
                        child: Text(soundChoice.name,
                            style: TextStyle(
                                color: soundChoice.isSelected
                                    ? Colors.blue
                                    : Colors.black45,
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
                            if (soundChoice.isPlaying) {
                              _playAudio(soundChoice.assetAudio);
                            } else {
                              audioPlayer.stop();
                            }
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
                onPressed: () {
                  final updatedAlarmSettings = widget.alarmSettings?.copyWith(
                      assetAudioPath:
                          "assets/${selectedSoundChoice!.assetAudio}");
                  widget.updateAlarmSettings(updatedAlarmSettings);
                  widget.onNext();
                },
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
