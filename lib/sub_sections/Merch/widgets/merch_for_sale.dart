import 'package:cliff/models/merch.dart';
import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../screens/merch_details_screen.dart';

class MerchForSale extends StatefulWidget {
  final List<Merchandise> isForSaleList;

  const MerchForSale({super.key, required this.isForSaleList});

  @override
  State<MerchForSale> createState() => _MerchForSaleState();
}

class _MerchForSaleState extends State<MerchForSale> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    final itemCount = widget.isForSaleList.length;
    return itemCount > 0
        ? GridView.builder(
            itemCount: itemCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final merchData = widget.isForSaleList[index];
              final merchName = merchData.productName;
              final merchPrice = merchData.productPrice;
              final merchImage = merchData.imageUrl;

              return InkWell(
                //navigate to merch details screen
                onTap: () {
                  Navigator.of(context).push(
                    PageAnimationTransition(
                      page: MerchDetails(
                        merchName: merchName,
                        merchPrice: merchPrice,
                        merchDesc: merchData.productDescription,
                        photoUrl: merchImage,
                        isForSale: true,
                        merchId: merchData.id,
                      ),
                      pageAnimationType: RightToLeftFadedTransition(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.18,
                        width: double.infinity,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(merchImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        merchName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: font20,
                          fontWeight: FontWeight.bold,
                          // color: textColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '₹ $merchPrice',
                        style: TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: font20 - 3,
                          fontWeight: FontWeight.bold,
                          // color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'Nothing for sale',
                style: TextStyle(fontFamily: 'IBMPlexMono', fontSize: 15),
              ),
            ),
          );
  }
}
