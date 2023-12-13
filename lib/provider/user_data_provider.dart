import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cliff/models/userdetails.dart';

final realTimeUserDataProvider =
    StreamProvider.autoDispose<UserDetails>((ref) async* {
  ref.keepAlive();
  final auth = FirebaseAuth.instance;
  await for (final user in auth.authStateChanges()) {
    if (user != null) {
      // User is logged in, fetch user details
      var userDoc = FirebaseFirestore.instance
          .collection('users')
          .where('userid', isEqualTo: user.uid)
          .snapshots();

      final data = await userDoc.first;
      if (data.docs.isNotEmpty) {
        final userData = data.docs.first.data();
        final userDetails = UserDetails(
          name: userData['name'],
          sic: userData['sic'],
          branch: userData['branch'],
          email: userData['email'],
          year: userData['year'],
          phoneNumber: int.parse(userData['phoneNumber']),
          imageUrl: userData['image_url'],
          likedProducts: userData['likedproducts'],
          registeredEvents: userData['events_registered'],
          cart: userData['cart'],
          roles: userData['user_role'],
        );
        yield userDetails;
      }
    }
  }
});

// final realTimeUserDataProvider =
//     StreamProvider.autoDispose<UserDetails>((ref) async* {
//   ref.keepAlive();
//   final auth = FirebaseAuth.instance;
//   await for (final user in auth.authStateChanges()) {
//     if (user != null) {
//       // User is logged in, fetch user details
//       FirebaseFirestore.instance
//           .collection('users')
//           .where('userid', isEqualTo: user.uid)
//           .snapshots()
//           .map(
//         (querySnapshot) {
//           return querySnapshot.docs.map(
//             (doc) {
//               Map<String, dynamic> data = doc.data();
//               return UserDetails(
//                 name: data['name'],
//                 sic: data['sic'],
//                 branch: data['branch'],
//                 email: data['email'],
//                 year: data['year'],
//                 phoneNumber: int.parse(data['phoneNumber']),
//                 imageUrl: data['image_url'],
//                 likedProducts: data['likedproducts'],
//                 registeredEvents: data['events_registered'],
//                 cart: data['cart'],
//                 roles: data['role'],
//               );
//             },
//           );
//         },
//       );

      // final data = await userDoc.first;
      // if (data.docs.isNotEmpty) {
      //   final userData = data.docs.first.data();
      //   final userDetails = UserDetails(
      //     name: userData['name'],
      //     sic: userData['sic'],
      //     branch: userData['branch'],
      //     email: userData['email'],
      //     year: userData['year'],
      //     phoneNumber: int.parse(userData['phoneNumber']),
      //     imageUrl: userData['image_url'],
      //     likedProducts: userData['likedproducts'],
      //     registeredEvents: userData['events_registered'],
      //     cart: userData['cart'],
      //     roles: userData['user_role'],
      //   );
      //   yield userDetails;
      // }
//     }
//   }
// });

// class UserDataProvider {
//   Future<String> getUserData() async {
//     String userId = '';
//     var currrentUser = FirebaseAuth.instance.currentUser!.uid;
//     final userQuery = await FirebaseFirestore.instance
//         .collection("users")
//         .where("userid", isEqualTo: currrentUser)
//         .get();
//     for (var docSnapshot in userQuery.docs) {
//       userId = docSnapshot.id;
//     }

//     return userId;
//   }
// }

// final userDataProvider1 = StreamProvider.autoDispose((ref) {
//   final User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .where('userid', isEqualTo: user.uid)
//         .snapshots();
//   }
//   return Stream.value(null);
// });

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
// name: userData['name'],
//         sic: userData['sic'],
//         branch: userData['branch'],
//         email: userData['email'],
//         year: userData['year'],
//         phoneNumber: int.parse(userData['phoneNumber']),
//         imageUrl: userData['image_url'],
//         likedProducts: userData['likedproducts'],
//         registeredEvents: userData['events_registered'],
//         cart: userData['cart'],