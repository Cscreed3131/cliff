import 'package:cliff/widgets/homescreenwidget/announcements_widget.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  static const routeName = '/updates';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              //added close icon
              icon: const Icon(Icons.close),
            ),
            title: Text(
              "Announcements",
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
                // color: textColor,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  AnnouncementWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
