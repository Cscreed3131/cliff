import 'dart:io';
import 'package:cliff/screens/singup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const routeName = '/sign-in';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredpassword = '';
  var _enteredSicNumber = '';
  File? _selectedImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      //show error message
      return;
    }

    if (!_isLogin && _selectedImage == null) {
      return;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredpassword);
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 30, bottom: 20, left: 20, right: 20),
                      width: 200,
                      child: const Center(
                        child: Text(
                          'CLIFF',
                          style: TextStyle(
                            fontFamily: 'MoonbrightDemo',
                            // color: Color.fromRGBO(132, 136, 181, 1),
                            fontWeight: FontWeight.normal,
                            fontSize: 100,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: const Color.fromRGBO(97, 103, 139, 1),
                      margin: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: _form,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!_isLogin)
                                  UserImagePicker(
                                    onPickImage: (pickedImage) {
                                      _selectedImage = pickedImage;
                                    },
                                  ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Email Address'),
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
                                // if (!_isLogin)
                                //   TextFormField(
                                //     decoration: const InputDecoration(
                                //         labelText: 'Sic Number'),
                                //     validator: (value) {
                                //       if (value == null ||
                                //           value.isEmpty ||
                                //           value.trim().length < 4) {
                                //         return 'please enter at least 4 characters.';
                                //       }
                                //       return null;
                                //     },
                                //     onSaved: (value) {
                                //       _enteredSicNumber = value!;
                                //     },
                                //   ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Password'),
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
                                const SizedBox(height: 12),
                                if (_isAuthenticating)
                                  const CircularProgressIndicator(),
                                if (!_isAuthenticating)
                                  ElevatedButton(
                                    onPressed: _submit,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    child: const Text('Sign in'),
                                  ),
                                if (!_isAuthenticating)
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).popAndPushNamed(
                                          SignUpScreen.routeName);
                                    },
                                    child: const Text(
                                        'Dont have an account?\n     Create account'),
                                  )
                              ],
                            ),
                          ),
                        ),
                        // ),
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
