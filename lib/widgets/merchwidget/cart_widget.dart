import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cliff/global_varibales.dart';

class CartItem {
  final String name;
  final int quantity;
  final String size;
  final String productId;
  final int price;
  final String photoUrl;

  CartItem({
    required this.name,
    required this.quantity,
    required this.size,
    required this.productId,
    required this.price,
    required this.photoUrl,
  });
}

class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> cartItems = [];
  Stream<List<CartItem>> getCartDataStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((userSnapshot) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> cartData = userData['cart'] != null
          ? Map<String, dynamic>.from(userData['cart'])
          : {};

      List<CartItem> cartItems = [];
      cartData.forEach((productId, productData) {
        cartItems.add(CartItem(
          productId: productId,
          name: productData['name'],
          quantity: productData['quantity'],
          size: productData['size'],
          price: productData['price'],
          photoUrl: productData['photoUrl'],
        ));
      });

      return cartItems;
    });
  }

  double calculateTotalPrice(List<CartItem> cartItems) {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  void addItemToCart(CartItem item) {
    setState(() {
      cartItems.add(item);
    });
  }

  void removeItemFromCart(String productId) {
    setState(() {
      cartItems.removeWhere((item) => item.productId == productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final font20 = screenHeight * 0.02;

    return FutureBuilder<String>(
      future: getUserData(),
      builder: (context, userIdSnapshot) {
        if (userIdSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (userIdSnapshot.hasError) {
          return Center(child: Text('Error: ${userIdSnapshot.error}'));
        } else {
          String userId = userIdSnapshot.data ?? '';

          return StreamBuilder<List<CartItem>>(
            stream: getCartDataStream(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<CartItem> cartItems = snapshot.data ?? [];
                int itemCount = cartItems.length;

                return itemCount > 0
                    ? MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
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
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    cartItems[index].photoUrl),
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
                                                cartItems[index].name,
                                                style: TextStyle(
                                                  fontFamily: 'IBMPlexMono',
                                                  fontSize: font20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Size: ${cartItems[index].size}',
                                                style: TextStyle(
                                                  fontSize: font20 * 0.85,
                                                  fontFamily: 'IBMPlexMono',
                                                ),
                                              ),
                                              Text(
                                                'Price: ₹${cartItems[index].price}',
                                                style: TextStyle(
                                                  fontSize: font20 * 0.85,
                                                  fontFamily: 'IBMPlexMono',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {},
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
                              onPressed: () {},
                              child: Text(
                                'Add Items now',
                                style: TextStyle(fontSize: font20),
                              ),
                            ),
                          ],
                        ),
                      );
              }
            },
          );
        }
      },
    );
  }
}
