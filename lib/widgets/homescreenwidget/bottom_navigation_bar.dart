import 'package:cliff/screens/Home/registered_events_screen.dart';
import 'package:cliff/screens/history/history_screen.dart';
import 'package:flutter/material.dart';

import '../../screens/Home/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const HistoryScreen(),
      const RegisteredEventsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens()[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        labelBehavior: labelBehavior,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history,
            ),
            label: "History",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.today_outlined,
            ),
            label: "Registered",
          ),
        ],
      ),
    );
  }
}
