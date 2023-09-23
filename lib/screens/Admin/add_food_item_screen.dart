import 'dart:io';

import 'package:cliff/provider/food_provider.dart';
import 'package:cliff/screens/food/food_screen.dart';
import 'package:cliff/widgets/event_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddFoodItems extends StatelessWidget {
  const AddFoodItems({super.key});
  static const routeName = '/add-food-item';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Food Item',
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
  ConsumerState<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends ConsumerState<BuildForm> {
  List<String> categories = [
    "All",
    "Breakfast",
    "North Indian",
    "South Indian",
    "Beverages",
    "Desserts",
  ];

  final _formKey = GlobalKey<FormBuilderState>();

  File? _selectedImage;
  String name = '';
  String description = '';
  double price = 0;
  String category = '';

  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Future<bool> _submit(int id) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    _formKey.currentState!.save();
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Please select a food item image'),
        ),
      );
      return false;
    }
    DateTime now = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(now);
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('food_items').child('$name.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();
      FirebaseFirestore.instance.collection('food_items').doc().set({
        'added_by': FirebaseAuth.instance.currentUser!.uid,
        'date_and_time': timestamp,
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'imageUrl': imageUrl,
        'available': true,
        'id': id + 1,
      });
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? id;
    ref.watch(foodItemStreamProvider).when(
        data: (data) {
          id = data.length;
        },
        error: (error, stackTrace) {
          print(error);
          print(stackTrace);
          id = null;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Can't set id of the food item.")));
        },
        loading: () {});
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            EventImagePicker(
              onPickImage: (pickedImage) {
                _selectedImage = pickedImage;
              },
            ),
            FormBuilderTextField(
              name: 'item name',
              decoration: InputDecoration(
                labelText: 'Name',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                if (value.split(RegExp(r'\s+')).length >= 3) {
                  return 'Please enter a name in less than 3 words';
                }
                if (value.isNotEmpty) {
                  RegExp specialCharacters = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
                  if (specialCharacters.hasMatch(value)) {
                    return 'Name cannot contain special characters';
                  }
                }
                return null;
              },
              onSaved: (newValue) {
                name = newValue!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'item description',
              decoration: InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              focusNode: _descriptionFocusNode,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description of item';
                }
                if (value.split(RegExp(r'\s+')).length <= 5) {
                  return 'Please enter a description which has more than 5 words ';
                }

                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (newValue) {
                description = newValue!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            FormBuilderTextField(
              name: 'item price',
              decoration: InputDecoration(
                labelText: 'Price',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              focusNode: _priceFocusNode,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                if (double.tryParse(value) == null ||
                    double.parse(value) <= 0) {
                  return 'Please enter a valid positive number';
                }
                if (value.isNotEmpty) {
                  RegExp specialCharacters = RegExp(r'[!@#\$%^&*()?":{}|<>]');
                  if (specialCharacters.hasMatch(value)) {
                    return 'Description cannot contain special characters';
                  }
                }
                return null;
              },
              onSaved: (newValue) {
                price = double.tryParse(newValue!)!;
              },
            ),
            // const SizedBox(height: 10,),
            FormBuilderChoiceChip(
              name: 'chip_options',
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Choose category:',
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              spacing: 10,
              options: const [
                FormBuilderChipOption(
                  value: 'Breakfast',
                  child: Text('Breakfast'),
                ),
                FormBuilderChipOption(
                  value: 'North Indian',
                  child: Text('North Indian'),
                ),
                FormBuilderChipOption(
                  value: 'South Indian',
                  child: Text('South Indian'),
                ),
                FormBuilderChipOption(
                  value: 'Beverages',
                  child: Text('Beverages'),
                ),
                FormBuilderChipOption(
                  value: 'Desserts',
                  child: Text('Desserts'),
                ),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
              onSaved: (newValue) {
                category = newValue!;
                print(category);
              },
              onReset: () {},
            ),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      await _submit(id!)
                          ? {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Uploading was successful'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              ),
                              Navigator.of(context)
                                  .pushReplacementNamed(FoodScreen.routeName),
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
