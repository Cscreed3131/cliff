import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cliff/models/merch.dart';

final merchandiseStreamProvider =
    StreamProvider.autoDispose<List<Merchandise>>((ref) {
  return FirebaseFirestore.instance
      .collection('merchandise')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Merchandise(
        id: doc.id,
        addedBy: data['addedby'],
        createdBy: data['createdby'],
        imageUrl: data['image_url'],
        isForSale: data['isforsale'],
        productDescription: data['productdescription'],
        productName: data['productname'],
        productPrice: double.parse(data['productprice']),
        likes: data['likes'],
      );
    }).toList();
  });
});
