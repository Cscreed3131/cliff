import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cliff/screens/singup_screen.dart';

import '../global_varibales.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/sign-in';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredpassword = '';
  var _isAuthenticating = false;
  final _passwordFocusNode = FocusNode();

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      //show error message
      return;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });

      await _firebase.signInWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredpassword,
      );
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final font15 = screenWidth * 0.038;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: pageGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: screenHeight * 0.07,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.025,
                ),
                child: Text(
                  'Hello, \nWelcome to Silicon Institute of Technology',
                  style: TextStyle(
                    fontSize: screenHeight * 0.038,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            // this validation should pass the silicon id test
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
                        keyboardType: TextInputType.visiblePassword,
                        focusNode: _passwordFocusNode,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password is too short';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredpassword = value!;
                        },
                      ),
                      const SizedBox(height: 15),
                      if (_isAuthenticating) const CircularProgressIndicator(),
                      if (!_isAuthenticating)
                        ElevatedButton(
                          onPressed: _submit,
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: font15 + 2),
                          ),
                        ),

                      const SizedBox(height: 30),

                      //Dont have account text
                      if (!_isAuthenticating)
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: font15),
                        ),
                      if (!_isAuthenticating)
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(SignUpScreen.routeName);
                          },
                          child: Text(
                            'Create account',
                            style: TextStyle(fontSize: font15),
                          ),
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
