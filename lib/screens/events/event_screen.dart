// import 'package:cliff/provider/user_data_provider.dart';
// import 'package:cliff/provider/event_details_provider.dart';
import 'package:cliff/screens/Events/registered_events_screen.dart';
import 'package:cliff/widgets/eventswidget/event_widget.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  static const routeName = '/events-screens';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
            actions: [
              // this will be a icon button. which has a batch in the top to show
              //the number of events the user is currentlt registered in.
              // basically this should change into widget which will be made today.
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RegisteredEventsScreen.routeName);
                },
                icon: const Icon(Icons.event),
              ),
            ],
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
                      color: Theme.of(context).colorScheme.secondaryContainer,
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
