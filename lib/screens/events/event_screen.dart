import 'package:cliff/provider/event_details_provider.dart';
import 'package:cliff/widgets/up_coming_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});
  static const routeName = '/events-screens';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;

    final events = ref.watch(eventDataProvider);
    void check() {
      print(events);
    }

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

                  //Ongoing Events Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Ongoing Events",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: font20,
                        fontWeight: FontWeight.bold,
                        // color: textColor,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // const UpComingEvents(),

                  const SizedBox(
                    height: 30,
                  ),

                  //Upcoming Events Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Upcoming Events",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: font20,
                        fontWeight: FontWeight.bold,
                        // color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const EventsWidget(
                  //   title: 'something',
                  //   imgPath: 'assets/images/vikalp.jpg',
                  //   isOngoing: false,
                  //   itemCount: 3,
                  // ),
                  const UpComingEvents(),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
