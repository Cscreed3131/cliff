import 'package:animate_do/animate_do.dart';
import 'package:cliff/screens/food/food_details_page.dart';
import 'package:flutter/material.dart';
import '../../../global_varibales.dart';

class FoodCard extends StatefulWidget {
  final int index;
  const FoodCard({super.key, required this.index});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  int start = 200;
  int delay = 100;
  bool isAddedtoCart = false;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return FadeIn(
      delay: Duration(milliseconds: delay * widget.index),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(FoodDetailsPage.routeName, arguments: {
            'id': items[widget.index].id,
            'name': items[widget.index].name,
            'category': items[widget.index].category,
            'imgUrl': items[widget.index].imgUrl,
            'price': items[widget.index].price,
            'description': items[widget.index].description,
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
                    image: AssetImage(items[widget.index].imgUrl),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items[widget.index].name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    items[widget.index].category,
                    style: const TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: 15,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '₹ ${items[widget.index].price}',
                        style: const TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.23,
                      ),
                      // const Spacer(),
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
                                  color: Theme.of(context).colorScheme.outline,
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
            ],
          ),
        ),
      ),
    );
  }
}
