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
  bool isAddedoCart = false;
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
                        FadeIn(
                          child: FilledButton.icon(
                            label: const Text('Add'),
                            onPressed: () {
                              setState(
                                () {
                                  isAddedoCart = true;
                                  count = 1;
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BottomSheetContent(
                                        initialCount: count,
                                        onCountChanged: (newCount) {
                                          setState(() {
                                            count = newCount;
                                          });
                                        },
                                        image: data[index].imgUrl,
                                        name: data[index].name,
                                        category: data[index].category,
                                        description: data[index].description,
                                        price: data[index].price,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.fastfood_rounded),
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

class BottomSheetContent extends StatefulWidget {
  final int initialCount;
  final String name;
  final String image;
  final String category;
  final double price;
  final String description;
  final Function(int) onCountChanged;

  const BottomSheetContent({
    super.key,
    required this.initialCount,
    required this.onCountChanged,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.description,
  });

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font30 = screenHeight * 0.035;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            height: screenHeight * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: font30,
                    fontWeight: FontWeight.bold,
                    // color: textColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 130,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        setState(() {
                          if (count > 1) {
                            count--;
                            widget.onCountChanged(count);
                          } else {
                            Navigator.of(context).pop();
                          }
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
                    IconButton.filled(
                      onPressed: () {
                        setState(() {
                          count++;
                          widget.onCountChanged(count);
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              // const Text('hey'),
              // const Spacer(),
              // Chip(
              //   label: Text('${widget.price * count}'),
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.fastfood),
                  label: Text(
                    'Add item ₹${(widget.price * count).round()}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
