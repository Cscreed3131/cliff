
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/user_data_provider.dart';
import '../../screens/Admin/admin_screen.dart';
import '../../screens/Auth/auth_screen.dart';

class ProfileDialog extends ConsumerWidget{
  const ProfileDialog({Key? key}) : super(key: key);
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

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(30),
      ),
      child: userDetails.when(
        data: (data){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:NetworkImage(data.imageUrl),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ListTile(
                      title: Text(data.name),
                      subtitle: Text(data.sic, style: TextStyle(
                        color: Colors.grey,
                      ),),
                    ),
                  ),
                ],
              ),

              Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                avatar: Icon(Icons.admin_panel_settings, color: Colors.green.shade700,),
                label: const Text('Admin'),

              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
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

              ListTile(
                onTap: () => {},
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
              ),
              ListTile(
                onTap: () => {},
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),

              const Divider(
                indent: 10,
                endIndent: 10,

              ),
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

            ],
          );
        },
        error: (error, stackTrace) {
          return const Text('cant load file');
        },
        loading: () {
          return const CircularProgressIndicator();
        },
      )
    );
}
}