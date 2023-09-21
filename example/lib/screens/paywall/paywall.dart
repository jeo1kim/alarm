import 'package:alarm_example/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaywallScreen extends StatefulWidget {
  final Offering? offering;

  const PaywallScreen({Key? key, @required this.offering}) : super(key: key);

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int selectedPackageIndex = -1; // Initially, no package is selected.

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 80),
                // Add spacing at the top
                Center(
                  child: Text(
                    'Start your free trial',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Get unlimited features today!',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                // Add spacing
                Padding(
                  padding: EdgeInsets.only(left: 80),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text('Multiple alarms',
                                style: TextStyle(fontSize: 18)),
                          ]),
                      SizedBox(height: 5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text('Premium songs',
                                style: TextStyle(fontSize: 18)),
                          ]),
                      SizedBox(height: 5),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            SizedBox(width: 5),
                            Text('10 vs 100 Bible verse',
                                style: TextStyle(fontSize: 18)),
                          ]),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Add spacing
                Center(
                  child: Text(
                    'Try free and subscribe',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                // Add spacing
                Center(
                  child: Text(
                    'No charge until',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                // Add spacing
                Container(
                  child:
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(
                      widget.offering?.availablePackages.length ?? 0,
                          (index) {
                        final package = widget.offering!.availablePackages[index];
                        final isSelected = selectedPackageIndex == index;

                        return GestureDetector(
                          onTap: () {
                            // Update the selected package index.
                            setState(() {
                              selectedPackageIndex = index;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 180,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border.all(
                                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                                width: isSelected ? 2.0 : 1.8,
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
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  package.storeProduct.priceString,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Add spacing
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 8),
                    child: Text(
                      footerText,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                // Add spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Privacy',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Terms',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Add spacing
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 50,
                  width: 320,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedPackageIndex >= 0) {
                        try {
                          CustomerInfo customerInfo = await Purchases.purchasePackage(
                            widget.offering!.availablePackages[selectedPackageIndex],
                          );
                          // Handle the purchase and entitlement activation here.
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text('Start Free Trial',
                        style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25, top: 15),
                child: Text(
                  "7 days free, then 19.99/year",
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ],
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 30, right: 10),
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    ]);
  }
}
