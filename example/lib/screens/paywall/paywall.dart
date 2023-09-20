import 'package:alarm_example/app_data.dart';
import 'package:alarm_example/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../theme/theme_constants.dart';


class PaywallScreen extends StatefulWidget {
  final Offering? offering;

  const PaywallScreen({Key? key, @required this.offering}) : super(key: key);

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20), // Add spacing at the top
            Text(
              'Start your free trial',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Get unlimited features today!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20), // Add spacing
            // Image.asset(
            //   'assets/reward_image.png', // Replace with your image path
            //   width: 150,
            //   height: 150,
            // ),
            SizedBox(height: 20), // Add spacing
            Text('Multiple alarms', style: TextStyle(fontSize: 18)),
            Text('Premium sounds', style: TextStyle(fontSize: 18)),
            Text('10 vs 50+ bible verses', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20), // Add spacing
            Text('Try free and subscribe', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10), // Add spacing
            Text('No charge until', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20), // Add spacing
            Container(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: widget.offering?.availablePackages
                    .map(
                      (package) => GestureDetector(
                    onTap: () {
                      // Handle package selection
                      // You can update the selected package here
                    },
                    child: Container(
                      width: 150, // Set a fixed width for each product item
                      height: 180, // Set a fixed height to accommodate content
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // Border color
                          width: 2.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            package.storeProduct.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2, // Set the maximum number of lines
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8), // Add spacing
                          Text(
                            package.storeProduct.priceString,
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    .toList() ??
                    [], // Create a list of package selection widgets
              ),
            ),

            SizedBox(height: 20), // Add spacing
            ElevatedButton(
              onPressed: () {
                // Handle subscription when the "Start Free Trial" button is clicked
              },
              child: Text('Start Free Trial'),
            ),

            SizedBox(height: 40), // Add spacing
            Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Text(footerText),
              ),
            ),
            SizedBox(height: 20), // Add spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Privacy'),
                SizedBox(width: 16),
                Text('Terms'),
              ],
            ),
            SizedBox(height: 30), // Add spacing
          ],
        ),
      ),
    );
  }
}
