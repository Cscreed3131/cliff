import 'package:flutter/material.dart';

import '../Widgets/app_drawer.dart';

class BuyMerchScreen extends StatelessWidget {
  const BuyMerchScreen({super.key});
  static const routeName = '/Merch';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Merchandise',
          style: TextStyle(
            fontFamily: 'Barrbar',
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
    );
  }
}
