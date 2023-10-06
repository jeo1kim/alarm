import 'dart:ui';
import 'package:flutter/material.dart';
import '../../data/verse_repository.dart';
import '../../utils/premium_user.dart';

class VersesScreen extends StatelessWidget {
  final String title;
  final List<Verse> verses;
  final bool isUnlocked;

  const VersesScreen({
    Key? key,
    required this.title,
    required this.verses,
    required this.isUnlocked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: [
          _buildVerseList(),
          if (!isUnlocked) ..._buildLockedOverlay(context),
        ],
      ),
    );
  }

  Widget _buildVerseList() {
    return ListView.builder(
      itemCount: isUnlocked ? verses.length : 3,
      itemBuilder: (context, index) {
        final verse = verses[index];
        return ListTile(
          minVerticalPadding: 30,
          title: Text(
            verse.verse,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text(
              verse.phrase,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildLockedOverlay(BuildContext context) {
    return [
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 3),
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.grey.withOpacity(0.1),
                  ],
                  stops: const [0.0, 0.5],
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 100,
        left: 0,
        right: 0,
        child: Center(
          child: SizedBox(
            height: 50,
            width: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () => performMagic(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                ),
                child: Text(
                  "Get all packs!",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }
}
