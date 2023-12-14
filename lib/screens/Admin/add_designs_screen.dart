import 'dart:io';

import 'package:cliff/screens/Merch/screens/buy_merch_screen.dart';
import 'package:cliff/widgets/event_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddDesignsScreen extends StatefulWidget {
  const AddDesignsScreen({super.key});
  static const routeName = '/add-designs';

  @override
  State<AddDesignsScreen> createState() => _AddDesignsScreenState();
}

class _AddDesignsScreenState extends State<AddDesignsScreen> {
  final _form = GlobalKey<FormState>();
  File? _selectedImage;

  var _isSubmitting = false;
  var _productName = '';
  var _productPrice = '';
  var _productDescription = '';
  var _createdBy = '';
  String? _isForSale;

  final _productPriceFoucsNode = FocusNode();
  final _createdByFocusNode = FocusNode();
  final _productDescriptionFocusNode = FocusNode();

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
          content: Text('Please select a product image'),
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
          .child('merchandise')
          .child('$_productName.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      FirebaseFirestore.instance.collection('merchandise').doc().set(
        {
          'addedby': currentUser,
          'image_url': imageUrl,
          'productname': _productName,
          'productdescription': _productDescription,
          'productprice': _productPrice,
          'createdby': _createdBy,
          'isforsale': _isForSale,
          'likes': [],
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

  @override
  void dispose() {
    _productPriceFoucsNode.dispose();
    _createdByFocusNode.dispose();
    _productDescriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Designs'),
        centerTitle: true,
      ),
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
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_productPriceFoucsNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productName = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Product Price',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  focusNode: _productPriceFoucsNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_createdByFocusNode);
                  },
                  validator: (value) {
                    // must be unique event code use firebase get command
                    if (value!.isEmpty) {
                      return 'Please enter a price';
                    }
                    // if (int.parse(value) < 300) {
                    //   return 'Please enter a price greater than Rs300';
                    // }
                    return null;
                  },
                  onSaved: (value) {
                    _productPrice = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Creator Name',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  focusNode: _createdByFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context)
                        .requestFocus(_productDescriptionFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter creator name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _createdBy = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Is For Sale',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  value: _isForSale,
                  items: ['true', 'false']
                      .map((value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _isForSale = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
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
                  maxLines: 5,
                  maxLength: 200,
                  keyboardType: TextInputType.multiline,
                  focusNode: _productDescriptionFocusNode,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter The product description.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _productDescription = value!;
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
                                                  'product Added',
                                                ),
                                              ),
                                            ),
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              BuyMerchScreen.routeName,
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
                                                'Product creation was unsuccessful, Try again.'),
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
