// import 'package:cliff/screens/Admin/add_class_timetable.dart';
// import 'package:cliff/screens/Admin/add_designs_screen.dart';
// import 'package:cliff/screens/Admin/add_food_item_screen.dart';
// import 'package:cliff/screens/Admin/create_announcement.dart';
// import 'package:cliff/screens/Admin/create_event_screens.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_add_food_widget.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_add_placement_data.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_announce_widget.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_events_widget.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_merch_widget.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_timetable_widget.dart';
import 'package:flutter/material.dart';

class ListItem {
  final int id;
  final String value;
  final String imgUrl;
  final IconData icon;

  ListItem(this.id, this.value, this.imgUrl, this.icon);
}

final List<ListItem> items = [
  ListItem(1, 'Add Event', "assets/images/events.png", Icons.event),
  ListItem(2, 'Add Designs', "assets/images/merch.png", Icons.design_services),
  ListItem(3, 'Announcements', "assets/images/events.png", Icons.announcement),
  ListItem(4, 'Add Food Item', "assets/images/merch.png", Icons.food_bank),
  ListItem(5, 'Add Timetable', "assets/images/empty.png", Icons.timelapse),
];

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  static const routeName = '/add-event';
  @override
  State<AdminScreen> createState() => AdminScreenState();
}

class AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final containerBorderRadius = BorderRadius.circular(screenHeight * 0.02);
    //final font30 = screenHeight * 0.05;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Admin Panel',
                style: TextStyle(fontFamily: 'IBMPlexMono')),
            actions: [
              //drop down menu with help and faq option
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.help),
                      title: Text('Help'),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.question_answer),
                      title: Text('FAQ'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Saronik Sarkar',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'IBMPlexMono',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  //chip saying club lead
                  Row(
                    children: [
                      Chip(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        label: Text(
                          'Club Lead',
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.7),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),

                  //tabview
                  DefaultTabController(
                    length: 6,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      tabs: [
                        Tab(
                          text: 'Events',
                        ),
                        Tab(
                          text: 'Merch',
                        ),
                        Tab(
                          text: 'Announcements',
                        ),
                        Tab(
                          text: 'Food',
                        ),
                        Tab(
                          text: 'Timetable',
                        ),
                        Tab(
                          text: 'Placements',
                        ),
                      ],
                    ),
                  ),

                  //tabview content
                  SizedBox(
                    height: screenHeight * 0.8,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        AdminEventsWidget(),
                        AdminMerchWidget(),
                        AdminAnnounceWidget(),
                        AdminAddFoodWidget(),
                        AdminTimetableWidget(),
                        AdminAddPlacementsData(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
