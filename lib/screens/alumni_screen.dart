import 'package:flutter/material.dart';

import '../Widgets/app_drawer.dart';

class AlumniScreen extends StatelessWidget {
  const AlumniScreen({super.key});
  static const routeName = '/fathers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alumni',
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
