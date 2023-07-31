import 'package:cliff/screens/merch/widgets/merch_designs.dart';
import 'package:cliff/screens/merch/widgets/merch_for_sale.dart';
import 'package:flutter/material.dart';



class BuyMerchScreen extends StatelessWidget {
  const BuyMerchScreen({super.key});
  static const routeName = '/Merch';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
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
                            )),

                        const SizedBox(
                          height: 20,
                        ),

                        const MerchDesigns(),

                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Up for Sale",
                            style: TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: font20,
                              fontWeight: FontWeight.bold,
                              // color: textColor,
                            ),
                          ),
                        ),

                        const MerchForSale(),
                      ]
                  )
              ),
          ),
        ],
      ),
    );
  }
}
