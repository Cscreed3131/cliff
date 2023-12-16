import 'package:flutter/material.dart';

class MerchOrders extends StatelessWidget {
  const MerchOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final font20 = screenHeight * 0.02;
    int itemCount = 3;
    return itemCount > 0 ? MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
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
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Merch',
                            style: TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: font20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Order #123456',
                            style: TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: font20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Status: Pending',
                    style: TextStyle(
                      fontSize: font20,
                      // color: textColor,
                    ),
                  ),
                  Text(
                      'Total: \$100',
                      style: TextStyle(
                        fontSize: font20,
                      )
                  )
                ]
            ),
          );
        },
      ),
    )
    : Center(
      child: Text(
        'No Orders',
        style: TextStyle(
          height: 4,
          fontSize: font20,
        ),
      ),
    );
  }
}
