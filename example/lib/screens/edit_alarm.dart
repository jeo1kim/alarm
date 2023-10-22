import 'package:alarm/alarm.dart';
import 'package:alarm_example/screens/sounds/sound_container.dart';
import 'package:flutter/material.dart';

import '../data/verse/verse_repository.dart';
import '../theme/theme_constants.dart';
import '../utils/premium_user.dart';
import 'onboarding/onboarding_sound_picker.dart';

class AlarmEditScreen extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const AlarmEditScreen({Key? key, this.alarmSettings}) : super(key: key);

  @override
  State<AlarmEditScreen> createState() => _AlarmEditScreenState();
}

class _AlarmEditScreenState extends State<AlarmEditScreen> {
  bool loading = false;

  late bool creating;
  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool volumeMax;
  late bool showNotification;
  late String assetAudio;

  bool isPremium = false;
  List<SoundChoice> soundChoices = [];

  bool isToday() {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );

    return now.isBefore(dateTime);
  }

  @override
  void initState() {
    super.initState();
    creating = widget.alarmSettings == null;

    updatePremium();

    soundChoices = [
      SoundChoice(name: "Good morning", assetAudio: 'female-affirmation-1.mp3', isUnlocked: true, isSelected: true),
      SoundChoice(name: "Wealth", assetAudio: 'male-goals.mp3', isUnlocked: isPremium),
      SoundChoice(name: "Health", assetAudio: 'female-health.mp3', isUnlocked: isPremium),
      SoundChoice(name: "Relationship", assetAudio: 'female-relationship.mp3', isUnlocked: isPremium),
    ];

    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      loopAudio = true;
      vibrate = true;
      volumeMax = true;
      showNotification = true;
      assetAudio = 'assets/female-affirmation-1.mp3';
    } else {
      selectedTime = TimeOfDay(
        hour: widget.alarmSettings!.dateTime.hour,
        minute: widget.alarmSettings!.dateTime.minute,
      );
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      volumeMax = widget.alarmSettings!.volumeMax;
      showNotification = widget.alarmSettings!.notificationTitle != null &&
          widget.alarmSettings!.notificationTitle!.isNotEmpty &&
          widget.alarmSettings!.notificationBody != null &&
          widget.alarmSettings!.notificationBody!.isNotEmpty;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
  }

  getVerse() async {
    return PhraseRepository.getRandomAffirmation();
  }

  Future<void> updatePremium() async {
    isPremium = await isPremiumUser();
    setState(() {});
  }

  Future<void> pickTime() async {
    final res = await showTimePicker(
      initialTime: selectedTime,
      context: context,
    );
    if (res != null) setState(() => selectedTime = res);
  }

  Future<AlarmSettings> buildAlarmSettings() async {
    final now = DateTime.now();
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 100000
        : widget.alarmSettings!.id;

    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final verse = await getVerse();

    final alarmSettings = AlarmSettings(
        id: id,
        dateTime: dateTime,
        loopAudio: loopAudio,
        vibrate: vibrate,
        volumeMax: volumeMax,
        notificationTitle: showNotification ? verse.verse : null,
        notificationBody: showNotification ? verse.phrase : null,
        assetAudioPath: assetAudio,
        stopOnNotificationOpen: false,
        verse: verse.verse,
        verseText: verse.phrase);
    return alarmSettings;
  }

  void saveAlarm() async {
    setState(() => loading = true);
    AlarmSettings alarmSettings = await buildAlarmSettings();
    bool res = await Alarm.set(alarmSettings: alarmSettings);
    if (res) Navigator.pop(context, true);
    setState(() => loading = false);
  }

  void deleteAlarm() {
    Alarm.stop(widget.alarmSettings!.id).then((res) {
      if (res) Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: kPrimaryColor),
                ),
              ),
              TextButton(
                onPressed: saveAlarm,
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(
                        "Save",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: kPrimaryColor),
                      ),
              ),
            ],
          ),
          Text(
            '${isToday() ? 'Today' : 'Tomorrow'} at',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black45.withOpacity(0.8)),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: kPrimaryColor, // Define the border color here
                width: 2.0, // Define the border width here
              ),
            ),
            child: RawMaterialButton(
              onPressed: pickTime,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  selectedTime.format(context),
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: kPrimaryColor),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vibrate',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: vibrate,
                onChanged: (value) => setState(() => vibrate = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'System volume max',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: volumeMax,
                onChanged: (value) => setState(() => volumeMax = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sound',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 200,
                width: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: soundChoices.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        right: index == soundChoices.length - 1 ? 20 : 0,
                      ),
                      child: SoundContainer(
                        index: index,
                        isSelected: soundChoices[index].isSelected,
                        soundChoice: soundChoices[index],
                        onSelected: (choice) {
                          print("Selected sound: ${choice.name}");
                          setState(() {
                            for (var sound in soundChoices) {
                              sound.isSelected = sound == choice;
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          if (!creating)
            TextButton(
              onPressed: deleteAlarm,
              child: Text(
                'Delete Alarm',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.red),
              ),
            ),
          const SizedBox(),
        ],
      ),
    );
  }
}
