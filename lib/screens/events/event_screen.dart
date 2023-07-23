import 'package:cliff/widgets/eventswidget/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});
  static const routeName = '/events-screens';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final font20 = screenHeight * 0.02;

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
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const EventsWidget(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
