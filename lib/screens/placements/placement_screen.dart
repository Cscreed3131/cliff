import 'dart:ui';

import 'package:cliff/screens/placements/placements_current.dart';
import 'package:cliff/screens/placements/upcoming_placements.dart';
import 'package:flutter/material.dart';


class PlacementsScreen extends StatelessWidget {
  static const routeName = '/placements';
  const PlacementsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            // title: const Text('Placements', style: TextStyle(fontFamily: 'IBMPlexMono')),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Placements",
                style: TextStyle(
                  fontFamily: 'IBMPlexMono',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              expandedTitleScale: 1.2,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/company_image.png'),
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
                            Theme.of(context).colorScheme.surface.withOpacity(0.5),
                            Theme.of(context).colorScheme.surface.withOpacity(0.6),
                            Theme.of(context).colorScheme.surface,
                          ],
                          stops: const [0.0, 0.5 ,1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal : 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Image container
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
                  //       image: AssetImage('assets/images/image2.png'),
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //   ),
                  // ),

                  //Text : Placement Event today
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Placement Event Today',
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //A card with an image and text like in events page
                  CurrentPlacements(),

                  const SizedBox(
                    height: 20,
                  ),

                  const Divider(
                    indent: 10,
                    endIndent: 10,
                  ),

                  //Text : Upcoming Placements
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Upcoming Placements',
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  UpcomingPlacements(),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/placements-trainer');
        },
        label: const Text("Trainer"),
        icon: const Icon(Icons.stars_outlined),
      )
    );
  }
}
