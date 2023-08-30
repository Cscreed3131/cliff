import 'package:cliff/screens/alumni/alumni_screen.dart';
import 'package:cliff/screens/Merch/buy_merch_screen.dart';
import 'package:cliff/screens/Events/event_screen.dart';
import 'package:cliff/screens/food/food_screen.dart';
// import 'package:cliff/screens/memories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/home_grid_view_items.dart';

class HomeGridView extends ConsumerStatefulWidget {
  const HomeGridView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeGridViewState();
}

class _HomeGridViewState extends ConsumerState<HomeGridView> {
  @override
  Widget build(BuildContext context) {
    final gridItems = ref.watch(gridItemsProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5,
                mainAxisExtent: screenHeight * 0.24),
            itemCount: gridItems.length,
            itemBuilder: (builder, i) {
              return SizedBox(
                height: screenHeight * 0.23,
                width: screenWidth * 0.4,
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
                  child: InkWell(
                    radius: 15,
                    onTap: () {
                      if (gridItems[i].id == 1) {
                        Navigator.of(context).pushNamed(EventsScreen.routeName);
                      } else if (gridItems[i].id == 2) {
                        Navigator.of(context).pushNamed(FoodScreen.routeName);
                      } else if (gridItems[i].id == 3) {
                        Navigator.of(context)
                            .pushNamed(BuyMerchScreen.routeName);
                      } else if (gridItems[i].id == 4) {
                        Navigator.of(context).pushNamed(AlumniScreen.routeName);
                      }
                      // else if (gridItems[i].id == 5) {
                      //   Navigator.of(context).pushNamed(Memories.routeName);
                      // }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              gridItems[i].icon,
                              color: Theme.of(context).colorScheme.primary,
                              size: screenWidth * 0.13,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                gridItems[i].title,
                                style: TextStyle(
                                    height: 2.5,
                                    fontFamily: 'IBMPlexMono',
                                    fontSize: screenWidth * 0.05,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
