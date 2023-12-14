import 'package:cliff/models/event.dart';
import 'package:cliff/screens/Events/provider/event_details_provider.dart';
import 'package:cliff/screens/Events/widgets/ongoing_event.dart';
import 'package:cliff/screens/Events/widgets/upcoming_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsWidget extends ConsumerWidget {
  const EventsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventDetailProvider = ref.watch(eventDetailsStreamProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    final font24 = screenHeight * 0.03;

// fecth the current date and time.
    DateTime getCurrentDate() => DateTime.now();
    TimeOfDay getCurrentTime() => TimeOfDay.now();
    return eventDetailProvider.when(
      data: (data) {
        final DateTime currentDate = getCurrentDate();
        final TimeOfDay currentTime = getCurrentTime();

        final List<Event> onGoingEvents = data
            .where((event) =>
                event.eventStartDateTime.isBefore(currentDate) &&
                event.eventFinishDateTime.isAfter(currentDate) &&
                (event.eventStartDateTime.isAtSameMomentAs(currentDate)
                    ? event.eventStartDateTime.hour < currentTime.hour ||
                        (event.eventStartDateTime.hour == currentTime.hour &&
                            event.eventStartDateTime.minute <=
                                currentTime.minute)
                    : true) &&
                (event.eventFinishDateTime.isAtSameMomentAs(currentDate)
                    ? event.eventFinishDateTime.hour > currentTime.hour ||
                        (event.eventFinishDateTime.hour == currentTime.hour &&
                            event.eventFinishDateTime.minute >=
                                currentTime.minute)
                    : true))
            .toList();

        final List<Event> upComingEvents = data
            .where((event) =>
                event.eventStartDateTime.isAfter(currentDate) ||
                (event.eventStartDateTime.isAtSameMomentAs(currentDate)
                    ? event.eventStartDateTime.hour > currentTime.hour ||
                        (event.eventStartDateTime.hour == currentTime.hour &&
                            event.eventStartDateTime.minute >
                                currentTime.minute)
                    : false))
            .toList();
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
                  ongoingEvents: onGoingEvents,
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
                  upcomingEvents: upComingEvents,
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
      },
      error: (error, stackTrace) {
        print(stackTrace);
        print(error);
        return const Text(
            'Cant load events right now. Please try again later.');
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
