import 'dart:ui';

import 'package:cliff/provider/food_provider.dart';
import 'package:cliff/sub_sections/food/widgets/food_card.dart';
import 'package:cliff/widgets/foodwidget/plate_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodScreen extends ConsumerStatefulWidget {
  const FoodScreen({super.key});
  static const routeName = '/food';
  @override
  ConsumerState<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends ConsumerState<FoodScreen> {
  List<String> categories = [
    "All",
    "Breakfast",
    "North Indian",
    "South Indian",
    "Beverages",
    "Desserts",
  ];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List categories = fetchAndSetCategories(ref);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Food",
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
                  image: const DecorationImage(
                    image: AssetImage('assets/images/image4.png'),
                    fit: BoxFit.cover,
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
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.6),
                            Theme.of(context).colorScheme.surface,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: const [
              PlateIconButton(),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: FilterChip(
                          selected: selectedCategoryIndex == index,
                          onSelected: (bool value) {
                            setState(() {
                              selectedCategoryIndex = index;
                            });
                          },
                          label: Text(categories[index]),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ref.watch(foodItemStreamProvider).when(data: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        if (selectedCategoryIndex == 0 ||
                            item.category ==
                                categories[selectedCategoryIndex]) {
                          return FoodCard(
                            index: index,
                            foodData: data,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  }, error: (error, stackTrace) {
                    print(error);
                    print(stackTrace);
                    return const Center(
                      child: Text('unable to load food items'),
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
