import 'package:cliff/widgets/homescreenwidget/app_drawer.dart';
import 'package:cliff/widgets/merchwidget/cart_widget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const routeName = '/cart';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: const Text(
              'Cart',
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Cart total:",
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: font20 * 0.85,
                      fontWeight: FontWeight.bold,
                      // color: textColor,
                    ),
                  ),
                ),
                const Cart(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
