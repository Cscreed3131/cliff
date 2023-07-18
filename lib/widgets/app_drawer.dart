import 'package:cliff/screens/Admin/admin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: drawerBackgroundColor,
      width: 250,
      // shape: ShapeBorder.lerp(a, b, t),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 30, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: FirebaseAuth.instance.currentUser!.photoURL != null ?
                        NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                            : const AssetImage('assets/images/logo.png') as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Text(
                    'Anubhav Kumar',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                    'Student',
                    style: TextStyle(
                    ),
                  ),
                ],
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
                fontSize: 20,

              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.add,
            ),
            title: const Text(
              'Add Events',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AdminScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag,
            ),
            title: const Text(
              'Orders',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.contact_mail,
            ),
            title: const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.arrow_back_rounded,
            ),
            title: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.info,
            ),
            title: const Text(
              'About',
              style: TextStyle(
                fontSize: 20,
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
    );
  }
}
