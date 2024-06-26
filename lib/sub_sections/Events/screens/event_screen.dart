import 'dart:ui';

import 'package:cliff/sub_sections/Events/widgets/event_schedule_icon_button.dart';
import 'package:cliff/sub_sections/Events/widgets/event_widget.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  static const routeName = '/events-screens';
  @override
  Widget build(BuildContext context) {
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
            // title: const Text(
            //   "Events",
            //   style: TextStyle(
            //     fontFamily: 'IBMPlexMono',
            //     fontSize: 30,
            //     fontWeight: FontWeight.bold,
            //     // color: textColor,
            //   ),
            // ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Events",
                style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface
                    // color: textColor,
                    ),
              ),
              expandedTitleScale: 1.2,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/events.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.5),
                            Theme.of(context).colorScheme.surface,
                          ],
                          stops: const [0.0, 1.4],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
            actions: const [
              EventScheduleIconButton(),
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //event image container, this will not change (probably)
                  // Container(
                  //   height: screenHeight * 0.2,
                  //   width: double.infinity,
                  //   margin: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Theme.of(context).colorScheme.outline,
                  //     ),
                  //     color: Theme.of(context).colorScheme.secondaryContainer,
                  //     borderRadius: BorderRadius.circular(20),
                  //     image: const DecorationImage(
                  //       image: AssetImage('assets/images/events.png'),
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //   ),
                  // ),

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
