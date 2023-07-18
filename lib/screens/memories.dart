import 'package:flutter/material.dart';

import '../Widgets/app_drawer.dart';

class Memories extends StatelessWidget {
  const Memories({super.key});
  static const routeName = '/memories';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(
              "Memories",
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
