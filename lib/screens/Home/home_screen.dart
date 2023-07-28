import 'package:cliff/widgets/homescreenwidget/app_drawer.dart';
import 'package:cliff/widgets/homescreenwidget/home_grid_view.dart';
import 'package:cliff/widgets/homescreenwidget/image_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final font40 = screenWidth * 0.08;

    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.05,
                  backgroundImage: const AssetImage('assets/images/logo.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Cliff',
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: font40,
                    fontWeight: FontWeight.bold,
                    // color: textColor,
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: ImageSlider(),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 30, right: 20, left: 20),
                  child: HomeGridView(),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
