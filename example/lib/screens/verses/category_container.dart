import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerseCategoryContainer extends StatelessWidget {
  final VerseCategory category; // Assuming you have a VerseCategory model

  VerseCategoryContainer({required this.category});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
          // Checkmark or Lock icon on the top right corner
          Align(
            alignment: Alignment.topRight,
            child: Icon(
              category.isUnlocked ? Icons.check : Icons.lock,
              color: category.isUnlocked ? Colors.green : Colors.grey,
            ),
          ),
          // Large title
          Text(
            category.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Number of verses
          Text('${category.verseCount} verses'),
          // Pill button
          ElevatedButton(
            onPressed: () {
              // Handle the button press
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
    );
  }
}

// Assuming you have a VerseCategory model like this:
class VerseCategory {
  final String title;
  final int verseCount;
  final bool isUnlocked;

  VerseCategory({
    required this.title,
    required this.verseCount,
    required this.isUnlocked,
  });
}
