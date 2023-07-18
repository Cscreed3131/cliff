import 'package:cliff/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cliff/screens/Admin/admin_screen.dart';
import 'package:cliff/screens/Admin/create_event_screens.dart';
import 'package:cliff/screens/splash_screen.dart';
import 'package:cliff/screens/Auth/auth_screen.dart';
import 'package:cliff/screens/alumni_screen.dart';
import 'package:cliff/screens/buy_merch_screen.dart';
import 'package:cliff/screens/event_screen.dart';
import 'package:cliff/screens/history_screen.dart';
import 'package:cliff/screens/home_screen.dart';
import 'package:cliff/screens/Auth/singup_screen.dart';
import 'package:cliff/screens/memories.dart';
import 'package:cliff/screens/polls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLIFF',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // inputDecorationTheme: ,
        // fontFamily: 'Mufanpfs',
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
          primary: const Color.fromARGB(255, 2, 0, 17),
          secondary: const Color.fromRGBO(76, 114, 115, 1.000),
        ),
        scaffoldBackgroundColor: Colors.grey.withOpacity(0.7),

        useMaterial3: false,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          // snapshot.hasData ? const HomeScreen() : const AuthScreen();
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const AuthScreen();
        },
      ),
      routes: {
        SignUpScreen.routeName: (ctx) => const SignUpScreen(),
        AuthScreen.routeName: (ctx) => const AuthScreen(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        EventsScreen.routeName: (ctx) => const EventsScreen(),
        HistoryScreen.routeName: (ctx) => const HistoryScreen(),
        BuyMerchScreen.routeName: (ctx) => const BuyMerchScreen(),
        AlumniScreen.routeName: (ctx) => const AlumniScreen(),
        Memories.routeName: (ctx) => const Memories(),
        Polls.routeName: (ctx) => const Polls(),
        AdminScreen.routeName: (ctx) => const AdminScreen(),
        CreateEventScreen.routeName: (ctx) => const CreateEventScreen(),
      },
    );
  }
}
