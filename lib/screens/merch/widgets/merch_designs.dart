import 'package:cliff/screens/Merch/merch_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MerchDesigns extends StatefulWidget {
  final List<QueryDocumentSnapshot<Object?>> isForDisplayList;
  const MerchDesigns({
    super.key,
    required this.isForDisplayList,
  });

  @override
  State<MerchDesigns> createState() => _MerchDesignsState();
}

class _MerchDesignsState extends State<MerchDesigns> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    int itemCount = widget.isForDisplayList.length;
    return itemCount > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Design Showcase",
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: font20,
                    fontWeight: FontWeight.bold,
                    // color: textColor,
                  ),
                ),
              ),
              GridView.builder(
                itemCount: itemCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7, // 1.41
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  // mainAxisExtent: 280,
                ),
                itemBuilder: (context, index) {
                  final merchData = widget.isForDisplayList[index];
                  String merchName = merchData['productname'];
                  String merchImage = merchData['image_url'];
                  return InkWell(
                    //navigate to merch details screen
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MerchDetails.routeName,
                        arguments: {
                          'merchName': merchName,
                          'merchPrice': int.parse(merchData['productprice']),
                          'merchDesc': merchData['productdescription'],
                          'photoUrl': merchImage,
                        },
                      );
                    },

                    onDoubleTap: () {
                      if (isLiked) {
                        setState(() {
                          isLiked = false;
                        });
                      } else {
                        setState(() {
                          isLiked = true;
                        });
                      }
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                    merchImage), // fetch from backend
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
                          FilledButton.tonalIcon(
                            onPressed: () {
                              if (isLiked) {
                                setState(() {
                                  isLiked = false;
                                });
                              } else {
                                setState(() {
                                  isLiked = true;
                                });
                              }
                            },
                            icon: isLiked
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent,
                                  )
                                : const Icon(Icons.favorite_border),
                            label: const Text('24 Likes'),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Divider(
                indent: 16,
                endIndent: 16,
              ),
            ],
          )
        : const SizedBox();
  }
}
