import 'package:flutter/material.dart';

import '../Widgets/app_drawer.dart';

class Memories extends StatelessWidget {
  const Memories({super.key});
  static const routeName = '/memories';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Memories',
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
