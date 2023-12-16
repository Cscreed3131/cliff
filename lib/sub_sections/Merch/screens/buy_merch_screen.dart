import 'dart:ui';

import 'package:cliff/sub_sections/Merch/widgets/cart_icon_widget.dart';
import 'package:cliff/sub_sections/Merch/widgets/merch_widget.dart';
import 'package:flutter/material.dart';

class BuyMerchScreen extends StatelessWidget {
  const BuyMerchScreen({super.key});
  static const routeName = '/merch';
  @override
  Widget build(BuildContext context) {
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
            // title: const Text(
            //   "Merch",
            //   style: TextStyle(
            //     fontFamily: 'IBMPlexMono',
            //     fontSize: 30,
            //     fontWeight: FontWeight.bold,
            //     // color: textColor,
            //   ),
            // ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Merch",
                style: TextStyle(
                  fontFamily: 'IBMPlexMono',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                  // color: textColor,
                ),
              ),
              expandedTitleScale: 1.2,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/merch.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(0.5),
                            Theme.of(context).colorScheme.surface,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: const [
              CartIconWidget(),
            ], // icon button which has a badge in it to show the quantity of
            //items in cart which updates upon adding and delete items from cart
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //event image container, this will not change (probably)
                  // Container(
                  //   height: screenHeight * 0.2,
                  //   width: double.infinity,
                  //   margin: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).colorScheme.secondaryContainer,
                  //     border: Border.all(
                  //       color: Theme.of(context).colorScheme.outline,
                  //     ),
                  //     borderRadius: BorderRadius.circular(20),
                  //     image: const DecorationImage(
                  //       image: AssetImage('assets/images/merch.png'),
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //   ),
                  // ),

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
