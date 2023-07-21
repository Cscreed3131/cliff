import 'package:flutter/material.dart';

class MerchDetails extends StatelessWidget {

  static const routeName = '/merch-details';

  final String merchName;
  final int merchPrice;
  final String merchDesc;
  final String photoUrl;
  const MerchDetails({super.key, required this.merchName, required this.merchPrice, required this.merchDesc, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font30 = screenHeight * 0.035;
    final font18 = screenHeight * 0.02;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
              title: Text(
                "Merch Details",
                style: TextStyle(
                  fontFamily: 'IBMPlexMono',
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
                    height: screenHeight * 0.4,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(

                        //REPLACE THIS WITH THE ACTUAL PHOTO URL later
                        image: AssetImage(photoUrl),
                        fit: BoxFit.cover,
                      ),
                    )
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //Designs
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          merchName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: font30,
                            fontWeight: FontWeight.bold,
                            // color: textColor,
                          ),
                        ),
                        Text(
                          "\$$merchPrice",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: font30,
                            fontWeight: FontWeight.bold,
                            // color: textColor,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          merchDesc,
                          style: TextStyle(
                            fontSize: font18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: FilledButton(
                child: const Text(
                  "Buy Now",
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // color: textColor,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        )
      ),
    );
  }
}
