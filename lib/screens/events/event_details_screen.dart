import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String routeName = '/event-details';

  final String title;
  final String eventCode;
  final String eventVenue;
  final String eventImage;
  final Timestamp eventStartDateTime;
  final Timestamp eventFinishDateTime;
  final String eventDescription;
  final String clubMembersic1;
  final String clubMembersic2;
  // final int registeredStudents;

  const EventDetailsScreen({
    super.key,
    required this.title,
    required this.eventCode,
    required this.eventVenue,
    required this.eventImage,
    required this.eventFinishDateTime,
    required this.eventStartDateTime,
    required this.eventDescription,
    required this.clubMembersic1,
    required this.clubMembersic2,
    // required this.registeredStudents,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String? clubMemberName1;
  String? clubMemberName2;
  String? clubMemberPhoneNumber1;
  String? clubMemberPhoneNumber2;
  String? clubMemberYear1;
  String? clubMemberYear2;
  String? clubMemberImage1;
  String? clubMemberImage2;
  int? numberOfRegisteredStudent;

  @override
  void initState() {
    super.initState();
    _getMemberdetails2();
    _getMemberdetails1();
    countRegisteredStudents();
  }

  void _getMemberdetails1() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.clubMembersic1)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> clubMember =
            documentSnapshot.data()! as Map<String, dynamic>;
        setState(() {
          clubMemberName1 = clubMember['name'];
          clubMemberPhoneNumber1 = clubMember['phoneNumber'];
          clubMemberYear1 = clubMember['year'];
          clubMemberImage1 = clubMember['image_url'];
        });
      } else {
        // Handle the case when user data is not found
        setState(() {
          clubMemberName1 = 'User not found';
          clubMemberPhoneNumber1 = '';
          clubMemberYear1 = '';
          clubMemberImage1 = '';
        });
      }
    } catch (e) {
      // Handle any exceptions that occur during data fetching
      setState(() {
        clubMemberName1 = 'Error fetching data';
        clubMemberPhoneNumber1 = '';
        clubMemberYear1 = '';
        clubMemberImage1 = '';
      });
    }
  }

  void _getMemberdetails2() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.clubMembersic2)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> clubMember =
            documentSnapshot.data()! as Map<String, dynamic>;
        setState(() {
          clubMemberName2 = clubMember['name'];
          clubMemberPhoneNumber2 = clubMember['phoneNumber'];
          clubMemberYear2 = clubMember['year'];
          clubMemberImage2 = clubMember['image_url'];
        });
      } else {
        // Handle the case when user data is not found
        setState(() {
          clubMemberName2 = 'User not found';
          clubMemberPhoneNumber2 = '';
          clubMemberYear2 = '';
          clubMemberImage2 = '';
        });
      }
    } catch (e) {
      // Handle any exceptions that occur during data fetching
      setState(() {
        clubMemberName2 = 'Error fetching data';
        clubMemberPhoneNumber2 = '';
        clubMemberYear2 = '';
        clubMemberImage2 = '';
      });
    }
  }

  CollectionReference eventsRefrerence =
      FirebaseFirestore.instance.collection('events');

  void _registerForEvent() async {
    String currentUser = FirebaseAuth.instance.currentUser!.uid;
    String eventName = widget.title;

    try {
      // Check if the user is already registered for this event
      QuerySnapshot querySnapshot = await eventsRefrerence
          .doc(eventName)
          .collection('registered_students')
          .where('user_id', isEqualTo: currentUser)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are already registered for this event.'),
          ),
        );
      } else {
        // User is not already registered, proceed with registration
        await eventsRefrerence
            .doc(eventName)
            .collection('registered_events')
            .add({
          'user_id': currentUser,
          'timestamp': FieldValue.serverTimestamp(),
        });
        countRegisteredStudents();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
      }
    } catch (e) {
      print('Error registering for the event: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Registration failed. Please try again later.')),
      );
    }
  }

  void countRegisteredStudents() async {
    int? eventCount = await eventsRefrerence
        .doc(widget.title)
        .collection('registered_students')
        .get()
        .then((querySnapshot) => querySnapshot.size);
    setState(() {
      numberOfRegisteredStudent = eventCount ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
            //FilledButton for number of registered people
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: FilledButton.tonalIcon(
                    onPressed: () {},
                    label: Text(
                      '$numberOfRegisteredStudent',
                    ), // to be dynamic
                    icon: const Icon(Icons.group),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _registerForEvent();
                    },
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
                            ClipboardData(text: widget.eventCode));
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
                      subtitle: Text(widget.eventCode),
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
                          widget.eventStartDateTime.toDate(),
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
                          widget.eventStartDateTime.toDate(),
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
                          widget.eventFinishDateTime.toDate(),
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
                          widget.eventFinishDateTime.toDate(),
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
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 5),
            //   width: double.maxFinite,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     // color: Theme.of(context).colorScheme.secondaryContainer,
            //   ),
            //   child: Column(
            //     children: [
            //       ListTile(
            //         leading: CircleAvatar(
            //           radius: screenWidth * 0.065,
            //           backgroundImage: NetworkImage(
            //             '$clubMemberImage1',
            //           ),
            //         ),
            //         isThreeLine: true,
            //         title: Text(
            //           '$clubMemberName1',
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         subtitle: Text(
            //           'Year: $clubMemberYear1\nPhone Number: $clubMemberPhoneNumber1',
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         titleTextStyle: titleStyle,
            //       ),
            //       ListTile(
            //         leading: CircleAvatar(
            //           radius: screenWidth * 0.065,
            //           backgroundImage: NetworkImage(
            //             '$clubMemberImage2',
            //           ),
            //         ),
            //         isThreeLine: true,
            //         title: Text(
            //           '$clubMemberName2',
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         subtitle: Text(
            //           'Year: $clubMemberYear2 \nPhone Number: $clubMemberPhoneNumber2',
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         titleTextStyle: titleStyle,
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
