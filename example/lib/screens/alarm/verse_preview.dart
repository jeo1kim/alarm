// verses_screen.dart
import 'package:flutter/material.dart';

class VersesScreen extends StatelessWidget {
  final String title;
  final List<Map<String, String>> verses;

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
            title: Text(verse['text']!),
            subtitle: Text(verse['verse']!),
          );
        },
      ),
    );
  }
}
