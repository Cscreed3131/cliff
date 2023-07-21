import 'dart:io';

import 'package:cliff/widgets/event_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});
  static const routeName = '/Create-event';

  @override
  State<CreateEventScreen> createState() => CreateEventScreenState();
}

class CreateEventScreenState extends State<CreateEventScreen> {
  final _form = GlobalKey<FormState>();
  File? _selectedImage;

  TimeOfDay? _eventStartTime;
  TimeOfDay? _eventFinishTime;
  DateTime? _eventStartDate;
  DateTime? _eventFinishDate;

  var _isSubmitting = false;
  var _eventName = '';
  var _eventCode = '';
  var _eventDescirption = '';
  var _eventVenue = '';
  var _registeredStudent = '';
  var _eventSuperviserSic = '';
  var _est;
  var _eft;
  var _esd;
  var _efd;

  //this should probally contain a phone number of the superviser for doubts and queries

  final _eventCodefocusNode = FocusNode();
  final _eventDescriptionfocusNode = FocusNode();
  final _eventVenueFocusNode = FocusNode();
  final _eventStartTimeFocusNode = FocusNode();
  final _eventFinishTimeFocusNode = FocusNode();
  final _eventStartDateFocusNode = FocusNode();
  final _eventFinshDateFocusNode = FocusNode();
  final _eventSuperviserSicFocusNode = FocusNode();

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
          'eventVenue': _eventVenue,
          'supervisorsic': _eventSuperviserSic,
          'eventstarttime': _eventStartTime,
          'eventendtime': _eventName,
          'eventstartdate': _eventStartDate,
          'eventfinshdate': _eventFinishDate,
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

  // DateTime? selectedDate;
  // TimeOfDay? selectedTime;

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _eventStartDate) {
      setState(() {
        _eventStartDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _eventStartTime) {
      setState(() {
        _eventStartTime = pickedTime;
      });
    }
  }

  Future<void> _selectFinishDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _eventFinishDate) {
      setState(() {
        _eventFinishDate = pickedDate;
      });
    }
  }

  Future<void> _selectFinishTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _eventFinishTime) {
      setState(() {
        _eventFinishTime = pickedTime;
      });
    }
  }

  @override
  void dispose() {
    _eventCodefocusNode.dispose();
    _eventDescriptionfocusNode.dispose();
    _eventVenueFocusNode.dispose();
    _eventStartTimeFocusNode.dispose();
    _eventFinishTimeFocusNode.dispose();
    _eventStartDateFocusNode.dispose();
    _eventFinshDateFocusNode.dispose();
    _eventSuperviserSicFocusNode.dispose();
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
                  EventImagePicker(
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
                      labelText: 'Event Venue',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    focusNode: _eventVenueFocusNode,
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
                      _eventVenue = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Supervisor Sic',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    focusNode: _eventSuperviserSicFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus();
                    },
                    validator: (value) {
                      // must be unique event code use firebase get command
                      if (value!.isEmpty) {
                        return 'Please enter The supervisor Sic';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _eventSuperviserSic = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      TextFormField(
                        readOnly: true,
                        onTap: () => _selectStartDate(context),
                        decoration: const InputDecoration(
                          labelText: 'Start Date',
                          hintText: 'Select date',
                          border: OutlineInputBorder(),
                          constraints: BoxConstraints(
                            maxWidth: 190,
                          ),
                        ),
                        controller: TextEditingController(
                          text: _eventStartDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(_eventStartDate!)
                              : '',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () => _selectStartTime(context),
                        decoration: const InputDecoration(
                          labelText: 'Start time',
                          hintText: 'Select event start time',
                          border: OutlineInputBorder(),
                          constraints: BoxConstraints(
                            maxWidth: 190,
                          ),
                        ),
                        controller: TextEditingController(
                          text: _eventStartTime != null
                              ? _eventStartTime!.format(context)
                              : '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      TextFormField(
                        readOnly: true,
                        onTap: () => _selectFinishDate(context),
                        decoration: const InputDecoration(
                          labelText: 'End Date',
                          hintText: 'Select event end date',
                          border: OutlineInputBorder(),
                          constraints: BoxConstraints(
                            maxWidth: 190,
                          ),
                        ),
                        controller: TextEditingController(
                          text: _eventFinishDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(_eventFinishDate!)
                              : '',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextFormField(
                        readOnly: true,
                        onTap: () => _selectFinishTime(context),
                        decoration: const InputDecoration(
                          labelText: 'Finish time',
                          hintText: 'Select event finish time',
                          border: OutlineInputBorder(),
                          constraints: BoxConstraints(
                            maxWidth: 190,
                          ),
                        ),
                        controller: TextEditingController(
                          text: _eventFinishTime != null
                              ? _eventFinishTime!.format(context)
                              : '',
                        ),
                        // onSaved: (value) {
                        //   _eventFinishTime = value!;
                        // },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    maxLines: 10,
                    maxLength: 350,
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
                    height: 10,
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
                                          : print(
                                              'context not mounted') // this should give a alert dialog box;
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
