import 'package:cliff/widgets/homescreenwidget/app_drawer.dart';
import 'package:cliff/widgets/homescreenwidget/announcements_icon_button.dart';
import 'package:cliff/widgets/homescreenwidget/classroom_widget.dart';
import 'package:cliff/widgets/homescreenwidget/home_grid_view.dart';
import 'package:cliff/widgets/homescreenwidget/image_slider.dart';
import 'package:flutter/material.dart';

import '../placements/screens/placement_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    final font30 = screenWidth * 0.07;

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
            actions: const [
              AnnouncementIconButton(),
            ],
            title: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  // margin: const EdgeInsets.only(top: 30, bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/icon/icon.png',
                      ), // should change in the future
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 10,
                // ),
                Text(
                  'Cliff',
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: font30,
                    fontWeight: FontWeight.bold,
                    // color: textColor,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: ImageSlider(),
                ),

                ClassroomWidget(),

                Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 30, right: 20, left: 20),
                  child: HomeGridView(),
                ),

                // a card for the placements screen
                Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 30),
                  child: SizedBox(
                    //height: screenHeight * 0.23,
                    width: screenWidth * 0.87,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadowColor: Colors.transparent,
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(PlacementsScreen.routeName),
                                leading: Icon(
                                  Icons.work_outline,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(
                                  'Placements',
                                  style: TextStyle(
                                      fontFamily: 'IBMPlexMono',
                                      fontSize: screenWidth * 0.05,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  '1 company this week',
                                  style: TextStyle(
                                    fontFamily: 'IBMPlexMono',
                                    fontSize: screenWidth * 0.04,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //       left: screenWidth * 0.05,
                              //       right: screenWidth * 0.05,
                              //       bottom: screenWidth * 0.05),
                              //   child: Text(
                              //     'View your scheduled classes for today and tomorrow',
                              //     style: TextStyle(
                              //       fontFamily: 'IBMPlexMono',
                              //       fontSize: screenWidth * 0.04,
                              //       color: Theme.of(context)
                              //           .colorScheme
                              //           .onPrimaryContainer,
                              //     ),
                              //   ),
                              // ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
