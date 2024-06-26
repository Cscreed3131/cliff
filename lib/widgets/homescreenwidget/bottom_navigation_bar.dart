import 'package:cliff/sub_sections/history/history_screen.dart';
import 'package:cliff/sub_sections/orders/order_page.dart';
import 'package:flutter/material.dart';

import '../../sub_sections/Home/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

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
      const OrderPage(),
      const HistoryScreen(),
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
              Icons.receipt_long,
            ),
            label: "Orders",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history,
            ),
            label: "History",
          ),
        ],
      ),
    );
  }
}
