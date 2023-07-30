import 'package:cliff/widgets/eventswidget/ongoing_event.dart';
import 'package:cliff/widgets/eventswidget/upcoming_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime startDateTime;
  final DateTime finishDateTime;

  Event({
    required this.title,
    required this.startDateTime,
    required this.finishDateTime,
  });

  factory Event.fromFirestore(Map<String, dynamic> data) {
    return Event(
      title: data['eventname'],
      startDateTime: (data['eventstartdatetime'] as Timestamp).toDate(),
      finishDateTime: (data['eventfinishdatetime'] as Timestamp).toDate(),
    );
  }
}

DateTime getCurrentDate() => DateTime.now();
TimeOfDay getCurrentTime() => TimeOfDay.now();

class EventsWidget extends StatelessWidget {
  const EventsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    final font24 = screenHeight * 0.03;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final documents = snapshot.data?.docs ?? [];
          final DateTime currentDate = getCurrentDate();
          final TimeOfDay currentTime = getCurrentTime();

          final ongoingEvents = documents.where((doc) {
            Event event =
                Event.fromFirestore(doc.data() as Map<String, dynamic>);
            return event.startDateTime.isBefore(currentDate) &&
                event.finishDateTime.isAfter(currentDate) &&
                (event.startDateTime.isAtSameMomentAs(currentDate)
                    ? event.startDateTime.hour < currentTime.hour ||
                        (event.startDateTime.hour == currentTime.hour &&
                            event.startDateTime.minute <= currentTime.minute)
                    : true) &&
                (event.finishDateTime.isAtSameMomentAs(currentDate)
                    ? event.finishDateTime.hour > currentTime.hour ||
                        (event.finishDateTime.hour == currentTime.hour &&
                            event.finishDateTime.minute >= currentTime.minute)
                    : true);
          }).toList();

          final upcomingEvents = documents.where((doc) {
            Event event =
                Event.fromFirestore(doc.data() as Map<String, dynamic>);
            return event.startDateTime.isAfter(currentDate) ||
                (event.startDateTime.isAtSameMomentAs(currentDate)
                    ? event.startDateTime.hour > currentTime.hour ||
                        (event.startDateTime.hour == currentTime.hour &&
                            event.startDateTime.minute > currentTime.minute)
                    : false);
          }).toList();

          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display Ongoing Events
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Ongoing Events",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: font20, //should use media querry;
                        fontWeight: FontWeight.bold,
                        // color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OnGoingEventWidget(
                    ongoingEvents: ongoingEvents,
                    screenHeight: screenHeight,
                    font24: font24,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Display Upcoming Events
                  const Divider(
                    indent: 8,
                    endIndent: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Upcoming Events",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: font20,
                        fontWeight: FontWeight.bold,
                        // color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  UpComingEventsWidgets(
                    upcomingEvents: upcomingEvents,
                    screenHeight: screenHeight,
                    font24: font24,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
