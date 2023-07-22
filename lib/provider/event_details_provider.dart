//might not need this might delete this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/eventsdetails.dart';

class EventDetailsNotifier extends StateNotifier<List<EventDetails>> {
  EventDetailsNotifier() : super([]);

  Future<void> fetchAndSetEvents() async {
    // Replace 'events' with the actual collection name in your Firebase Firestore
    final eventsCollection = FirebaseFirestore.instance.collection('events');

    try {
      final querySnapshot = await eventsCollection.get();
      final eventsData =
          querySnapshot.docs.map((eventDoc) => eventDoc.data()).toList();

      // Convert eventsData into a list of EventDetails objects
      final eventDetailsList = eventsData.map((eventData) {
        return EventDetails(
          eventName: eventData['eventname'],
          eventVenue: eventData['eventVenue'],
          currentUser: eventData['currentUser'],
          eventCode: eventData['eventcode'],
          supervisor: eventData['supervisorsic'],
          eventDescription: eventData['eventdescription'],
          eventEndTime: eventData['eventendeime'],
          eventFinishDate: eventData['eventfinshdate'],
          eventStartDate: eventData['eventstartdate'],
          eventStartTime: eventData['eventstarttime'],
          imageURL: eventData['image_url'],
        );
      }).toList();
      print(eventDetailsList);

      state = eventDetailsList;
    } catch (error) {
      // Handle the error (e.g., show a snackbar or log the error)
    }
  }
}

final eventDataProvider =
    StateNotifierProvider<EventDetailsNotifier, List<EventDetails>>(
  (ref) => EventDetailsNotifier(),
);
