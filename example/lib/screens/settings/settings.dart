import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alarm_example/theme/theme_manager.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_data.dart';
import '../../utils/constant.dart';
import '../../utils/premium_user.dart';
import '../../widgets/native_dialog.dart';

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
  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  _restore() async {
    try {
      CustomerInfo purchaserInfo = await Purchases.restorePurchases();
      appData.appUserID = await Purchases.appUserID;

      // Check if the user has an active entitlement
      if (purchaserInfo.entitlements.all[entitlementID]?.isActive != true) {
        // No active entitlement found, show the dialog
        await showDialog(
          context: context,
          builder: (BuildContext context) => ShowDialogToDismiss(
            title: "Rise premium",
            content: "Subscription not found",
            buttonText: 'OK',
          ),
        );
      }
    } on PlatformException catch (e) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => ShowDialogToDismiss(
          title: "Error",
          content: e.message ?? "Unknown error",
          buttonText: 'OK',
        ),
      );
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

            // About Section
            Text(
              'About',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Privacy Tile
            InkWell(
              onTap: () {
                launchURL(privacy);
              },
              child: ListTile(
                title: Text('Privacy Policy'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            // Terms Tile
            InkWell(
              onTap: () {
                launchURL(terms);
              },
              child: ListTile(
                title: Text('Terms of Use'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            InkWell(
              onTap: () {
                _restore();
              },
              child: ListTile(
                title: Text('Restore purchase'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            InkWell(
              onTap: () {
                performMagic(context);
              },
              child: ListTile(
                title: Text('Upgrade to Premium'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
