// verses_screen.dart
import 'package:flutter/material.dart';

import '../../data/verse_repository.dart';

class VersesScreen extends StatelessWidget {
  final String title;
  final List<Verse> verses;

  VersesScreen({required this.title, required this.verses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: verses.length,
        itemBuilder: (context, index) {
          final verse = verses[index];
          return ListTile(
            minVerticalPadding: 30,
            title: Text(
              verse.verse,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding( // Wrap the subtitle with Padding
              padding: const EdgeInsets.only(top: 14.0), // Add padding to the top
              child: Text(
                verse.phrase,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
