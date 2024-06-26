import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddCompanyData extends StatefulWidget {
  const AddCompanyData({super.key});
  static const routeName = 'add-company-data';

  @override
  State<AddCompanyData> createState() => AddCompanyDataState();
}

class AddCompanyDataState extends State<AddCompanyData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add company data',
          style: TextStyle(fontFamily: 'IBMPlexMono'),
        ),
        centerTitle: true,
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
  ConsumerState<ConsumerStatefulWidget> createState() => _BuildFormState();
}

class _BuildFormState extends ConsumerState<BuildForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<bool> showInfoBottomSheet() async {
    Completer<bool> completer = Completer<bool>();

    showModalBottomSheet(
      constraints: BoxConstraints.loose(
        Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.4),
      ), // <= this is set to 3/4 of screen size.
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Entered Information',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IBMPlexMono'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Column with company name and company details descriptors
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Column with company name and company details descriptors
                      Text(
                        'Company Name:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'Allowed Branches:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'Arrival Date:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'Minimum CGPA:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'Maximum Backlogs:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'Stipend:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'CTC:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        'Bond:',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                    ],
                  ),

                  //Column with company name and company details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${companyNameController.text}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        '${selectedOptions.join(', ')}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${dateController.text}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        '${cgpaController.text}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        '${backlogsController.text}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        '${stipendController.text}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        '${ctcController.text}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                      Text(
                        '${bondController.text}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexMono',
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    onPressed: () {
                      // Save button pressed
                      completer.complete(true);
                      Navigator.pop(context);
                    },
                    child: Text('Save'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Cancel button pressed
                      completer.complete(false);
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    return completer.future;
  }

  Future<void> validateAndSaveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    bool savePressed = await showInfoBottomSheet();

