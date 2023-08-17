import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final clubMemberDetailsProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, sic) async {
  try {
    final documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(sic).get();
    if (documentSnapshot.exists) {
      final clubMember = documentSnapshot.data()!;
      return clubMember;
    } else {
      return {}; // Return an empty map if user data is not found
    }
  } catch (e) {
    // Return an empty map if an exception occurs during data fetching
    return {};
  }
});
