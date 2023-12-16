import 'dart:io';
import 'package:cliff/sub_sections/Events/screens/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cliff/widgets/event_image_picker.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});
  static const routeName = '/Create-event';
  @override
  State<CreateEventScreen> createState() => CreateEventScreenState();
}

class CreateEventScreenState extends State<CreateEventScreen> {
  final _form = GlobalKey<FormState>();
  File? _selectedImage;

  DateTime? _eventFinishDateTime;
  DateTime? _eventStartDateTime;
  Timestamp? _finishDateTime;
  Timestamp? _startDateTime;

  var _isSubmitting = false;
  var _eventName = '';
  var _eventCode = '';
  var _eventDescirption = '';
  var _eventVenue = '';
  var _clubMemberSic1 = '';
  var _clubMemberSic2 = '';
  var _club = '';
  var _isTeamEvent = false;
  int? _teamMembers;

  final _eventCodefocusNode = FocusNode();
  final _eventDescriptionfocusNode = FocusNode();
  final _eventVenueFocusNode = FocusNode();
  final _clubMemberSic1FocusNode = FocusNode();
  final _clubMemberSic2FocusNode = FocusNode();

  Future<bool> _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return false;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
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
      final currentUser = FirebaseAuth.instance.currentUser!.uid;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('event_poster')
          .child('$_eventName.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      FirebaseFirestore.instance.collection('events').doc(_eventName).set(
        {
          'currrentUser': currentUser,
          'image_url': imageUrl,
          'eventname': _eventName,
          'eventcode': _eventCode,
          'eventVenue': _eventVenue,
          'clubmembersic1': _clubMemberSic1,
          'clubmembersic2': _clubMemberSic2,
          'eventstartdatetime': _startDateTime,
          'eventfinishdatetime': _finishDateTime,
          'eventdescription': _eventDescirption,
          'registered_participants': [],
          'club': _club,
          'is_team_event': _isTeamEvent,
          'maximum_team_members': _teamMembers ?? 0,
        },
      );
      return true;
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(error.message ?? 'Authenication failed'),
        ),
      );
      setState(() {
        _isSubmitting = false;
      });
    }
    return false;
  }

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

    if (pickedDate != null && pickedDate != _eventStartDateTime) {
      // Combine the selected date with the existing time (if any)
      TimeOfDay? selectedTime =
          TimeOfDay.fromDateTime(_eventStartDateTime ?? DateTime.now());
      _eventStartDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      setState(() {});
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Combine the selected time with the existing date (if any)
      DateTime selectedDate = _eventStartDateTime ?? DateTime.now();
      _eventStartDateTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, pickedTime.hour, pickedTime.minute);
      setState(() {});
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

    if (pickedDate != null && pickedDate != _eventStartDateTime) {
      // Combine the selected date with the existing time (if any)
      TimeOfDay? selectedTime =
          TimeOfDay.fromDateTime(_eventFinishDateTime ?? DateTime.now());
      _eventFinishDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      setState(() {});
    }
  }

  Future<void> _selectFinishTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Combine the selected time with the existing date (if any)
      DateTime selectedDate = _eventFinishDateTime ?? DateTime.now();
      _eventFinishDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      setState(() {});
    }
  }

  @override
  void dispose() {
    _eventCodefocusNode.dispose();
    _eventDescriptionfocusNode.dispose();
    _eventVenueFocusNode.dispose();
    _clubMemberSic2FocusNode.dispose();
    _clubMemberSic1FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Events"),
        centerTitle: true,
      ),
      /* 
      event name,event code(it must be unique if many events are going on), event discription, event image,
      whatsapp linking will also be required, and a timer so that event can expire automatically,
      */
      body: SingleChildScrollView(
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
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Club',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  value: _club.isNotEmpty ? _club : null,
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Switch',
                      child: Text('Switch'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'SQC',
                      child: Text('SQC'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'CSS',
                      child: Text('CSS'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'YFS',
                      child: Text('YFS'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Silicon Green Club',
                      child: Text('Silicon Green Club'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Silicon Robitics Club',
                      child: Text('Silicon Robitics Club'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Silicon Circuit Club',
                      child: Text('Silicon Circuit Club'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Meta Academics Cell',
                      child: Text('Meta Academics Cell'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _club = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a club';
                    }
                    return null;
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
                    labelText: '1st member Sic',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  focusNode: _clubMemberSic1FocusNode,
                  textInputAction: TextInputAction.next,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus();
                  // },
                  validator: (value) {
                    // must be unique event code use firebase get command
                    if (value!.isEmpty) {
                      return 'Please enter first club member Sic';
                    } else if (value == _clubMemberSic1) {
                      return 'Sic of First and Second member cannot be same';
                    }
                    return null;
                  },

                  onSaved: (value) {
                    _clubMemberSic1 = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '2nd member Sic',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  focusNode: _clubMemberSic2FocusNode,
                  textInputAction: TextInputAction.done,
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus();
                  // },
                  validator: (value) {
                    // must be unique event code use firebase get command
                    if (value!.isEmpty) {
                      return 'Please enter second club member Sic';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _clubMemberSic2 = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(3.0), // Border radius
                  ),
                  child: SwitchListTile(
                    title: const Text(
                      'Is this a team event',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    value: _isTeamEvent,
                    onChanged: (value) {
                      // Update the state of the switch based on the new value.
                      setState(() {
                        _isTeamEvent = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (_isTeamEvent)
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Maximum team members',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    validator: (value) {
                      // must be unique event code use firebase get command
                      if (value!.isEmpty) {
                        return 'Please enter the maximum no. of team mates allowed';
                      }
                      if (int.parse(value) > 10 || int.parse(value) < 0) {
                        return 'Please enter a number between 0 and 10';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _teamMembers = int.parse(value!);
                    },
                  ),
                if (_isTeamEvent)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => _selectStartDate(context),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.event_available),
                          labelText: 'Start Date',
                          hintText: 'Select date',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: _eventStartDateTime != null
                              ? DateFormat('dd-MM-yyyy')
                                  .format(_eventStartDateTime!)
                              : '',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => _selectStartTime(context),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.timer_outlined),
                          labelText: 'Start time',
                          hintText: 'Select event start time',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: _eventStartDateTime != null
                              ? DateFormat('hh:mm:ss')
                                  .format(_eventStartDateTime!)
                              : '',
                        ),
                        onSaved: (value) {
                          _startDateTime =
                              Timestamp.fromDate(_eventStartDateTime!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => _selectFinishDate(context),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.event_busy),
                          labelText: 'End Date',
                          hintText: 'Select event end date',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: _eventFinishDateTime != null
                              ? DateFormat('dd-MM-yyyy')
                                  .format(_eventFinishDateTime!)
                              : '',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        onTap: () => _selectFinishTime(context),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.timer),
                          labelText: 'Finish time',
                          hintText: 'Select event finish time',
                          border: OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: _eventFinishDateTime != null
                              ? DateFormat('hh:mm:ss')
                                  .format(_eventFinishDateTime!)
                              : '',
                        ),
                        onSaved: (value) {
                          _finishDateTime =
                              Timestamp.fromDate(_eventFinishDateTime!);
                        },
                        // onSaved: (value) {
                        //   _eventFinishTime = value!;
                        // },
                      ),
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
                  maxLines: 15,
                  maxLength: 1000,
                  keyboardType: TextInputType.multiline,
                  focusNode: _eventDescriptionfocusNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter The event description.';
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
                        ? const Center(child: CircularProgressIndicator())
                        : Expanded(
                            child: FilledButton(
                              onPressed: () async {
                                await _submit()
                                    ? context.mounted
                                        ? {
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars(),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                  'Event Created, redirecting to ongoing events page',
                                                ),
                                              ),
                                            ),
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              EventsScreen.routeName,
                                            ),
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
                                            behavior: SnackBarBehavior.floating,
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
    );
  }
}
