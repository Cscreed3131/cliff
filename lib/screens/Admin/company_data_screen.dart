import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
        title: Text('Add company data',
            style: TextStyle(fontFamily: 'IBMPlexMono')),
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
  final TextEditingController dateController =
      TextEditingController(); // Controller for date

  String companyName = '';
  String companyDetails = '';
  int vacancies = 0;
  List<String> selectedOptions = []; // Store selected options here
  List<String> selectedSkills = [];
  List<String> availableSkills = [
    'Java',
    'Python',
    'C++',
    'JavaScript',
    'Flutter',
    'Dart',
    'HTML',
    'CSS'
  ];

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
              decoration: InputDecoration(
                labelText: 'Company name',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (newValue) {
                companyName = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Company name can't be empty";
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
              decoration: InputDecoration(
                labelText: 'Company details',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (newValue) {
                companyDetails = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Company details can't be empty";
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
              decoration: InputDecoration(
                labelText: 'Job description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (newValue) {
                companyDetails = newValue!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Company details can't be empty";
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
              decoration: InputDecoration(
                labelText: 'Vacancies',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (newValue) {
                vacancies = int.parse(newValue!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Company vacancies can't be empty";
                }
                return null;
              },
            ),
            FormBuilderCheckboxGroup(
              name: 'options',
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
                labelText: 'Select Options',
                alignLabelWithHint: true,
                border: InputBorder.none,
              ),
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
            ),
            SizedBox(height: 10),
            // Eligibility Section
            Divider(),
            Text(
              "Eligibilty Criteria",
              style: TextStyle(
                fontSize: 30,
                fontFamily: "GarogierRegular",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'cgpa',
              // controller: cgpaController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Minimum CGPA',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: 'backlogs',
              // controller: backlogsController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Maximum Backlogs',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            // FormBuilderTextField(
            //   name: 'skills',
            //   // controller: skillsController,
            //   maxLines: 3,
            //   decoration: InputDecoration(
            //     labelText: 'Required Skills',
            //     alignLabelWithHint: true,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
            // FormBuilderCheckboxGroup(
            //   name: 'skills',
            //   options: availableSkills
            //       .map((skill) => FormBuilderFieldOption(value: skill))
            //       .toList(),
            //   onChanged: (List<dynamic>? values) {
            //     if (values != null) {
            //       setState(() {
            //         selectedOptions = values.cast<String>();
            //       });
            //     }
            //   },
            //   decoration: InputDecoration(
            //     labelText: 'Required Skills',
            //     alignLabelWithHint: true,
            //   ),
            // ),
            FormBuilderDropdown(
              name: 'selectedSkill',
              // hint: Text('Select a Skill'),
              decoration: InputDecoration(
                labelText: 'Add Skills',
                alignLabelWithHint: true,
              ),
              // allowClear: true,

              items: availableSkills
                  .map((skill) => DropdownMenuItem(
                        value: skill,
                        child: Text(skill),
                      ))
                  .toList(),
              onChanged: (dynamic value) {
                setState(() {
                  if (value != null && value is String) {
                    selectedSkills.add(value);
                    // selectedSkill = null; // Reset dropdown selection
                  }
                });
              },
            ),

            SizedBox(height: 10),

            // Display selected skills
            if (selectedSkills.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected Skills:'),
                  SizedBox(height: 5),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedSkills.length,
                    itemBuilder: (context, index) {
                      return Text('- ${selectedSkills[index]}');
                    },
                  ),
                ],
              ),
            SizedBox(
              height: 10,
            ),
            Divider(),

            // Compensation Section
            Text(
              "Compensation",
              style: TextStyle(
                fontSize: 30,
                fontFamily: "GarogierRegular",
              ),
            ),
            FormBuilderTextField(
              name: 'stipend',
              // controller: stipendController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Stipend',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: 'ctc',
              // controller: ctcController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CTC (Cost to Company)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: 'bond',
              // controller: bondController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Bond (if any)',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  // Perform save operation with the form data
                  // You can access the form data using the controller values
                  // For example: companyNameController.text, eventDateController.text, etc.
                  // Add your logic to save the data
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
