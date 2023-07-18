import 'package:flutter/material.dart';

import '../Widgets/app_drawer.dart';

class BuyMerchScreen extends StatelessWidget {
  const BuyMerchScreen({super.key});
  static const routeName = '/Merch';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(
              "Merch",
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // color: textColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
