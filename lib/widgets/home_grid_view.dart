import 'package:cliff/screens/alumni_screen.dart';
import 'package:cliff/screens/buy_merch_screen.dart';
import 'package:cliff/screens/event_screen.dart';
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
    final gridItems = ref.read(gridItemsProvider);

    return GridView.builder(
      shrinkWrap: true,
      itemCount: gridItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 150,
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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: item.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
