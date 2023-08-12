import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/userdetails.dart';

// final realTimeUserDataProvider = StreamProvider<UserDetails?>((ref) {
//   final userDoc = FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid);

//   return userDoc.snapshots().map((snapshot) {
//     if (snapshot.exists) {
//       Map<String, dynamic> userDataMap =
//           snapshot.data() as Map<String, dynamic>;
//       return UserDetails(
//         userDataMap['name'],
//         userDataMap['sic'],
//         userDataMap['branch'],
//         userDataMap['email'],
//         userDataMap['year'],
//         int.parse(userDataMap['phoneNumber']),
//         userDataMap['image_url'] ?? '',
//         userDataMap['likedproducts'] ?? [],
//         userDataMap['events_registered'] ?? [],
//         List<String>.from(userDataMap['cart'] ?? []),
//       );
//     } else {
//       return null;
//     }
//   });
// });

class UserDataProvider {
  Future<String> getUserData() async {
    String userId = '';
    var currrentUser = FirebaseAuth.instance.currentUser!.uid;
    final userQuery = await FirebaseFirestore.instance
        .collection("users")
        .where("userid", isEqualTo: currrentUser)
        .get();
    for (var docSnapshot in userQuery.docs) {
      userId = docSnapshot.id;
    }

    return userId;
  }
}

final userDataProvider1 = StreamProvider.autoDispose((ref) {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('userid', isEqualTo: user.uid)
        .snapshots();
  }
  return Stream.value(null);
});

// WidgetRef? ref;
// final userSnapshot = ref!.watch(userDataProvider1);
// void check() {
//   userSnapshot.when(
//       data: (data) {
//         if (data != null && data.docs.isNotEmpty) {
//           final userData = data.docs[0].data();

//           // Print the data to the console
//           print('User Data: $userData[""]');
//         }
//       },
//       error: (Object error, StackTrace stackTrace) {},
//       loading: () {});
// }
