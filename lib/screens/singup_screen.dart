import 'dart:io';

import 'package:cliff/screens/auth_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SiignUpScreenState();
}

class _SiignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    // var _isLogin = false;
    var _isAuthenticating = false;
    var _enteredEmail = '';
    var _enteredpassword = '';
    var _enteredSicNumber = '';
    var _enteredbranch = '';
    var _enteredPhoneNumber = '';
    var _enteredStudentYear = '';
    var _enteredUserName = '';
    File? _selectedImage;

    void _submit() async {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        //show error message
        return;
      }

      if (_selectedImage == null) {
        //promt user to select a image. nessesary
        return;
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
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(222, 222, 234, 1).withOpacity(0.5),
                  const Color.fromRGBO(152, 191, 208, 1).withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 1],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      width: 200,
                      child: const Center(
                        child: Text(
                          'CLIFF',
                          style: TextStyle(
                            fontFamily: 'MoonbrightDemo',
                            // color: Color.fromRGBO(132, 136, 181, 1),
                            fontWeight: FontWeight.normal,
                            fontSize: 70,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                        left: 25,
                        right: 25,
                        top: 5,
                      ),
                      child: Column(
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
                          Row(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Sic Number',
                                    border: OutlineInputBorder(),
                                    constraints: BoxConstraints(
                                      maxWidth: 152,
                                    )),
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
                                width: 6,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Branch',
                                    border: OutlineInputBorder(),
                                    constraints: BoxConstraints(maxWidth: 152)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter valid Branch.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _enteredbranch = value!;
                                },
                              ),
                            ],
                          ),
                          // const SizedBox(height: 7),
                          const SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Year',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter year';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredStudentYear = value!;
                            },
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
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length == 10) {
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
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
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
                            onSaved: (value) {
                              _enteredpassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: _submit,
                                child: const Text('Sign Up'),
                              ),
                              const SizedBox(
                                width: 28,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .popAndPushNamed(AuthScreen.routeName);
                                },
                                // style: ButtonStyle(),
                                child: const Text(
                                  'Have an account? Login instead',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
