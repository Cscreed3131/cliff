import 'package:cliff/provider/user_data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// add as much logic as needed to make this perfect.

class AddClassTimeTable extends StatelessWidget {
  const AddClassTimeTable({super.key});
  static const routeName = '/add-timetable';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
      ),
      body: const SingleChildScrollView(
        child: BuildForm(),
      ),
    );
  }
}

class BuildForm extends ConsumerStatefulWidget {
  const BuildForm({super.key});

  @override
  ConsumerState<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends ConsumerState<BuildForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  String classNumber = '';
  String selectedColor = '';
  String className = '';
  String classLocation = '';
  String day = '';
  DateTime? startDateTime;
  DateTime? endDateTime;
  DateTime? repeatTill;
  bool flag = false;

  bool validateAndSaveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    return true;
  }

  Future<bool> _submit() async {
    try {
      String? branchName;
      String? year;
      String section = 'j'.toUpperCase();
      final crDetails = ref.watch(realTimeUserDataProvider);
      crDetails.whenData((value) {
        branchName = value.branch;
        year = value.year;
      });

      String classDuration =
          '${DateFormat('hh:mm a').format(startDateTime!)} - ${DateFormat('hh:mm a').format(endDateTime!)}';
      FirebaseFirestore.instance
          .collection('timetables')
          .doc(branchName!)
          .collection('years')
          .doc(year)
          .collection('sections')
          .doc(section)
          .collection('timetable')
          .doc('classes')
          .set(
        {
          'classes': {
            '$day-$classNumber': {
              'className': className,
              'classId': '$day-$classNumber',
              'classLocation': classLocation,
              'day': day,
              'classDuration': classDuration,
              'startDateTime': Timestamp.fromDate(startDateTime!),
              'endDateTime': Timestamp.fromDate(endDateTime!),
              'repeatTill': Timestamp.fromDate(repeatTill!),
              'color': selectedColor,
            }
          }
        },
        SetOptions(
          merge: true,
        ),
      );

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
            FormBuilderDropdown(
              name: 'Drop Down',
              decoration: InputDecoration(
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                labelText: 'Class No',
              ),
              alignment: Alignment.bottomCenter,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Class number can't be empty";
                }
                return null;
              },
              onSaved: (newValue) {
                classNumber = newValue!;
              },
              items: const [
                DropdownMenuItem(
                  value: 'Class 1',
                  child: Text('Class 1'),
                ),
                DropdownMenuItem(
                  value: 'Class 2',
                  child: Text('Class 2'),
                ),
                DropdownMenuItem(
                  value: 'Class 3',
                  child: Text('Class 3'),
                ),
                DropdownMenuItem(
                  value: 'Class 4',
                  child: Text('Class 4'),
                ),
                DropdownMenuItem(
                  value: 'Class 5',
                  child: Text('Class 5'),
                ),
                DropdownMenuItem(
                  value: 'Class 6',
                  child: Text('Class 6'),
                ),
                DropdownMenuItem(
                  value: 'Class 7',
                  child: Text('Class 7'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'Event name',
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Class name',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (newValue) {
                className = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Class name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'class location',
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Class location',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Class Location';
                }
                return null;
              },
              onSaved: (newValue) {
                classLocation = newValue!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderDateTimePicker(
              name: 'get datetime',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // confirmText: 'hey',
              keyboardType: TextInputType.none,
              format: DateFormat("EEE MMM dd, yyyy hh:mm a"),
              decoration: InputDecoration(
                labelText: 'Start time',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please enter an end time';
                }
                return null;
              },
              onSaved: (newValue) {
                startDateTime = newValue;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderDateTimePicker(
              name: 'get datetime',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              format: DateFormat("EEE MMM dd, yyyy hh:mm a"),
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                labelText: 'End time',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please enter a end time';
                }
                if (value == startDateTime) {
                  return "Start and end Time can't be same";
                }
                return null;
              },
              onSaved: (newValue) {
                endDateTime = newValue;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            FormBuilderRadioGroup(
              name: 'day',
              initialValue: 'Monday',
              orientation: OptionsOrientation.wrap,
              options: const [
                FormBuilderFieldOption(
                  value: 'Monday',
                  child: Text('Monday'),
                ),
                FormBuilderFieldOption(
                  value: 'Tuesday',
                  child: Text('Tuesday'),
                ),
                FormBuilderFieldOption(
                  value: 'Wednessday',
                  child: Text('Wednessday'),
                ),
                FormBuilderFieldOption(
                  value: 'Thursday',
                  child: Text('Thursday'),
                ),
                FormBuilderFieldOption(
                  value: 'Friday',
                  child: Text('Friday'),
                ),
                FormBuilderFieldOption(
                  value: 'Saturday',
                  child: Text('Saturday'),
                ),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Day:',
              ),
              onSaved: (newValue) {
                day = newValue!;
              },
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            FormBuilderDateTimePicker(
              name: 'get datetime',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              format: DateFormat("EEE MMM dd, yyyy hh:mm a"),
              decoration: InputDecoration(
                labelText: 'Repeat till',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onSaved: (newValue) {
                repeatTill = newValue;
              },
            ),
            FormBuilderChoiceChip(
              name: 'chip_options',
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Choose color:',
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              shape: const StadiumBorder(),
              spacing: 10,
              initialValue: '0xff22a699',
              onSaved: (newValue) {
                selectedColor = newValue!;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Color cannot be empty';
                }
                return null;
              },
              options: const [
                FormBuilderChipOption(
                  value: '0xff22a699',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xff22a699),
                  ),
                  child: Text(
                    'Teal',
                    style: TextStyle(
                      color: Color(0xff22a699),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xffffe135',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xffffe135),
                  ),
                  child: Text(
                    'Banana',
                    style: TextStyle(
                      color: Color(0xffffe135),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xfff28500',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xfff28500),
                  ),
                  child: Text(
                    'Tangerine',
                    style: TextStyle(
                      color: Color(0xfff28500),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xffFF6347',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xffFF6347),
                  ),
                  child: Text(
                    'Tomato',
                    style: TextStyle(
                      color: Color(0xffFF6347),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xff879f84',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xff879f84),
                  ),
                  child: Text(
                    'Basil',
                    style: TextStyle(
                      color: Color(0xff879f84),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xffB2AC88',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xffB2AC88),
                  ),
                  child: Text(
                    'Sage',
                    style: TextStyle(
                      color: Color(0xffB2AC88),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xffFFE5B4',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xffFFE5B4),
                  ),
                  child: Text(
                    'Peach',
                    style: TextStyle(
                      color: Color(0xffFFE5B4),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xff004958',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xff004958),
                  ),
                  child: Text(
                    'Peacock',
                    style: TextStyle(
                      color: Color(0xff004958),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xff4f86f7',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xff4f86f7),
                  ),
                  child: Text(
                    'Blueberry',
                    style: TextStyle(
                      color: Color(0xff4f86f7),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xffE6E6FA',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xffE6E6FA),
                  ),
                  child: Text(
                    'Lavendar',
                    style: TextStyle(
                      color: Color(0xffE6E6FA),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xff6f2da8',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xff6f2da8),
                  ),
                  child: Text(
                    'Grape',
                    style: TextStyle(
                      color: Color(0xff6f2da8),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xfffc8eac',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xfffc8eac),
                  ),
                  child: Text(
                    'Flamingo',
                    style: TextStyle(
                      color: Color(0xfffc8eac),
                    ),
                  ),
                ),
                FormBuilderChipOption(
                  value: '0xff383428',
                  avatar: CircleAvatar(
                    backgroundColor: Color(0xff383428),
                  ),
                  child: Text(
                    'Graphite',
                    style: TextStyle(
                      color: Color(0xff383428),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline_sharp),
              onPressed: () async {
                validateAndSaveForm()
                    ? showDialog(
                        context: context,
                        builder: (context) {
                          final dateFormat = DateFormat('MMM EEE hh:mm a');
                          String start = dateFormat.format(startDateTime!);
                          String end = dateFormat.format(endDateTime!);
                          String repeat = dateFormat.format(repeatTill!);
                          return AlertDialog(
                            title: const Text('Alert'),
                            content: Text(
                              "Number: $classNumber\nName: $className\nLocation: $classLocation\nDay: $day\nStart: $start\nEnd: $end\nRepeat: $repeat",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await _submit()
                                      ? {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Uploading was successful'),
                                            ),
                                          ),
                                        }
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Uploading was Unsuccessful'),
                                          ),
                                        );
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('OK'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      )
                    : {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please verify once again before adding',
                            ),
                          ),
                        ),
                      };
              },
              label: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
