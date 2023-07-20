import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../widgets/user_image_picker.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});
  static const routeName = '/Create-event';

  @override
  State<CreateEventScreen> createState() => CreateEventScreenState();
}

class CreateEventScreenState extends State<CreateEventScreen> {
  final _form = GlobalKey<FormState>();
  File? _selectedImage;

  var _isSubmitting = false;
  var _eventName = '';
  var _eventCode = '';
  var _eventDescirption = '';

  final _eventCodefocusNode = FocusNode();
  final _eventDescriptionfocusNode = FocusNode();

  Future<bool> _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return false;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a event poster'),
        ),
      );
      return false;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isSubmitting = true;
      });
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('event_poster')
          .child('$_eventName.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      FirebaseFirestore.instance
          .collection('OngoingEvents')
          .doc(_eventName)
          .set(
        {
          'image_url': imageUrl,
          'eventmame': _eventName,
          'eventcode': _eventCode,
          'eventdescription': _eventDescirption,
        },
      );
      return true;
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authenication failed'),
        ),
      );
      setState(() {
        _isSubmitting = false;
      });
    }
    return false;
  }

  @override
  void dispose() {
    _eventCodefocusNode.dispose();
    _eventDescriptionfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Events"),
      ),
      /* 
      event name,event code(it must be unique if many events are going on), event discription, event image,
      whatsapp linking will also be required, and a timer so that event can expire automatically,  */
      body: Container(
        alignment: Alignment.topCenter,
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  UserImagePicker(
                    onPickImage: (pickedImage) {
                      _selectedImage = pickedImage;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Event Name',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter The event name.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _eventName = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Event Code',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    focusNode: _eventCodefocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus();
                    },
                    validator: (value) {
                      // must be unique event code use firebase get command
                      if (value!.isEmpty) {
                        return 'Please enter The event Code.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _eventCode = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Event Description',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                    focusNode: _eventDescriptionfocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter The event name.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _eventDescirption = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      _isSubmitting
                          ? const CircularProgressIndicator()
                          : Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _submit()
                                      ? context.mounted
                                          ? {
                                              ScaffoldMessenger.of(context)
                                                  .clearSnackBars(),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Event Created,redirecting to ongoing events page'),
                                                ),
                                              ),
                                              // Navigator.of(context).pushNamed();
                                            }
                                          : print('context not mounted')
                                      // add a exceptiion class so that the get exception and we dont have to print this in the terminal
                                      : {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars(),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Event Creation was unsuccessful, Try again.'),
                                            ),
                                          ),
                                        };
                                  _isSubmitting = false;
                                },
                                child: const Text(
                                  'Submit',
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
