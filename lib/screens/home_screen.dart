import 'package:cliff/global_varibales.dart';
import 'package:cliff/widgets/app_drawer.dart';
import 'package:cliff/widgets/home_grid_view.dart';
import 'package:cliff/widgets/image_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cliff',
          style: TextStyle(
            fontFamily: 'MoonbrightDemo', fontSize: 40,
            // color: textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: pageGradient,
        ),
        height: double.infinity,
        width: double.infinity,
        child: const SingleChildScrollView(
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
        ),
      ),
    );
  }
}
