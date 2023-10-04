import 'package:alarm_example/screens/alarm/verse_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/verse_repository.dart';

class VerseCategoryContainer extends StatelessWidget {
  final VerseCategory category;

  VerseCategoryContainer({required this.category});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      // Wrap the Container with InkWell
      onTap: () {
        // Navigate to VerseScreen on tap
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VersesScreen(
                  title: category.title,
                  verses: category.verses,
                  isUnlocked: category.isUnlocked)),
        );
      },
      child: Container(
        width: screenWidth - 80,
        margin: EdgeInsets.only(left: 20, bottom: 40),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: category.isUnlocked ? Colors.white : Colors.grey[300],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                category.isUnlocked ? Icons.check : Icons.lock,
                color: category.isUnlocked ? Colors.green : Colors.grey,
              ),
            ),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${category.verseCount} verses'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VersesScreen(
                          title: category.title,
                          verses: category.verses,
                          isUnlocked: category.isUnlocked,)),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text('Read'),
            ),
          ],
        ),
      ),
    );
  }
}

// Assuming you have a VerseCategory model like this:
class VerseCategory {
  final String title;
  final int verseCount;
  final bool isUnlocked;
  final List<Verse> verses;

  VerseCategory(
      {required this.title,
      required this.verseCount,
      required this.isUnlocked,
      required this.verses});
}
