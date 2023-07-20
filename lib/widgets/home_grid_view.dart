import 'package:cliff/screens/alumni_screen.dart';
import 'package:cliff/screens/merch/buy_merch_screen.dart';
import 'package:cliff/screens/events/event_screen.dart';
import 'package:cliff/screens/history_screen.dart';
import 'package:cliff/screens/memories.dart';
import 'package:cliff/screens/polls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/home_grid_view_items.dart';

class HomeGridView extends ConsumerWidget {
  const HomeGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridItems = ref.watch(gridItemsProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: gridItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: MediaQuery.of(context).size.height * 0.24,
          ),
          itemBuilder: (context, index) {
            final item = gridItems[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  if (item.id == 1) {
                    Navigator.of(context).pushNamed(EventsScreen.routeName);
                  } else if (item.id == 2) {
                    Navigator.of(context).pushNamed(HistoryScreen.routeName);
                  } else if (item.id == 3) {
                    Navigator.of(context).pushNamed(BuyMerchScreen.routeName);
                  } else if (item.id == 4) {
                    Navigator.of(context).pushNamed(AlumniScreen.routeName);
                  } else if (item.id == 5) {
                    Navigator.of(context).pushNamed(Memories.routeName);
                  } else if (item.id == 6) {
                    Navigator.of(context).pushNamed(Polls.routeName);
                  }
                },
                child: GridTile(
                    footer: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(item.title,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 2.5,
                            fontSize: screenWidth * 0.045,
                            fontFamily: 'IBMPlexMono',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.4),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              child: IconButton.filledTonal(
                            onPressed: null,
                            icon: Icon(
                              item.icon,
                              size: screenHeight * 0.06,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )),
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
