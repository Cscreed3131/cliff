import 'package:cliff/screens/food/widgets/food_card.dart';
import 'package:flutter/material.dart';
import '../../global_varibales.dart';

class FoodItem {
  final int id;
  final String name;
  final String category;
  final String imgUrl;
  final int price;
  final String description;

  FoodItem(this.id, this.name, this.category, this.imgUrl, this.price, this.description);
}

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});
  static const routeName = '/food';
  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {

  List<String> categories = [
    "All",//0
    "Breakfast",//1
    "North Indian",//2
    "South Indian",//3
    "Beverages",//4
    "Desserts",//5
  ];
  List<bool> selectedCategories = [
    true,
    false,
    false,
    false,
    false,
    false,
  ];

  void handleChipSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < selectedCategories.length; i++) {
        selectedCategories[i] = (i == selectedIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
            title: const Text(
              "Food",
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // color: textColor,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                  children: [
                    //event image container, this will not change (probably)
                    Container(
                        height: screenHeight * 0.2,
                        width: double.infinity,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/image4.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        )),

                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: 6,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: FilterChip(
                              selected: selectedCategories[index],
                              onSelected: (bool value) {
                                handleChipSelection(index);
                              },
                              label: Text(categories[index]),

                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    selectedCategories[0] ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return FoodCard(index: index);
                        },
                      ),
                    ) : const SizedBox(),

                    selectedCategories[1] ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return items[index].category == 'Breakfast' ? FoodCard(index: index) : const SizedBox();
                        },
                      ),
                    ) : const SizedBox(),
                    selectedCategories[2] ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return items[index].category == 'North Indian' ? FoodCard(index: index) : const SizedBox();
                        },
                      ),
                    ) : const SizedBox(),
                    selectedCategories[3] ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return items[index].category == 'South Indian' ? FoodCard(index: index) : const SizedBox();
                        },
                      ),
                    ) : const SizedBox(),
                    selectedCategories[4] ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return items[index].category == 'Beverages' ? FoodCard(index: index) : const SizedBox();
                        },
                      ),
                    ) : const SizedBox(),

                    selectedCategories[5] ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return items[index].category == 'Desserts' ? FoodCard(index: index) : const SizedBox();
                        },
                      ),
                    ) : const SizedBox(),
                  ]
              )
          ),
        ],
      ),
    );
  }
}
