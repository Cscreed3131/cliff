// import 'package:cliff/global_varibales.dart';
import 'package:cliff/widgets/events_widget.dart';
import 'package:flutter/material.dart';

import '../Widgets/app_drawer.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  static const routeName = '/events-screens';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text(
              "Events",
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // color: textColor,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //event image container, this will not change (probably)
                  Container(
                      height: screenHeight * 0.2,
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/events.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      )),

                  const SizedBox(
                    height: 20,
                  ),
                  //Ongoing Events Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Ongoing Events",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),

                  const EventsWidget(
                      title: 'Vikalp', imgPath: 'assets/images/vikalp.jpg'),

                  const SizedBox(
                    height: 20,
                  ),

                  //Upcoming Events Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Upcoming Events",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),

                  const EventsWidget(
                      title: 'Vikalp', imgPath: 'assets/images/vikalp.jpg'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
