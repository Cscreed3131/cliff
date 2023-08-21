import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetTeamDetails extends ConsumerStatefulWidget {
  final String selectedMembersCount;
  final String eventId;
  final String currentUserSic;
  const GetTeamDetails({
    Key? key,
    required this.eventId,
    required this.selectedMembersCount,
    required this.currentUserSic,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GetTeamDetailsState();
}

class _GetTeamDetailsState extends ConsumerState<GetTeamDetails> {
  final _form = GlobalKey<FormState>();

  String teamName = '';
  String teamIdea = '';
  String teamIdeaDescription = '';
  List<String>? studentIds = [];

  Future<bool> _validateSic(List<String> sic, BuildContext context) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _form.currentState!.save();

    try {
      bool flag = true;

      for (int i = 0; i < sic.length; i++) {
        final doc = FirebaseFirestore.instance.collection('users').doc(sic[i]);

        final docSnapshot = await doc.get();

        if (!docSnapshot.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User does not exist for SIC: ${sic[i]}'),
              duration: const Duration(seconds: 2),
            ),
          );
          flag = false;
          break; // Break the loop if a user doesn't exist
        }
      }

      return flag;
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> _submit() async {
    try {
      // Fetch the existing registeredTeams data
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('events')
          .doc(widget.eventId)
          .get();
      Map<String, dynamic> eventData = documentSnapshot.data() ?? {};

      if (eventData.containsKey('registered_teams')) {
        Map<String, dynamic> registeredTeams = eventData['registered_teams'];
        if (registeredTeams.containsKey(teamName)) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Your Team is registered'),
              duration: Duration(milliseconds: 600),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return;
        } else {
          registeredTeams[teamName] = {
            'idea': teamIdea,
            'idea_description': teamIdeaDescription,
            'team_members': studentIds,
          };
          for (int i = 0; i < studentIds!.length; i++) {
            try {
              DocumentReference userRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(studentIds![i]);
              userRef.update({
                'events_registered': FieldValue.arrayUnion([widget.eventId]),
              });
            } on FirebaseException catch (e) {
              print(e);
            }
          }
          await FirebaseFirestore.instance
              .collection('events')
              .doc(widget.eventId)
              .update({
            'registered_teams': registeredTeams,
            'registered_participants': FieldValue.arrayUnion(studentIds!)
          });
        }
      } else {
        for (int i = 0; i < studentIds!.length; i++) {
          try {
            DocumentReference userRef = FirebaseFirestore.instance
                .collection('users')
                .doc(studentIds![i]);
            userRef.update({
              'events_registered': FieldValue.arrayUnion([widget.eventId]),
            });
          } on FirebaseException catch (e) {
            print(e);
          }
        }
        // Initialize cart and add the first item
        await FirebaseFirestore.instance
            .collection('events')
            .doc(widget.eventId)
            .set({
          'registered_teams': {
            teamName: {
              'idea': teamIdea,
              'idea_description': teamIdeaDescription,
              'team_members': studentIds,
            }
          },
        }, SetOptions(merge: true));
        await FirebaseFirestore.instance
            .collection('events')
            .doc(widget.eventId)
            .update({
          'registered_participants': FieldValue.arrayUnion(studentIds!)
        });
      }
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(error.message ?? 'Authenication failed'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    studentIds =
        List.generate(int.parse(widget.selectedMembersCount), (index) => '');
    studentIds![0] = widget.currentUserSic;
  }

  final memberConfirmationProvider =
      FutureProvider.family<bool, String>((ref, sic) async {
    try {
      final documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(sic).get();

      return documentSnapshot.exists;
    } catch (e) {
      // Handle exceptions if needed
      return false; // Return false if an exception occurs
    }
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Team Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a team name';
                    }
                    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return 'Team name should not contain special characters';
                    }
                    List<String> words = value.trim().split(' ');
                    if (words.length > 2) {
                      return 'Team name should not exceed 2 words';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    teamName = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Team Idea',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a team idea';
                    }

                    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
                      return 'Team idea should not contain special characters';
                    }

                    List<String> words = value.trim().split(' ');
                    if (words.length > 10) {
                      return 'Team idea should not exceed 10 words';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    teamIdea = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // Add some spacing
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: studentIds!.length - 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Student Sic ${index + 1}',
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a student ID';
                            }
                            if (value.length != 8) {
                              return 'Please enter a valid Sic';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            studentIds![index + 1] = value!;
                          },
                        ),
                        const SizedBox(
                            height: 10.0), // Adjust the height as needed
                      ],
                    );
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Team Idea Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 10,
                  maxLength: 500,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a team idea description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    teamIdeaDescription = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _validateSic(studentIds!, context)
              ? {
                  await _submit(),
                  Navigator.of(context).pop(),
                }
              : {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please review the form once again before submitting ",
                      ),
                    ),
                  ),
                };
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
