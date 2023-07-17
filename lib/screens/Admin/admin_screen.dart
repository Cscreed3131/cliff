import 'package:cliff/screens/Admin/create_event_screens.dart';
import 'package:flutter/material.dart';

class ListItem {
  final int id;
  final String value;

  ListItem(this.id, this.value);
}

final List<ListItem> items = [
  ListItem(1, 'Add Event'),
  // ListItem(2, 'Item 2'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Events',
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
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GridTile(
                  child: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        item.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
