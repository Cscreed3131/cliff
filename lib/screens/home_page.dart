import 'package:flutter/material.dart';

import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex=0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const Center(child: Text("Registered Events"),),
    ];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens()[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            _selectedIndex=index;
          });
        },
        labelBehavior: labelBehavior,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined,),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.today_outlined,),
            label: "Registered",
          ),
        ],
      ),
    );
  }
}
