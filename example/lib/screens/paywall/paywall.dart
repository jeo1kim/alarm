import 'package:alarm_example/app_data.dart';
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
          children: <Widget>[
            Container(
                height: 70.0,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: const Center(child: Text('APP NAME'))),
            const Padding(
              padding:
              EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                child: Text('PREMIUM'),
                width: double.infinity,
              ),
            ),
            ListView.builder(
              itemCount: widget.offering?.availablePackages.length,
              itemBuilder: (BuildContext context, int index) {
                var myProductList = widget.offering?.availablePackages;
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () async {
                      try {
                        CustomerInfo customerInfo =
                        await Purchases.purchasePackage(
                            myProductList![index]);
                        appData.entitlementIsActive = customerInfo
                            .entitlements.all[entitlementID]!.isActive;
                      } catch (e) {
                        print(e);
                      }

                      setState(() {});
                      Navigator.pop(context);
                    },
                    title: Text(
                      myProductList![index].storeProduct.title,
                    ),
                    subtitle: Text(
                      myProductList[index].storeProduct.description,
                    ),
                    trailing: Text(
                      myProductList[index].storeProduct.priceString,
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
            ),
            const Padding(
              padding:
              EdgeInsets.only(top: 32, bottom: 16, left: 16.0, right: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  footerText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}