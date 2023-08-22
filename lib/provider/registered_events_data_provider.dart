import 'package:cliff/provider/user_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registeredEventsDataProvider =
    StreamProvider.autoDispose<List<dynamic>>((ref) {
  final userSic = ref.watch(realTimeUserDataProvider).value!.sic;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(userSic)
      .snapshots()
      .map(
    (userSnapshot) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      List<dynamic> eventsData = userData['events_registered'] != null
          ? List<dynamic>.from(userData['events_registered'])
          : [];
      return eventsData;
    },
  );
});
