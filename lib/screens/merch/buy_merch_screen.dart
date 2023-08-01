import 'package:cliff/widgets/merchwidget/merch_widget.dart';
import 'package:flutter/material.dart';

class BuyMerchScreen extends StatelessWidget {
  const BuyMerchScreen({super.key});
  static const routeName = '/merch';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text(
              "Merch",
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // color: textColor,
              ),
            ),

            // added the icon button for cart will have to add a page to route it to.
            // should also contain a badge to display the number of items selected
            actions: [
              IconButton(
                onPressed: () {
                  null;
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //event image container, this will not change (probably)
                  Container(
                    height: screenHeight * 0.2,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/merch.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  const MerchWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
