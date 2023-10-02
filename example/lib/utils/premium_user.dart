import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/material.dart';
import 'package:alarm_example/screens/paywall/paywall.dart';
import '../theme/theme_constants.dart';
import 'constant.dart';

Future<bool> isPremiumUser() async {
  CustomerInfo customerInfo = await Purchases.getCustomerInfo();
  if (customerInfo.entitlements.all[entitlementID] != null &&
      customerInfo.entitlements.all[entitlementID]?.isActive == true) {
    // User has subscription, show them the feature
    return true;
  }
  return false;
}

void performMagic(context) async {
  if (await isPremiumUser()) {
    // User has subscription, show them the feature
  } else {
    Offerings? offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      // Error finding the offerings, handle the error.
    }

    if (offerings == null || offerings.current == null) {
      // offerings are empty, show a message to your user
    } else {
      // current offering is available, show paywall
      // ignore: use_build_context_synchronously
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
                    offering: offerings?.current,
                  );
                }),
          );
        },
      );
    }
  }
}