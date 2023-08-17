import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cliff/models/cart.dart';
import 'package:cliff/provider/cart_data_provider.dart';
import 'package:cliff/provider/user_data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {
  double calculateTotalPrice(List<CartItem> items) {
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  void removeItemFromCart(String productId, String userId) {
    final userReference =
        FirebaseFirestore.instance.collection('users').doc(userId);

    userReference.update({
      'cart.$productId': FieldValue.delete(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final font20 = screenHeight * 0.02;

    final cartData = ref.watch(cartDataStreamProvider);
    final userData = ref.watch(realTimeUserDataProvider);
    return cartData.when(data: (items) {
      int itemCount = items.length;
      return itemCount > 0
          ? MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Cart total: ₹${calculateTotalPrice(items)}",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: font20 * 0.85,
                        fontWeight: FontWeight.bold,
                        // color: textColor,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: itemCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: screenHeight * 0.1,
                                      width: screenWidth * 0.25,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              items[index].photoUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index].name,
                                          style: TextStyle(
                                            fontFamily: 'IBMPlexMono',
                                            fontSize: font20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Size: ${items[index].size}',
                                          style: TextStyle(
                                            fontSize: font20 * 0.85,
                                            fontFamily: 'IBMPlexMono',
                                          ),
                                        ),
                                        Text(
                                          'Price: ₹${items[index].price}',
                                          style: TextStyle(
                                            fontSize: font20 * 0.85,
                                            fontFamily: 'IBMPlexMono',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        removeItemFromCart(
                                            items[index].productId,
                                            userData.value!.sic);
                                      },
                                      icon: const Icon(
                                        Icons.delete_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nothing in cart',
                    style: TextStyle(
                      height: 0,
                      fontSize: font20 + 9,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Add Items now',
                      style: TextStyle(fontSize: font20),
                    ),
                  ),
                ],
              ),
            );
    }, error: (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
      return const Text(
          'Unable to fetch cart data at the moment please Try again later');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
