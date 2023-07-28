import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/Events/event_details_screen.dart';

class OnGoingEventWidget extends StatelessWidget {
  const OnGoingEventWidget({
    super.key,
    required this.ongoingEvents,
    required this.screenHeight,
    required this.font24,
  });

  final List<QueryDocumentSnapshot<Object?>> ongoingEvents;
  final double screenHeight;
  final double font24;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ongoingEvents.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.41,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final eventData = ongoingEvents[index];
        Timestamp eventStartDateTimeStamp = eventData['eventstartdatetime'];
        String eventStartDate =
            DateFormat('dd-MM-yyyy').format(eventStartDateTimeStamp.toDate());

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(
                  title: eventData['eventname'],
                  eventCode: eventData['eventcode'],
                  eventDescription: eventData['eventdescription'],
                  eventFinishDateTime: eventData['eventfinishdatetime'],
                  eventImage: eventData['image_url'],
                  eventStartDateTime: eventData['eventstartdatetime'],
                  eventVenue: eventData['eventVenue'],
                  clubMembersic1: eventData['clubmembersic1'],
                  clubMembersic2: eventData['clubmembersic2'],
                  // registeredStudents: eventData['registeredStudents'],
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            shadowColor: Colors.transparent,
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.165,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          eventData['image_url'],
                        ),
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
                      eventData['eventname'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: font24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        // color: textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.group,
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
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "200 Registered", // should be dynamic
                            style: TextStyle(
                              fontSize: 18,
                              // color: textColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          label: Text(
                            eventStartDate,
                          ),
                          avatar: const Icon(Icons.timelapse_rounded),
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
    );
  }
}
