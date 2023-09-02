import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FoodDetailsPage extends StatefulWidget {
  static const routeName = '/food-details';
  // final int id;
  final String name;
  final String category;
  final String imgUrl;
  final double price;
  final String description;

  const FoodDetailsPage({
    super.key,
    // required this.id,
    required this.name,
    required this.category,
    required this.imgUrl,
    required this.price,
    required this.description,
  });

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  bool isAddedtoCart = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font30 = screenHeight * 0.035;
    final font18 = screenHeight * 0.02;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Food Details'),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    height: screenHeight * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(widget.imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Designs
                  Container(
                    margin: const EdgeInsets.all(10),
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
                        Text(
                          "\$${widget.price}",
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
                          style: TextStyle(
                            fontSize: font18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Row(
          children: [
            !isAddedtoCart
                ? Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeIn(
                          child: FilledButton(
                            child: const Text(
                              "Add Item",
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // color: textColor,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isAddedtoCart = true;
                                count = 1;
                              });
                            },
                          ),
                        )),
                  )
                : Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInUp(
                          delay: const Duration(milliseconds: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton.outlined(
                                  onPressed: () {
                                    setState(() {
                                      count > 1
                                          ? count--
                                          : isAddedtoCart = false;
                                    });
                                  },
                                  icon: const Icon(Icons.remove)),
                              Text(
                                count.toString(),
                                style: const TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  // color: textColor,
                                ),
                              ),
                              IconButton.outlined(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
          ],
        ));
  }
}
