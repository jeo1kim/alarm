import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';

import '../../app_data.dart';
import '../../theme/theme_constants.dart';
import '../../utils/premium_user.dart';

class VerseCategoryScreen extends StatefulWidget {
  const VerseCategoryScreen({Key? key}) : super(key: key);

  @override
  State<VerseCategoryScreen> createState() => _VerseCategoryScreenState();
}

class _VerseCategoryScreenState extends State<VerseCategoryScreen> {
  bool loading = false;
  bool isPremium = appData.entitlementIsActive;

  final categories = {
    "God": [
      "Prayer",
      "Worship",
      "Jesus Christ",
      "Salvation",
      "Holy spirit",
      "Creation",
      "Prophecy",
      "Eternal life"
    ],
    "Growth and Virtue": [
      "Faith and belief",
      "Hope",
      "Love",
      "Forgiveness",
      "Humility",
      "Patience",
      "Gratitude",
      "Self-Control",
      "Wisdom"
    ],
    // ... add other categories here
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: kPrimaryColor),
                ),
              ),
              TextButton(
                onPressed: () => {
                  if (!appData.entitlementIsActive)
                    {performMagic(context)}
                  else
                    {}
                },
                child: appData.entitlementIsActive
                    ? Text(
                        "Premium",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: kPrimaryColor),
                      )
                    : Text(
                        "Unlock All",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: kPrimaryColor),
                      ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Bible verses",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: kPrimaryColor)),
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   child: Text("Make your own mix"),
                  // ),
                  ...categories.entries.map((category) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text(category.key,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 2, // Adjust aspect ratio here
                          ),
                          itemCount: category.value.length,
                          itemBuilder: (context, index) {
                            final item = category.value[index];
                            return Card(
                              color: Colors.white.withOpacity(0.05),
                              child: InkWell(
                                onTap: () => {
                                  if (isPremium) {performMagic(context)} else {}
                                },
                                child: GridTile(
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Center(child: Text(item)),
                                      Positioned(
                                        right: 4,
                                        top: 4,
                                        child: Icon(
                                          isPremium
                                              ? Icons.check
                                              : Icons.lock,
                                          color: isPremium
                                              ? Colors.green
                                              : Colors.black26, // Replace with your color
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
