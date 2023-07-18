// import 'package:cliff/global_varibales.dart';
import 'package:cliff/widgets/app_drawer.dart';
import 'package:cliff/widgets/home_grid_view.dart';
import 'package:cliff/widgets/image_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // bool _isDrawerOpen = false;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        drawer: const AppDrawer(),
        body: Builder(
          builder: (context) {
            return Transform.scale(
              scale: 0.9,
              alignment: Alignment.centerRight,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    leading: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(Icons.logout),
                      ),
                      SizedBox(
                        width: screenWidth * 0.1,
                      ),
                    ],
                    title: const Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/logo.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Cliff',
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 40,
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
                          padding: EdgeInsets.only(
                              top: 20, bottom: 30, right: 20, left: 20),
                          child: HomeGridView(),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            );
          },
        ));
  }
}
