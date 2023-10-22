import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

import '../data/verse/verse_repository.dart';
import '../theme/theme_constants.dart';

class AlarmEditScreen2 extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const AlarmEditScreen2({Key? key, this.alarmSettings}) : super(key: key);

  @override
  State<AlarmEditScreen2> createState() => _AlarmEditScreenState2();
}

class _AlarmEditScreenState2 extends State<AlarmEditScreen2> {
  bool loading = false;

  late bool creating;
  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool volumeMax;
  late bool showNotification;
  late String assetAudio;

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

    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      loopAudio = true;
      vibrate = true;
      volumeMax = true;
      showNotification = true;
      assetAudio = 'assets/piano.mp3';
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
    return await PhraseRepository.getRandomVerse();
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
                'Loop alarm audio',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: loopAudio,
                onChanged: (value) => setState(() => loopAudio = value),
              ),
            ],
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
                'Show notification',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: showNotification,
                onChanged: (value) => setState(() => showNotification = value),
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
              DropdownButton(
                value: assetAudio,
                dropdownColor: kBackgroundColor,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'assets/piano.mp3',
                    child: Text('Piano'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/violin.mp3',
                    child: Text('Violin & Piano'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/clarinet.mp3',
                    child: Text('Clarinet'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/cello.mp3',
                    child: Text('Cello'),
                  ),
                ],
                onChanged: (value) => setState(() => assetAudio = value!),
              ),
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
