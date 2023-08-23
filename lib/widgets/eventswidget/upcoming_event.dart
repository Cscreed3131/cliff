import 'package:animate_do/animate_do.dart';
import 'package:cliff/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/Events/event_details_screen.dart';

class UpComingEventsWidgets extends StatelessWidget {
  const UpComingEventsWidgets({
    super.key,
    required this.upcomingEvents,
    required this.screenHeight,
    required this.font24,
  });

  final List<Event> upcomingEvents;
  final double screenHeight;
  final double font24;
  final start = 100;
  @override
  Widget build(BuildContext context) {
    return upcomingEvents.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: upcomingEvents.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.41,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final eventData = upcomingEvents[index];
              String eventStartDate =
                  DateFormat('dd-MM-yyyy').format(eventData.eventStartDateTime);

              return FadeIn(
                duration: Duration(milliseconds: start * (index + 1)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(
                          eventId: eventData.eventId,
                          title: eventData.eventName,
                          eventCode: eventData.eventCode,
                          eventDescription: eventData.eventDescription,
                          eventFinishDateTime: eventData.eventFinishDateTime,
                          eventImage: eventData.imageUrl,
                          eventStartDateTime: eventData.eventStartDateTime,
                          eventVenue: eventData.eventVenue,
                          club: eventData.club,
                          clubMembersic1: eventData.clubMemberSic1,
                          clubMembersic2: eventData.clubMemberSic2,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: screenHeight * 0.165,
                          width: double.infinity,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                eventData.imageUrl,
                              ), // should be dynamic
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            eventData.eventName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: font24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              // color: textColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.diversity_2_rounded,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CircleAvatar(
                                radius: 3,
                                backgroundColor:
                                    Theme.of(context).colorScheme.outline,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  eventData.club, // should be dynamic
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    // color: textColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  // side: BorderSide.none,
                                ),
                                label: Text(
                                  eventStartDate,
                                  overflow: TextOverflow.ellipsis,
                                  // should date dynamically and the date should
                                ),
                                avatar: const Icon(Icons.today),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text(
              "No Upcoming Events",
              style: TextStyle(height: 2.5),
            ),
          );
  }
}
