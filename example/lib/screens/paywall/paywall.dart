import 'package:alarm_example/screens/paywall/package_container.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../app_data.dart';
import '../../theme/theme_constants.dart';
import '../../utils/constant.dart';

class PaywallScreen extends StatefulWidget {
  final Offering? offering;

  const PaywallScreen({Key? key, @required this.offering}) : super(key: key);

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  int selectedPackageIndex = 0;
  String buttonText = 'Start Free Trial';
  String ctaText = '7 days free, then';
  String headerText = 'Start Your Free Trial';
  String subtitle1 = 'Try free and subscribe';
  String subtitle2 = 'No charge until';

  @override
  void initState() {
    super.initState();
    updateButtonText();
  }

  void updateButtonText() {
    final selectedPackage =
        widget.offering!.availablePackages[selectedPackageIndex];
    buttonText = (selectedPackage.storeProduct.priceString == "\$19.99")
        ? 'Start Free Trial'
        : 'Start Premium';
    ctaText = (selectedPackage.storeProduct.priceString == "\$19.99")
        ? '7 days free, then ${selectedPackage.storeProduct.priceString} /year'
        : '${selectedPackage.storeProduct.priceString}/month';
    headerText = (selectedPackage.storeProduct.priceString == "\$19.99")
        ? 'Start Your Free Trial'
        : 'Unlock Premium';
    subtitle1 = (selectedPackage.storeProduct.priceString == "\$19.99")
        ? 'Try free and subscribe'
        : 'Subscribe now';
    subtitle2 = (selectedPackage.storeProduct.priceString == "\$19.99")
        ? 'No charge until your 7 day free trial ends. Cancel anytime.'
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 120),
                  Center(
                    child: Text(
                      headerText,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Get unlimited features today!',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black87.withOpacity(0.7)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Column(
                      children: [
                        CheckRow(text: 'Multiple alarms'),
                        CheckRow(text: 'Premium songs'),
                        CheckRow(text: '100+ Bible verses'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      subtitle1,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        subtitle2,
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: List.generate(
                      widget.offering?.availablePackages.length ?? 0,
                      (index) {
                        final package =
                            widget.offering!.availablePackages[index];
                        final isSelected = selectedPackageIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPackageIndex = index;
                              updateButtonText();
                            });
                          },
                          child: PackageContainer(
                            package: package,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                selectedPackageIndex = index;
                                updateButtonText();
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, bottom: 8),
                      child: Text(
                        footerText,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Privacy',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Terms',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 50,
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final customerInfo = await Purchases.purchasePackage(
                            widget.offering!
                                .availablePackages[selectedPackageIndex],
                          );
                          final entitlement =
                              customerInfo.entitlements.all[entitlementID];
                          appData.entitlementIsActive =
                              entitlement?.isActive ?? false;
                          // Handle the purchase and entitlement activation here.
                        } catch (e) {
                          print("error while subscribing "+e.toString());
                          // show error message
                        }
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Text(buttonText, style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 15),
                  child: Text(
                    ctaText,
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, right: 10),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CheckRow extends StatelessWidget {
  final String text;

  const CheckRow({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: kPrimaryColor,
        ),
        SizedBox(width: 5),
        Text(text, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
