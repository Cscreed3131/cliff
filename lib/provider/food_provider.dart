import 'package:cliff/models/food_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodItemStreamProvider =
    StreamProvider.autoDispose<List<FoodItem>>((ref) {
  final CollectionReference foodItemsCollection =
      FirebaseFirestore.instance.collection('food_items');

  return foodItemsCollection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        doc['id'],
        doc['name'],
        doc['category'],
        doc['image'],
        doc['price'],
        doc['description'],
      );
    }).toList();
  });
});
