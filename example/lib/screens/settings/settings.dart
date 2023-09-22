import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alarm_example/theme/theme_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constant.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeManager _themeManager = ThemeManager();

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  // Function to open a URL in the browser
  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Theme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Dark Mode'),
                Switch(
                  value: _themeManager.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    _themeManager.toggleTheme(value);
                  },
                ),
              ],
            ),
            SizedBox(height: 20), // Add some space

            // About Section
            Text(
              'About',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Privacy Tile
            InkWell(
              onTap: () {
                _launchURL(privacy);
              },
              child: ListTile(
                title: Text('Privacy Policy'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            // Terms Tile
            InkWell(
              onTap: () {
                _launchURL(terms);
              },
              child: ListTile(
                title: Text('Terms of Service'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
