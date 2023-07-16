import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const Color drawerBackgroundColor = Color.fromRGBO(89, 86, 116, 1);
    const Color textBackgroundColor = Color.fromRGBO(208, 214, 214, 1);
    const Color iconColor = Color.fromRGBO(208, 214, 214, 1);
    return Drawer(
      backgroundColor: drawerBackgroundColor,
      width: 250,
      // shape: ShapeBorder.lerp(a, b, t),
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text(
              'Legendary Creed',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Barrbar',
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: iconColor,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 20,
                color: textBackgroundColor,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag,
              color: iconColor,
            ),
            title: const Text(
              'Orders',
              style: TextStyle(
                fontSize: 20,
                color: textBackgroundColor,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.contact_mail,
              color: iconColor,
            ),
            title: const Text(
              'Contact Us',
              style: TextStyle(
                color: textBackgroundColor,
                fontSize: 20,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: iconColor,
            ),
            title: const Text(
              'settings',
              style: TextStyle(
                fontSize: 20,
                color: textBackgroundColor,
              ),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: iconColor,
            ),
            title: const Text(
              'about',
              style: TextStyle(
                fontSize: 20,
                color: textBackgroundColor,
              ),
            ),
            subtitle: const Text(
              '1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: textBackgroundColor,
              ),
            ),
            onTap: () {},
          ),
          const Divider(
            height: 0,
          ),
          ListTile(
            leading: const Icon(
              Icons.arrow_back_rounded,
              color: iconColor,
            ),
            title: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 20,
                color: textBackgroundColor,
              ),
            ),
            onTap: () {
              SystemNavigator.pop();
            },
          )
        ],
      ),
    );
  }
}
