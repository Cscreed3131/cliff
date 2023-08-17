import 'package:cliff/models/merch.dart';
import 'package:cliff/provider/merch_data_provider.dart';
import 'package:cliff/widgets/merchwidget/merch_designs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'merch_for_sale.dart';

// class Merch {
//   final String name;
//   final String isForSale;

//   Merch({
//     required this.name,
//     required this.isForSale,
//   });

//   factory Merch.fromFireStore(Map<String, dynamic> data) {
//     return Merch(
//       name: data['productname'],
//       isForSale: data['isforsale'],
//     );
//   }
// }

class MerchWidget extends ConsumerWidget {
  const MerchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;

    final merchandiseList = ref.watch(merchandiseStreamProvider);
    return merchandiseList.when(data: (data) {
      final List<Merchandise> isForSaleList =
          data.where((merchandise) => merchandise.isForSale == "true").toList();

      final List<Merchandise> isForDisplayList = data
          .where((merchandise) => merchandise.isForSale == "false")
          .toList();
      return Column(
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
          MerchForSale(
            isForSaleList: isForSaleList,
          ),
        ],
      );
    }, error: (error, stackTrace) {
      print(error.toString());
      return const Text('Unable to load Merchandise');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
