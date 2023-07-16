import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cliff/screens/auth_screen.dart';
import 'package:cliff/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _isAuthenticating = false;
  var _enteredpassword = '';
  var _enteredSicNumber = '';
  var _enteredbranch = '';
  var _enteredPhoneNumber = '';
  var _enteredStudentYear = '';
  var _enteredUserName = '';
  File? _selectedImage;

  final _sicFocusNode = FocusNode();
  final _branchFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  Future<bool> _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return false;
    }

    if (_selectedImage == null) {
      //promt user to select a image. nessesary
      return false;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredpassword,
      );

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userCredentials.user!.uid}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();

      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set(
        {
          'image_url': imageUrl,
          'name': _enteredUserName,
          'sic': _enteredSicNumber,
          'branch': _enteredbranch,
          'year': _enteredStudentYear,
          'phoneNumber': _enteredPhoneNumber,
          'email': _enteredEmail,
        },
      );
      return true;
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authenication failed'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
    return false;
  }

  @override
  void dispose() {
    _sicFocusNode.dispose();
    _branchFocusNode.dispose();
    _yearFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //Sizes
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final font15 = screenWidth * 0.038;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromRGBO(225, 218, 230, 1).withOpacity(0.5),
              const Color.fromRGBO(246, 196, 237, 1).withOpacity(0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 1],
          ),
        ),
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Center(
                  child: Text(
                    'CLIFF',
                    style: TextStyle(
                      fontFamily: 'MoonbrightDemo',
                      fontWeight: FontWeight.normal,
                      fontSize: screenHeight * 0.13,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UserImagePicker(
                          onPickImage: (pickedImage) {
                            _selectedImage = pickedImage;
                          },
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_sicFocusNode);
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredUserName = value!;
                          },
                        ),
                        const SizedBox(height: 7),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Sic Number',
                            border: OutlineInputBorder(),
                          ),
                          focusNode: _sicFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_branchFocusNode);
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length < 4) {
                              return 'please enter at least 4 characters.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredSicNumber = value!;
                          },
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Branch',
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                value: _enteredbranch.isNotEmpty
                                    ? _enteredbranch
                                    : null,
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: 'CSE',
                                    child: Text('CSE'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'CST',
                                    child: Text('CST'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'CEN',
                                    child: Text('CEN'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'ECE',
                                    child: Text('ECE'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'EEE',
                                    child: Text('EEE'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'EIE',
                                    child: Text('EIE'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _enteredbranch = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a branch';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Year',
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                                value: _enteredStudentYear.isNotEmpty
                                    ? _enteredStudentYear
                                    : null,
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: '1st',
                                    child: Text('1st'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: '2nd',
                                    child: Text('2nd'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: '3rd',
                                    child: Text('3rd'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: '4th',
                                    child: Text('4th'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _enteredStudentYear = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a year';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          focusNode: _phoneNumberFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_emailFocusNode);
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length != 10 ||
                                value.trim().length > 10 ||
                                value.trim().length < 10) {
                              return 'Please enter correct Phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPhoneNumber = value!;
                          },
                        ),
                        const SizedBox(height: 7),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        const SizedBox(height: 7),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'password is to short';
                            }
                            return null;
                          },
                          focusNode: _passwordFocusNode,
                          // onFieldSubmitted: (_) {},
                          onSaved: (value) {
                            _enteredpassword = value!;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            if (_isAuthenticating)
                              const CircularProgressIndicator(),
                            if (!_isAuthenticating)
                              ElevatedButton(
                                onPressed: () async {
                                  if (await _submit()) {
                                    if (context.mounted) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'SignUp Successfull'),
                                            content: const Text(
                                                'Please Sign-in with the email and password'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .popAndPushNamed(
                                                          AuthScreen.routeName);
                                                },
                                                child: Text(
                                                  'Okay',
                                                  style: TextStyle(
                                                    fontFamily: 'Barrbar',
                                                    fontSize: font15+5,
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                  _isAuthenticating = false;
                                },
                                child: const Text('Sign Up'),
                              ),
                            SizedBox(
                              width: screenWidth * 0.13,
                            ),
                            Text(
                              'Have an account?',
                              style: TextStyle(
                                fontSize: font15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(AuthScreen.routeName);
                              },
                              // style: ButtonStyle(),
                              child: Text(
                                'Login instead',
                                style: TextStyle(
                                  fontSize: font15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
