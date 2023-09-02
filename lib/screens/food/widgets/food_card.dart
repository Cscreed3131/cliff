import 'package:animate_do/animate_do.dart';
import 'package:cliff/models/food_item.dart';
import 'package:cliff/screens/food/food_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodCard extends ConsumerStatefulWidget {
  final int index;
  final List<FoodItem> foodData;
  const FoodCard({
    super.key,
    required this.index,
    required this.foodData,
  });

  @override
  ConsumerState<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends ConsumerState<FoodCard> {
  int start = 200;
  int delay = 100;
  bool isAddedtoCart = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    final data = widget.foodData;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return FadeIn(
      delay: Duration(milliseconds: delay * index),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(FoodDetailsPage.routeName, arguments: {
            // 'id': data[index].id,
            'name': data[index].name,
            'category': data[index].category,
            'imgUrl': data[index].imgUrl,
            'price': data[index].price,
            'description': data[index].description,
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                height: screenHeight * 0.1,
                width: screenHeight * 0.1,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                        data[index].imgUrl), // should be networkImage
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.633,
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data[index].category,
                      style: const TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '₹ ${data[index].price}',
                          style: const TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 15,
                          ),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.23,
                        // ),
                        const Spacer(),
                        !isAddedtoCart
                            ? FadeIn(
                                child: FilledButton.icon(
                                  label: const Text('Add'),
                                  onPressed: () {
                                    setState(() {
                                      isAddedtoCart = true;
                                      count = 1;
                                    });
                                  },
                                  icon: const Icon(Icons.fastfood_rounded),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: FadeIn(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            count > 1
                                                ? count--
                                                : isAddedtoCart = false;
                                          });
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text(
                                        '$count',
                                        style: const TextStyle(
                                          fontFamily: 'IBMPlexMono',
                                          fontSize: 15,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            count++;
                                          });
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
