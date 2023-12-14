import 'package:cliff/screens/Merch/provider/cart_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../screens/cart_screen.dart';

class CartIconWidget extends ConsumerWidget {
  const CartIconWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartData = ref.watch(cartDataStreamProvider);

    return cartData.when(
      data: (value) {
        return IconButton(
          onPressed: () {
            Navigator.of(context).push(
              PageAnimationTransition(
                page: const CartScreen(),
                pageAnimationType: RightToLeftFadedTransition(),
              ),
            );
          },
          icon: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.shopping_cart, size: 32),
              ),
              if (value.isNotEmpty)
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
                      value.length.toString(),
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
        );
      },
      loading: () {
        return const CircularProgressIndicator(); // Show loading indicator
      },
      error: (error, stackTrace) {
        return const Text('Error fetching cart data');
      },
    );
  }
}
