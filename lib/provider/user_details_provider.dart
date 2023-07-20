import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/userdetails.dart';

final userDataProvider = FutureProvider((ref) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> userDataMap =
          documentSnapshot.data()! as Map<String, dynamic>;
      print(userDataMap);
      return UserDetails(
        name: userDataMap['name'],
        sic: userDataMap['sic'],
        branch: userDataMap['branch'],
        email: userDataMap['email'],
        year: userDataMap['year'],
        phoneNumber: int.parse(userDataMap['phoneNumber']),
        imageUrl: userDataMap['image_url'] ?? '',
      );
    } else {
      throw Exception('User data not found');
    }
  } catch (e) {
    throw Exception('Error fetching user data: $e');
  }
});
