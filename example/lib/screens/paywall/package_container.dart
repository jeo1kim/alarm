import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import '../../theme/theme_constants.dart';

class PackageContainer extends StatelessWidget {
  final Package package;
  final bool isSelected;
  final VoidCallback onTap;

  const PackageContainer({
    Key? key,
    required this.package,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 160,
          height: 190,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? kBackgroundColor : Colors.black12.withOpacity(0.05),
            border: Border.all(
              color: isSelected ? kPrimaryColor : Colors.transparent,
              width: isSelected ? 2.0 : 1.8,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio(
                value: true,
                groupValue: isSelected,
                onChanged: (value) {
                  onTap();
                },
              ),
              Text(
                (package.storeProduct.price == 19.99) ? "Annual plan" : "Monthly plan",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                (package.storeProduct.priceString == "\$19.99")
                    ? package.storeProduct.priceString + "/year"
                    : package.storeProduct.priceString + "/month",
                style: TextStyle(
                  letterSpacing: -0.5,
                  color: Colors.red.withOpacity(0.9),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                (package.storeProduct.priceString == "\$19.99")
                    ? "Renew every year"
                    : "Renew every month",
                style: TextStyle(
                  color: Colors.black87.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        if (package.storeProduct.priceString == "\$19.99") // Only show for the annual plan
          Positioned(
            top: 0,
            child: Container(
              width: 160,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              ),
              child: Text(
                '7 days free trial',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
