import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../utils/premium_user.dart';
import '../onboarding/onboarding_sound_picker.dart';

class SoundContainer extends StatefulWidget {
  final SoundChoice soundChoice;
  final Function(SoundChoice) onSelected;
  final int index;

  SoundContainer({
    required this.soundChoice,
    required this.onSelected,
    required this.index,
  }) {
    if (index == 0) {
      soundChoice.isSelected = true;
    }
  }

  @override
  _SoundContainerState createState() => _SoundContainerState();
}

class _SoundContainerState extends State<SoundContainer> {
  late AudioPlayer _audioPlayer;
  static _SoundContainerState? currentPlayingInstance;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  void _togglePlay() async {
    if (currentPlayingInstance != this && currentPlayingInstance != null) {
      currentPlayingInstance!._audioPlayer.pause();
      currentPlayingInstance!.setState(() {
        currentPlayingInstance!.widget.soundChoice.isPlaying = false;
      });
    }

    if (widget.soundChoice.isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(AssetSource(widget.soundChoice.assetAudio));
      currentPlayingInstance = this;
    }

    setState(() {
      widget.soundChoice.isPlaying = !widget.soundChoice.isPlaying;
    });
  }

  @override
  void dispose() {
    if (currentPlayingInstance == this) {
      currentPlayingInstance = null;
    }
    _audioPlayer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (!widget.soundChoice.isUnlocked) {
          performMagic(context);
        } else {
          widget.onSelected(widget.soundChoice);
          setState(() {});
        }
      },
      child: Container(
        width: screenWidth - 200,
        margin: EdgeInsets.only(left: 20, bottom: 40),
        padding: EdgeInsets.only(right: 12.0, left: 12),
        decoration: BoxDecoration(
          color: widget.soundChoice.isUnlocked ? Colors.white : Colors.grey[300],
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: widget.soundChoice.isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              color: !widget.soundChoice.isUnlocked ? Colors.grey : Colors.white,
            ),
            Text(
              widget.soundChoice.name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _togglePlay,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.soundChoice.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
