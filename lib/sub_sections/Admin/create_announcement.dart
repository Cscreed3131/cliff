import 'package:cliff/sub_sections/Home/announcements_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateAnnouncement extends StatelessWidget {
  static const routeName = '/announcement';

  const CreateAnnouncement({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announce'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: BuildForm(),
      ),
    );
  }
}

class BuildForm extends StatefulWidget {
  const BuildForm({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  var announcement = '';
  var doesContainLink = false;
  var link = '';

  Future<bool> _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();

    DateTime now = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(now);
    try {
      FirebaseFirestore.instance.collection('announcements').doc().set({
        'added_by': FirebaseAuth.instance.currentUser!.uid,
        'message': announcement,
        'link': doesContainLink ? link : '',
        'date_and_time': timestamp,
      });
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'Take announcement input',
              maxLines: 10,
              maxLength: 5000,
              decoration: InputDecoration(
                labelText: 'Announcement',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a message for making an announcement';
                }
                if (value.split(RegExp(r'\s+')).length <= 15) {
                  return 'Please enter a message with more than 15 words';
                }
                return null;
              },
              onSaved: (newValue) {
                announcement = newValue!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderSwitch(
              name: 'Does the announcement contain a Link or not',
              title: const Text('Contains Link'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  doesContainLink = value!;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            if (doesContainLink)
              FormBuilderTextField(
                name: 'Take some Link',
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Link',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a link';
                  }

                  final RegExp urlPattern = RegExp(
                    r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$",
                    caseSensitive: false,
                  );

                  if (!urlPattern.hasMatch(value)) {
                    return 'Please enter a valid link';
                  }

                  return null; // Return null if the input is a valid link
                },
                onSaved: (value) {
                  link = value!;
                },
              ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      await _submit()
                          ? {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Uploading was successful'),
                                ),
                              ),
                              Navigator.of(context).pushReplacementNamed(
                                  AnnouncementScreen.routeName)
                            }
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Uploading was Unsuccessful'),
                              ),
                            );
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
