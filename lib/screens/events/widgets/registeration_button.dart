import 'package:cliff/models/event.dart';
import 'package:cliff/provider/event_details_provider.dart';
import 'package:cliff/provider/user_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterationButton extends ConsumerWidget {
  final String eventId;
  const RegisterationButton({
    super.key,
    required this.eventId,
  });

  List<dynamic> getParticipantsList(List<Event> data, String eventId) {
    List<dynamic> participantsList = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].eventId == eventId) {
        participantsList = data[i].registeredParticipants;
        break;
      }
    }
    return participantsList;
  }

  bool checkRegistered(List participants, String sic) {
    if (participants.contains(sic)) {
      return true;
    }
    return false;
  }

  void registerForEvent(BuildContext context, List participants, String eventId,
      String currentUserSic) {
    try {
      // Reference to the event document
      DocumentReference eventRef =
          FirebaseFirestore.instance.collection('events').doc(eventId);
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(currentUserSic);

      // Add the current user's SIC to the registeredParticipants array
      userRef.update({
        'events_registered': FieldValue.arrayUnion([eventId])
      });
      eventRef.update({
        'registered_participants': FieldValue.arrayUnion([currentUserSic]),
      }).then((_) {
        checkRegistered(participants, currentUserSic);
      }).catchError((error) {
        print("Error registering for event: $error");
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Registeration was NOT SUCCESSFULL!!!')));
      });
    } catch (e) {
      print("Exception during registration: $e");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsDetailsProvider = ref.watch(eventDetailsStreamProvider);
    final currentUserSic = ref.watch(realTimeUserDataProvider).value!.sic;
    print(eventId);
    return eventsDetailsProvider.when(data: (data) {
      List participants = getParticipantsList(data, eventId);
      bool isRegistered = checkRegistered(participants, currentUserSic);
      return !isRegistered
          ? FilledButton.icon(
              onPressed: () {
                try {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Alert',
                        ),
                        content: const Text(
                          'Are you sure you want to Register for this event. Once you register you wont be able to unregister.',
                        ),
                        actions: [
                          TextButton(
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              registerForEvent(context, participants, eventId,
                                  currentUserSic);
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } on Exception catch (_) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Registration was not successful"),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Register'),
            )
          : OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('You are already registered for the event'),
                  ),
                );
              },
              icon: const Icon(Icons.done),
              label: const Text('Registered'),
            );
    }, error: (error, stackTrace) {
      print(error);
      print(stackTrace);
      return const Text('Error');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
