import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = '/event-details';

  final String title;
  final String eventCode;
  final String eventVenue;
  final String eventImage;
  final Timestamp eventStartDateTime;
  final Timestamp eventFinishDateTime;
  final String eventDescription;
  final String supervisorSIC;

  const EventDetailsScreen({
    super.key,
    required this.title,
    required this.eventCode,
    required this.eventVenue,
    required this.eventImage,
    required this.eventFinishDateTime,
    required this.eventStartDateTime,
    required this.eventDescription,
    required this.supervisorSIC,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font30 = screenHeight * 0.04;
    final font24 = screenHeight * 0.02;
    final titleStyle = TextStyle(
      fontSize: font24,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSecondaryContainer,
    );
    return Scaffold(
        // might remove this app bar if it look good
        appBar: AppBar(
          title: const Text('Event Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: double.maxFinite,
                height: screenHeight * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(eventImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1,
                    fontSize: font30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //FilledButton for number of registered people
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FilledButton.tonalIcon(
                      onPressed: () {},
                      label: const Text('20'), // to be dynamic
                      icon: const Icon(Icons.group),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Register'),
                    ),
                  ),
                ],
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
              //event details (includes code, venue, supervisor sic, start date, start time, end date, end time, description)

              //Card for Supervisor details
              Card(
                child: ListTile(
                  leading: IconButton.filledTonal(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  title: const Text('Supervisor '),
                  subtitle: Text(
                    'SIC: $supervisorSIC',
                    overflow: TextOverflow.ellipsis,
                    // make this dynamic
                  ),
                  titleTextStyle: titleStyle,
                ),
              ),

              //Cards for code and venue
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        //copy code to clipboard
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: eventCode));
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Code copied to clipboard'),
                            ),
                          );
                        },

                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.code,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text('Code'),
                        subtitle: Text(eventCode),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text('Venue'),
                        subtitle: Text(eventVenue),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                ],
              ),

              //Cards for Start date and start time
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.event_available,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text(
                          'Start Date',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          DateFormat('dd-MM-yy').format(
                            eventStartDateTime.toDate(),
                          ),
                        ),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.timer_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text(
                          'Start Time',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          DateFormat('hh:mm a').format(
                            eventStartDateTime.toDate(),
                          ),
                        ),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                ],
              ),

              //cards for end date and end time
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.event_busy,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text(
                          'End Date',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          DateFormat('dd-MM-yy').format(
                            eventFinishDateTime.toDate(),
                          ),
                        ),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.timer,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text(
                          'End Time',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          DateFormat('hh:mm a').format(
                            eventFinishDateTime.toDate(),
                          ),
                        ),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  eventDescription,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
