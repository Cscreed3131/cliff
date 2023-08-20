import 'package:cliff/models/event.dart';
import 'package:cliff/provider/event_details_provider.dart';
import 'package:cliff/provider/user_data_provider.dart';
import 'package:cliff/screens/Events/get_team_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class RegisterationButton extends ConsumerStatefulWidget {
  const RegisterationButton({
    Key? key,
    required this.eventId,
  }) : super(key: key);

  final String eventId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterationButtonState();
}

class _RegisterationButtonState extends ConsumerState<RegisterationButton> {
  String selectedMembers = '1'; // Move this here

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

  bool checkTeamEvent(List<Event> data, String eventId) {
    bool isTeamEvent = false;
    for (int i = 0; i < data.length; i++) {
      if (data[i].eventId == eventId) {
        isTeamEvent = data[i].isTeamEvent;
        break;
      }
    }
    return isTeamEvent;
  }

  int getMaxMembers(List<Event> data, String eventId) {
    int maxMembers = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i].eventId == eventId) {
        maxMembers = data[i].maxParticipants;
        break;
      }
    }
    return maxMembers;
  }

  @override
  Widget build(BuildContext context) {
    final eventsDetailsProvider = ref.watch(eventDetailsStreamProvider);
    final currentUserSic = ref.watch(realTimeUserDataProvider).value!.sic;

    return eventsDetailsProvider.when(
      data: (data) {
        List participants = getParticipantsList(data, widget.eventId);
        bool isRegistered = checkRegistered(participants, currentUserSic);
        bool isTeamEvent = checkTeamEvent(data, widget.eventId);
        int maxMembersAllowed = getMaxMembers(data, widget.eventId);

        return !isRegistered
            ? FilledButton.icon(
                onPressed: () {
                  try {
                    !isTeamEvent
                        ? showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Alert'),
                                content: const Text(
                                  'Are you sure you want to Register for this event. Once you register you wont be able to unregister.',
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      registerForEvent(context, participants,
                                          widget.eventId, currentUserSic);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          )
                        : showDialog(
                            context: context,
                            builder: (context) {
                              List<DropdownMenuItem<String>> dropdownItems = [];
                              for (int i = 1; i <= maxMembersAllowed; i++) {
                                dropdownItems.add(
                                  DropdownMenuItem<String>(
                                    value: i.toString(),
                                    child: Text(i.toString()),
                                  ),
                                );
                              }

                              return AlertDialog(
                                title: const Text('This is a team event'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    // const Text('Please select your team size:'),
                                    Form(
                                      key: GlobalKey<FormState>(),
                                      child: Column(
                                        children: <Widget>[
                                          DropdownButtonFormField<String>(
                                            value: selectedMembers,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedMembers = newValue!;
                                              });
                                            },
                                            items: dropdownItems,
                                            decoration: const InputDecoration(
                                              labelText:
                                                  'Select Max Number of Members',
                                            ),
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     // Use the selectedMaxMembers value as needed.
                                          //     print(
                                          //         'Selected Max Members: $selectedMembers');
                                          //   },
                                          //   child: Text('Submit'),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      // Here, you can use the selectedTeamSize variable as needed.
                                      Navigator.of(context)
                                          .pop(); // Close the dialog.
                                      Navigator.of(context)
                                          .push(PageAnimationTransition(
                                        page: GetTeamDetails(
                                          selectedMembersCount: selectedMembers,
                                          eventId: widget.eventId,
                                          currentUserSic: currentUserSic,
                                        ),
                                        pageAnimationType:
                                            RightToLeftFadedTransition(),
                                      ));
                                    },
                                    child: const Text('OK'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog.
                                    },
                                    child: const Text('Cancel'),
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
      },
      error: (error, stackTrace) {
        print(error);
        print(stackTrace);
        return const Text('Error');
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
