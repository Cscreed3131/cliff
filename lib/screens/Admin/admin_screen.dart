import 'package:cliff/screens/Admin/add_class_timetable.dart';
import 'package:cliff/screens/Admin/add_designs_screen.dart';
import 'package:cliff/screens/Admin/add_food_item_screen.dart';
import 'package:cliff/screens/Admin/create_announcement.dart';
import 'package:cliff/screens/Admin/create_event_screens.dart';
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

class AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final containerBorderRadius = BorderRadius.circular(screenHeight * 0.02);
    //final font30 = screenHeight * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel',
            style: TextStyle(fontFamily: 'IBMPlexMono')),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Adjust the number of columns here
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
          mainAxisExtent: 185,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              // Handle tap event for the grid tile
              if (item.id == 1) {
                Navigator.of(context).pushNamed(CreateEventScreen.routeName);
              } else if (item.id == 2) {
                Navigator.of(context).pushNamed(AddDesignsScreen.routeName);
              } else if (item.id == 3) {
                Navigator.of(context).pushNamed(CreateAnnouncement.routeName);
              } else if (item.id == 4) {
                Navigator.of(context).pushNamed(AddFoodItems.routeName);
              } else if (item.id == 5) {
                Navigator.of(context).pushNamed(AddClassTimeTable.routeName);
              }
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: containerBorderRadius,

                  //a card showing the options for admin
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                          height: screenHeight * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(item.imgUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            item.icon,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          title: Text(
                            item.value,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'IBMPlexMono',
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
