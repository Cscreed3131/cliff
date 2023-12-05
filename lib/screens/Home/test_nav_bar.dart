import 'package:cliff/screens/Home/test_home_screen.dart';
import 'package:cliff/screens/orders/order_page.dart';
import 'package:flutter/material.dart';

import '../alumni/alumni_screen.dart';

class TestNavBar extends StatefulWidget {
  const TestNavBar({super.key});

  static const routeName = '/test-nav-bar';

  @override
  State<TestNavBar> createState() => _TestNavBarState();
}

class _TestNavBarState extends State<TestNavBar> {

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
      const TestHomeScreen(),
      const AlumniScreen(),
      const Center(child: Text('Forums')),
      const OrderPage()
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
          //connect
          NavigationDestination(
            icon: Icon(
              Icons.connect_without_contact,
            ),
            label: "Connect",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.comment_bank_outlined,
            ),
            label: "Forum",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history,
            ),
            label: "Orders",
          ),
        ],
      ),
    );
  }
}