    if (savePressed) {
      // Save data to the database or perform other actions
      _formKey.currentState!.save();
      await _submit();
      // Show a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Company data saved successfully\nEnter another company details or exit',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'IBMPlexMono', // font family
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2), // duration of the snackbar
        ), //
      );
      // reset fields
      companyNameController.clear();
      companyDetailsController.clear();
      jobDescriptionController.clear();
      vacanciesController.clear();
      cgpaController.clear();
      backlogsController.clear();
      stipendController.clear();
      ctcController.clear();
      bondController.clear();
      dateController.clear();
      selectedOptions.clear();
    }
    // If cancel button is pressed, do nothing or handle as needed
  }

  bool _submit() {
    try {
      FirebaseFirestore.instance
          .collection('companies')
          .doc('${companyNameController.text}')
          .set(
        {
          'companyName': companyNameController.text,
          'companyDetails': companyDetailsController.text,
          'jobDescription': jobDescriptionController.text,
          'vacancies': int.parse(vacanciesController.text),
          'allowedBranches': selectedOptions,
          'arrivalDate': dateController.text,
          'minimumCgpa': num.parse(cgpaController.text),
          'maximumBacklogs': int.parse(backlogsController.text),
          'stipend': num.parse(stipendController.text),
          'ctc': num.parse(ctcController.text),
          'bond': num.parse(bondController.text),
        },
        SetOptions(merge: true),
      );

      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  // Text editing controllers
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyDetailsController =
      TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController vacanciesController = TextEditingController();
  final TextEditingController cgpaController = TextEditingController();
  final TextEditingController backlogsController = TextEditingController();
  final TextEditingController stipendController = TextEditingController();
  final TextEditingController ctcController = TextEditingController();
  final TextEditingController bondController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  List<String> selectedOptions = []; // Store selected options here
  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'Company name',
              maxLines: 1,
              controller: companyNameController, // text editing controller
              decoration: InputDecoration(
                labelText: 'Company name',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Company name can't be empty";
                } else if (value.length < 3) {
                  return "Company name must be at least 3 characters long";
                } else if (value.length > 50) {
                  return "Company name can't be longer than 50 characters";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'Company details',
              maxLines: 5,
              maxLength: 1000,
              controller: companyDetailsController, //text editiing controller
              decoration: InputDecoration(
                labelText: 'Company details',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Company details can't be empty";
                } else if (value.length < 10) {
                  return "Company details must be at least 10 characters long";
                } else if (value.length > 1000) {
                  return "Company details can't be longer than 1000 characters";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'Job description',
              maxLines: 5,
              maxLength: 1000,
              controller: jobDescriptionController, //text editing controller
              decoration: InputDecoration(
                labelText: 'Job description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Job description can't be empty";
                } else if (value.length < 10) {
                  return "Job description must be at least 10 characters long";
                } else if (value.length > 1000) {
                  return "Job description can't be longer than 1000 characters";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),

            FormBuilderTextField(
              name: 'Vacancies',
              maxLines: 1,
              keyboardType: TextInputType.number,
              controller: vacanciesController, //text editing controller
              decoration: InputDecoration(
                labelText: 'Vacancies',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // onSaved: (newValue) {
              //   vacancies = int.parse(newValue!);
              // },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Company vacancies can't be empty";
                } else if (!isNumeric(value)) {
                  return "Please enter a valid number for vacancies";
                }
                return null;
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderCheckboxGroup(
              name: 'options',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              options: [
                FormBuilderFieldOption(value: 'CSE'),
                FormBuilderFieldOption(value: 'CEN'),
                FormBuilderFieldOption(value: 'CST'),
                FormBuilderFieldOption(value: 'ECE'),
                FormBuilderFieldOption(value: 'EEE'),
                FormBuilderFieldOption(value: 'MCA'),
                FormBuilderFieldOption(value: 'EIE'),
              ],
              onChanged: (List<dynamic>? values) {
                if (values != null) {
                  setState(() {
                    selectedOptions = values.cast<String>();
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Allowed Branches',
                alignLabelWithHint: true,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              validator: (List<dynamic>? values) {
                if (values == null || values.isEmpty) {
                  return "Please select at least one branch";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderDateTimePicker(
              name: 'companyDate',
              controller: dateController,
              inputType: InputType.date,
              format: DateFormat('dd-MMM-yyyy'),
              decoration: InputDecoration(
                labelText: 'Arrival date',
                alignLabelWithHint: true,
                suffixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (DateTime? selectedDate) {
                if (selectedDate == null) {
                  return "Please select an arrival date";
                }

                final now = DateTime.now();
                if (selectedDate.isBefore(now)) {
                  return "Arrival date cannot be in the past";
                }

                return null;
              },
            ),
            SizedBox(height: 10),
            // Eligibility Section
            Divider(),
            Text(
              "Eligibilty Criteria",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontFamily: "IBMPLexMono",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'cgpa',
              controller: cgpaController,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Minimum CGPA',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
              ], // just copied don't know what it does. review once
              validator: (value) {
                double cgpa = double.tryParse(value!) ?? -1.0;
                if (value.isEmpty) {
                  return "Minimum CGPA can't be empty";
                } else if (!isNumeric(value)) {
                  return "Please enter a valid CGPA";
                } else if (cgpa < 0 || cgpa > 10.0) {
                  return "Please enter a valid CGPA between 0 and 10.0";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: 'backlogs',
              controller: backlogsController,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Maximum Backlogs',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Maximum backlogs can't be empty";
                }

                int backlogs = int.tryParse(value) ??
                    -1; // Using -1 as a default value if parsing fails

                if (backlogs < 0) {
                  return "Please enter a valid number of backlogs (non-negative)";
                }

                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),

            // Compensation Section
            Text(
              "Compensation",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontFamily: "IBMPLexMono",
              ),
            ),
            FormBuilderTextField(
              name: 'stipend',
              controller: stipendController,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Stipend',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Stipend can't be empty";
                }

                double stipend = double.tryParse(value) ??
                    -1; // Using -1 as a default value if parsing fails

                if (stipend < 0) {
                  return "Please enter a valid stipend amount (non-negative)";
                }

                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
              ],
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: 'ctc',
              controller: ctcController,
              maxLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CTC (Cost to Company)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "CTC can't be empty";
                }

                double ctc = double.tryParse(value) ??
                    -1; // Using -1 as a default value if parsing fails

                if (ctc < 0) {
                  return "Please enter a valid CTC amount (non-negative)";
                }

                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
              ],
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: 'bond',
              controller: bondController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Bond (if any)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Bond duration can't be empty";
                }

                int bondDuration = int.tryParse(value) ??
                    -1; // Using -1 as a default value if parsing fails

                if (bondDuration < 0) {
                  return "Please enter a valid bond duration (non-negative)";
                }

                return null;
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      await validateAndSaveForm();
                    },
                    child: Text('Save'),
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
