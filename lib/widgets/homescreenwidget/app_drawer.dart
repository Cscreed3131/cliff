import 'package:cliff/provider/user_data_provider.dart';
import 'package:cliff/widgets/homescreenwidget/bottom_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cliff/sub_sections/Auth/auth_screen.dart';
import 'package:cliff/sub_sections/Admin/admin_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(realTimeUserDataProvider);

    Future<List<dynamic>> checkRole() async {
      List<dynamic> roles = [];
      final snapshot = userDetails;

      snapshot.when(
        data: (data) {
          roles = data.roles;
        },
        error: (Object error, StackTrace stackTrace) {},
        loading: () {},
      );

      return roles;
    }

    final rolesFuture = checkRole();
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      elevation: 10,
      width: MediaQuery.of(context).size.width * 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Center(
                child: userDetails.when(
                  data: (data) {
                    // String userName = data.name;
                    // String userSic = data.sic;
                    // String userImageUrl = data.imageUrl;
                    return Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.1,
                          margin: const EdgeInsets.only(top: 30, bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(data.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          data.sic.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 1,
                          ),
                        ),
                        if (data.roles.contains('admin'))
                          //Chip with an admin logo and admin as the label, it is green with green border

                          Chip(
                            avatar: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.admin_panel_settings_rounded,
                                color: Colors.green,
                              ),
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            //light green surface tint color
                            backgroundColor: Colors.lightGreen[300],
                            label: Text(
                              'Adminstrator',
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                            // backgroundColor: Colors.teal,
                            elevation: 20,
                          ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return const Text('cant load file');
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                ),
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
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
            ),

            //admin panel tile
            FutureBuilder<List<dynamic>>(
              future: rolesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }

                final roles = snapshot.data ?? [];
                final isAdmin = roles.contains('admin');

                if (isAdmin) {
                  return ListTile(
                    leading: const Icon(
                      Icons.admin_panel_settings_rounded,
                    ),
                    title: const Text(
                      'Administrator',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(AdminScreen.routeName);
                    },
                  );
                }

                return Container(); // Return an empty container if not admin
              },
            ),

            //contact us tile
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
            //logout tile
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
                              ref.invalidate(realTimeUserDataProvider);
                              await Navigator.of(context)
                                  .popAndPushNamed(AuthScreen.routeName);
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

            //exit tile
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
            //info tile

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
