import 'package:cliff/screens/Admin/add_designs_screen.dart';
import 'package:cliff/screens/Admin/create_event_screens.dart';
import 'package:flutter/material.dart';

class ListItem {
  final int id;
  final String value;
  final String imgUrl;

  ListItem(this.id, this.value, this.imgUrl);
}

final List<ListItem> items = [
  ListItem(1, 'Add Event', "assets/images/events.png"),
  ListItem(2, 'Add Designs', "assets/images/merch.png"),
  // ListItem(3, 'Item 3'),
  // ListItem(4, 'Item 4'),
  // ListItem(5, 'Item 5'),
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
    final font30 = screenHeight * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Panel',
          style: TextStyle(
            fontFamily: 'IBMPlexMono'
          )
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Adjust the number of columns here
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0,
          mainAxisExtent: 200,
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
              }
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: containerBorderRadius,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.5),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline),
                      borderRadius: containerBorderRadius,
                      image: DecorationImage(
                        image: AssetImage(items[index].imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        items[index].value,
                        style: TextStyle(
                          fontSize: font30,
                          height: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              color: Colors.black,
                              blurRadius: 50,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }
}
