import 'package:flutter/material.dart';
import '../Widgets/app_drawer.dart';

class Polls extends StatelessWidget {
  const Polls({super.key});

  static const routeName = '/polls';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(
              "Polls",
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
