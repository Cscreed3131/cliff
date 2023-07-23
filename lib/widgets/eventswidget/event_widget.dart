import 'package:cliff/widgets/eventswidget/ongoing_event.dart';
import 'package:cliff/widgets/eventswidget/upcoming_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../helper/convert_int_time_of_day.dart';

class Event {
  final String title;
  final DateTime startDate;
  final DateTime finishDate;
  final TimeOfDay startTime;
  final TimeOfDay finishTime;

  Event({
    required this.title,
    required this.startDate,
    required this.finishDate,
    required this.startTime,
    required this.finishTime,
  });

  factory Event.fromFirestore(Map<String, dynamic> data) {
    return Event(
      title: data['eventname'],
      startDate: (data['eventstartdate'] as Timestamp).toDate(),
      finishDate: (data['eventfinshdate'] as Timestamp).toDate(),
      startTime: convertIntToTimeOfDay(data['eventstarttime']),
      finishTime: convertIntToTimeOfDay(data['eventendtime']),
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
            return event.startDate.isBefore(currentDate) &&
                event.finishDate.isAfter(currentDate) &&
                (event.startDate.isAtSameMomentAs(currentDate)
                    ? event.startTime.hour < currentTime.hour ||
                        (event.startTime.hour == currentTime.hour &&
                            event.startTime.minute <= currentTime.minute)
                    : true) &&
                (event.finishDate.isAtSameMomentAs(currentDate)
                    ? event.finishTime.hour > currentTime.hour ||
                        (event.finishTime.hour == currentTime.hour &&
                            event.finishTime.minute >= currentTime.minute)
                    : true);
          }).toList();

          final upcomingEvents = documents.where((doc) {
            Event event =
                Event.fromFirestore(doc.data() as Map<String, dynamic>);
            return event.startDate.isAfter(currentDate) ||
                (event.startDate.isAtSameMomentAs(currentDate)
                    ? event.startTime.hour > currentTime.hour ||
                        (event.startTime.hour == currentTime.hour &&
                            event.startTime.minute > currentTime.minute)
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
                  const SizedBox(height: 20),
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
