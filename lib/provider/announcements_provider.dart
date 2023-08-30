import 'package:cliff/models/announcements.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final announcementsStreamProvider =
    StreamProvider.autoDispose<List<Announcements>>(
  (ref) {
    return FirebaseFirestore.instance
        .collection('announcements')
        .orderBy('date_and_time', descending: true)
        .limit(15)
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            Map<String, dynamic> data = doc.data();
            return Announcements(
              link: data['link'],
              message: data['message'],
              dateTime: (data['date_and_time'] as Timestamp).toDate(),
            );
          },
        ).toList();
      },
    );
  },
);
