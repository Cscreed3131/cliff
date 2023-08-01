import 'package:cliff/screens/Merch/widgets/merch_designs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../screens/Merch/widgets/merch_for_sale.dart';

class Merch {
  final String name;
  final String isForSale;

  Merch({
    required this.name,
    required this.isForSale,
  });

  factory Merch.fromFireStore(Map<String, dynamic> data) {
    return Merch(
      name: data['productname'],
      isForSale: data['isforsale'],
    );
  }
}

class MerchWidget extends StatelessWidget {
  const MerchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('merchandise').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final documents = snapshot.data?.docs ?? [];

          final isForSaleList = documents.where((doc) {
            Merch merch =
                Merch.fromFireStore(doc.data() as Map<String, dynamic>);
            return merch.isForSale == 'true' ? true : false;
          }).toList();
          final isForDisplayList = documents.where((doc) {
            Merch merch =
                Merch.fromFireStore(doc.data() as Map<String, dynamic>);
            return merch.isForSale == 'false' ? true : false;
          }).toList();
          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MerchDesigns(
                  isForDisplayList: isForDisplayList,
                ),
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
                MerchForSale(isForSaleList: isForSaleList),
              ],
            ),
          );
        }
      },
    );
  }
}
