import 'package:flutter/material.dart';

import 'merch_details_screen.dart';



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

                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Available Designs",
                            style: TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: font20,
                              fontWeight: FontWeight.bold,
                              // color: textColor,
                            ),
                          ),
                        ),

                        //Designs
                        GridView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index){
                            return InkWell(

                              //navigate to merch details screen
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  MerchDetails.routeName,
                                  arguments: {
                                    'merchName': 'Generic Shirt',
                                    'merchPrice': 100,
                                    'merchDesc': 'This is a cool merch. This is a cool merch. This is a cool merch. This is a cool merch. This is a cool merch. This is a cool merch. This is a cool merch. This is a cool merch. This is a cool merch. This is a cool merch. This is a cool merch. ',
                                    'photoUrl': 'assets/images/shirt.png'
                                  },
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
                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.outline,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/images/shirt.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Design Name",
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
                                      "\$ Design Price",
                                      style: TextStyle(
                                        fontFamily: 'IBMPlexMono',
                                        fontSize: font20-3,
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
                      ]
                  )
              ),
          ),
        ],
      ),
    );
  }
}
