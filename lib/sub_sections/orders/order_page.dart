import 'package:flutter/material.dart';
// import '../../widgets/homescreenwidget/app_drawer.dart';
import 'food_orders.dart';
import 'merch_orders.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    return Scaffold(
      //drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(
              'Orders',
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Food Orders",
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: font20,
                      fontWeight: FontWeight.bold,
                      // color: textColor,
                    ),
                  ),
                ),

                //Current orders listview
                const FoodOrders(),
                const Divider(
                  indent: 16,
                  endIndent: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Merch Orders",
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: font20,
                      fontWeight: FontWeight.bold,
                      // color: textColor,
                    ),
                  ),
                ),
                const MerchOrders(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
