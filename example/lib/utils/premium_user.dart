import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';
import 'package:alarm_example/screens/paywall/paywall.dart';
import '../theme/theme_constants.dart';
import 'constant.dart';

Future<bool> isPremiumUser() async {
  try {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    return customerInfo.entitlements.all[entitlementID]?.isActive ?? false;
  } catch (e) {
    print("Error checking premium user status: $e");
    return false;
  }
}

Future<void> performMagic(BuildContext context) async {
  if (await isPremiumUser()) {
    // User has subscription, show them the feature
    return;
  }

  try {
    Offerings? offerings = await Purchases.getOfferings();
    if (offerings?.current != null) {
      await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: kBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return PaywallScreen(
                  offering: offerings.current,
                );
              },
            ),
          );
        },
      );
    } else {
      // Handle the case where offerings are empty
      print("No offerings available.");
    }
  } catch (e) {
    print("Error fetching offerings: $e");
  }
}
