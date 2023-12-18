import 'package:cliff/provider/user_data_provider.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_add_food_widget.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_add_placement_data.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_announce_widget.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_events_widget.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_merch_widget.dart';
import 'package:cliff/sub_sections/Admin/widgets/admin_timetable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});
  static const routeName = '/add-event';
  @override
  ConsumerState<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen>
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
    // final font30 = screenHeight * 0.05;
    final userData = ref.watch(realTimeUserDataProvider);
    final admin = userData.value!.name;
    final adminRole = userData.value!.roles;
    print(adminRole);
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
                    admin,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'IBMPlexMono',
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  //chip specifying admin role
                  // I want to fetch user roles from my provider which i know is list of strings and then generate chips based on that.

                  Row(
                    children: [
                      for (var role in adminRole)
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Chip(
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            label: Text(
                              '${role.toString().toUpperCase()}',
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
