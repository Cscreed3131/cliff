import 'package:cliff/models/cart.dart';
import 'package:cliff/provider/cart_data_provider.dart';
import 'package:cliff/provider/user_data_provider.dart';
import 'package:cliff/screens/Merch/cart_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class CartIconWidget extends StatefulWidget {
  const CartIconWidget({super.key});

  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  final CartDataProvider cartDataProvider = CartDataProvider();
  final UserDataProvider userDataProvider = UserDataProvider();

  String? lastFetchedUserId;
  List<CartItem> lastFetchedCartData = [];

  Future<String> _getUserData() async {
    final userData = await userDataProvider.getUserData();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Handle error state
          return const Text('Error fetching user data');
        } else {
          final userId = snapshot.data;

          if (userId != lastFetchedUserId) {
            // User data has changed, fetch cart data
            lastFetchedUserId = userId;

            return StreamBuilder<List<CartItem>>(
              stream: cartDataProvider.getCartDataStream(userId!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // Handle error state
                  return const Text('Error fetching cart data');
                } else {
                  List<CartItem> cartData = snapshot.data ?? [];

                  if (!listEquals(cartData, lastFetchedCartData)) {
                    // Cart data has changed, update the UI
                    lastFetchedCartData = cartData;
                  }

                  int cartItemCount = lastFetchedCartData.length;

                  return IconButton(
                    icon: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.shopping_cart, size: 32),
                        ),
                        if (cartItemCount > 0)
                          Positioned(
                            right: 8,
                            bottom: 20,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                cartItemCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        PageAnimationTransition(
                          page: const CartScreen(),
                          pageAnimationType: RightToLeftFadedTransition(),
                        ),
                      );
                    },
                  );
                }
              },
            );
          } else {
            // User data hasn't changed, return the cached UI
            return IconButton(
              icon: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.shopping_cart, size: 32),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  PageAnimationTransition(
                    page: const CartScreen(),
                    pageAnimationType: RightToLeftFadedTransition(),
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
