import 'package:cliff/models/event.dart';
import 'package:cliff/provider/event_details_provider.dart';
import 'package:cliff/provider/user_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

final completedEventListProvider =
    StreamProvider.autoDispose<List<dynamic>>((ref) {
  final eventsData = ref.watch(eventDetailsStreamProvider);
  final List<dynamic> completedEventsIds = [];
  eventsData.whenData((data) {
    final DateTime currentDate = getCurrentDate();
    final TimeOfDay currentTime = getCurrentTime();
    final List<Event> completedEvents = data
        .where((event) =>
            event.eventFinishDateTime.isBefore(currentDate) ||
            (event.eventFinishDateTime.isAtSameMomentAs(currentDate)
                ? event.eventFinishDateTime.hour < currentTime.hour ||
                    (event.eventFinishDateTime.hour == currentTime.hour &&
                        event.eventFinishDateTime.minute <= currentTime.minute)
                : false))
        .toList();

    completedEventsIds.addAll(completedEvents.map((event) => event.eventId));
  });
  return Stream.value(completedEventsIds);
});

DateTime getCurrentDate() => DateTime.now();
TimeOfDay getCurrentTime() => TimeOfDay.now();

final notCompletedEventsProvider = StreamProvider.autoDispose<List>((ref) {
  List l1 = [];
  ref.watch(registeredEventsDataProvider).when(
        data: (data) {
          l1 = data;
        },
        error: (error, stackTrace) {
          print(error);
        },
        loading: () {},
      );

  List l2 = [];
  ref.watch(completedEventListProvider).when(
        data: (data) {
          l2 = data;
        },
        error: (error, stackTrace) {
          print(error);
        },
        loading: () {},
      );
  List notCompletedEventsList =
      l1.where((element) => !l2.contains(element)).toList();
  return Stream.value(notCompletedEventsList); // return as a stream
});
