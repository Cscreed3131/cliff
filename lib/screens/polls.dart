import 'package:flutter/material.dart';
import '../Widgets/app_drawer.dart';

class Polls extends StatelessWidget {
  const Polls({super.key});

  static const routeName = '/polls';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Polls',
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
