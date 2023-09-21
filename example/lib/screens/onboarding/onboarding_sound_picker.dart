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
  final String pageText = "Choose the song you prefer";
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
  List<SoundChoice> soundChoices = [
    SoundChoice(name: "Piano", assetAudio: 'piano.mp3'),
    SoundChoice(name: "Cello", assetAudio: 'cello.mp3'),
    SoundChoice(name: "Violin", assetAudio: 'violin.mp3'),
    SoundChoice(name: "Clarinet", assetAudio: 'clarinet.mp3'),
  ];
  SoundChoice? selectedSoundChoice; // Add this variable

  final AudioPlayer audioPlayer = AudioPlayer();
  bool isSongSelected = false;

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
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4, // Adjust the flex value as needed
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 30),
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
                      color: soundChoice.isSelected ? Color(0xFFF3BB1C) : Color(0xFFFFDFA6),

                      border: Border.all(
                        color:
                            soundChoice.isSelected ? Theme.of(context).primaryColor : Color(0xFFFFDFA6),
                        width: 1.8, // Adjust the border width as needed
                      ),
                      borderRadius: BorderRadius.circular(
                          8), // Optional: Add border radius
                    ),
                    child: ListTile(
                      selected: soundChoice.isSelected,
                      tileColor: soundChoice.isSelected
                          ? Color(0xFFEAB634)
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
                          isSongSelected =
                              true; // Set isSongSelected to true when a song is selected
                        });
                      },
                      title: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        // Add vertical padding
                        child: Text(soundChoice.name,
                            style: TextStyle(
                                color: soundChoice.isSelected
                                    ? Colors.black
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
                              color: Theme.of(context).primaryColor,
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
                                    "assets/${selectedSoundChoice!.assetAudio}");
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
