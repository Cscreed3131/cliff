import 'package:cliff/screens/Admin/admin_screen.dart';
import 'package:cliff/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
/*  static Duration duration = const Duration(milliseconds: 300);
  AnimationController? _controller;
  static const double maxSlide = 255;
  static const dragRightStartVal = 60;
  static const dragLeftStartVal = maxSlide - 20;
  static bool shouldDrag = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _AppDrawerState.duration);
    super.initState();
  }

  void close() => _controller!.reverse();

  void open() => _controller!.forward();

  void toggle() {
    if (_controller!.isCompleted) {
      close();
    } else {
      open();
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails startDetails) {
    bool isDraggingFromLeft = _controller!.isDismissed && startDetails.globalPosition.dx < dragRightStartVal;
    bool isDraggingFromRight = _controller!.isCompleted && startDetails.globalPosition.dx > dragLeftStartVal;
    shouldDrag = isDraggingFromLeft || isDraggingFromRight;
  }

  void _onDragUpdate(DragUpdateDetails updateDetails) {
    if (shouldDrag == false) {
      return;
    }
    double delta = updateDetails.primaryDelta! / maxSlide;
    _controller!.value += delta;
  }

  void _onDragEnd(DragEndDetails dragEndDetails) {
    if (_controller!.isDismissed || _controller!.isCompleted) {
      return;
    }

    double _kMinFlingVelocity = 365.0;
    double dragVelocity = dragEndDetails.velocity.pixelsPerSecond.dx.abs();

    if (dragVelocity >= _kMinFlingVelocity) {
      double visualVelocityInPx = dragEndDetails.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;
      _controller!.fling(velocity: visualVelocityInPx);
    } else if (_controller!.value < 0.5) {
      close();
    } else {
      open();
    }
  }*/

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
                          image: FirebaseAuth.instance.currentUser!.photoURL !=
                                  null
                              ? NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL!)
                              : const AssetImage('assets/images/logo.png')
                                  as ImageProvider,
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
                      style: TextStyle(),
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
                  fontSize: 15,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
            ),
            const Divider(),
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
            const Divider(),
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
            const Divider(),
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
            const Divider(),
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
                      content: Text(
                        error.message ?? 'You ran into an unexpected error',
                      ),
                    ),
                  );
                }
              },
            ),
            const Divider(),
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
            const Divider(),
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
