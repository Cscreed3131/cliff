import 'package:cliff/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventDetailsStreamProvider =
    StreamProvider.autoDispose<List<Event>>((ref) {
  // ref.keepAlive();
  return FirebaseFirestore.instance
      .collection('events')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Event(
        eventId: doc.id,
        eventName: data['eventname'],
        eventCode: data['eventcode'],
        eventVenue: data['eventVenue'],
        eventDescription: data['eventdescription'],
        eventStartDateTime: (data['eventstartdatetime'] as Timestamp).toDate(),
        eventFinishDateTime:
            (data['eventfinishdatetime'] as Timestamp).toDate(),
        clubMemberSic1: data['clubmembersic1'],
        clubMemberSic2: data['clubmembersic2'],
        club: data['club'],
        imageUrl: data['image_url'],
        registeredParticipants: data['registered_participants'],
      );
    }).toList();
  });
});
