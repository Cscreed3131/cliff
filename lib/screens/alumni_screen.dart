import 'package:flutter/material.dart';

import '../Widgets/app_drawer.dart';

class AlumniScreen extends StatelessWidget {
  const AlumniScreen({super.key});
  static const routeName = '/fathers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(
              "Alumni",
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
