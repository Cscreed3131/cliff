import 'package:cliff/models/userdetails.dart';
import 'package:cliff/screens/Admin/admin_screen.dart';
import 'package:cliff/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/user_details_provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  // void initState() {
  //   UserDetails;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final font15 = screenWidth * 0.038;
    return Drawer(
      width: 250,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Consumer(builder: (context, ref, _) {
                  final dataItem = ref.watch(userDataProvider);
                  return dataItem.when(
                    data: (userDetails) {
                      return Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 30, bottom: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(userDetails.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            userDetails.name,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            userDetails.sic,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    },
                    error: (error, stackTrace) => Text('Error: $error'),
                    loading: () => const CircularProgressIndicator(),
                  );
                }),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.admin_panel_settings_rounded,
              ),
              title: const Text(
                'Adminstrator',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(AdminScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_bag,
              ),
              title: const Text(
                'Orders',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.contact_mail,
              ),
              title: const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app_rounded,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                try {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          'Alert',
                        ),
                        content: const Text(
                          'Are you sure you want to Sign-out',
                        ),
                        actions: [
                          TextButton(
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await FirebaseAuth.instance.signOut();
                              UserDetails(
                                name: '',
                                sic: '',
                                branch: '',
                                email: '',
                                year: '',
                                phoneNumber: null,
                                imageUrl: '',
                              );
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } on FirebaseAuthException catch (error) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        error.message ?? 'You ran into an unexpected error',
                      ),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.arrow_back_rounded,
              ),
              title: const Text(
                'Exit',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
              ),
              title: const Text(
                'About',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              subtitle: const Text(
                '1.0.0',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
