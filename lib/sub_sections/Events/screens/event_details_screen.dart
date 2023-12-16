import 'package:cliff/sub_sections/Events/widgets/count_registered_participants.dart';
import 'package:cliff/sub_sections/Events/widgets/get_members_details.dart';
import 'package:cliff/sub_sections/Events/widgets/registeration_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String routeName = '/event-details';
  final String eventId;
  final String title;
  final String eventCode;
  final String eventVenue;
  final String eventImage;
  final DateTime eventStartDateTime;
  final DateTime eventFinishDateTime;
  final String eventDescription;
  final String club;
  final String clubMembersic1;
  final String clubMembersic2;

  const EventDetailsScreen({
    super.key,
    required this.title,
    required this.eventCode,
    required this.eventVenue,
    required this.eventImage,
    required this.eventFinishDateTime,
    required this.eventStartDateTime,
    required this.eventDescription,
    required this.club,
    required this.clubMembersic1,
    required this.clubMembersic2,
    required this.eventId,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int? numberOfRegisteredStudent;
  String? currentUserSic;
  bool isRegistered = false;
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
                  image: NetworkImage(widget.eventImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.title,
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
            Row(
              children: [
                // FilledButton for number of registered people
                CountRegisteredParticipants(eventId: widget.eventId),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: RegisterationButton(eventId: widget.eventId),
                ),
              ],
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
            ),
            //event details (includes code, venue, supervisor sic, start date, start time, end date, end time, description)

            //Cards for code and venue
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    child: ListTile(
                      // copy code to clipboard
                      // onTap: () async {
                      //   await Clipboard.setData(
                      //       ClipboardData(text: widget.eventCode));
                      //   ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Code copied to clipboard'),
                      //     ),
                      //   );
                      // },

                      leading: IconButton.filledTonal(
                        onPressed: () {},
                        icon: Icon(
                          Icons.diversity_2_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: const Text('Club'),
                      subtitle: Text(widget.club),
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
                      subtitle: Text(widget.eventVenue),
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
                          widget.eventStartDateTime,
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
                          widget.eventStartDateTime,
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
                          widget.eventFinishDateTime,
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
                          widget.eventFinishDateTime,
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
                widget.eventDescription,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Column(
                children: [
                  GetMemberDetails(sic: widget.clubMembersic1),
                  GetMemberDetails(sic: widget.clubMembersic2),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
