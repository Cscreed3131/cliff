import 'package:cliff/provider/user_data_provider.dart';
import 'package:cliff/sub_sections/Admin/add_class_timetable.dart';
import 'package:cliff/sub_sections/Admin/add_food_item_screen.dart';
import 'package:cliff/sub_sections/Admin/company_data_screen.dart';
import 'package:cliff/sub_sections/Admin/create_announcement.dart';
import 'package:cliff/sub_sections/Home/announcements_screen.dart';
import 'package:cliff/sub_sections/Home/test_nav_bar.dart';
import 'package:cliff/sub_sections/classroom/scheduled_classes.dart';
import 'package:cliff/sub_sections/placements/screens/placement_details_screen.dart';
import 'package:cliff/sub_sections/placements/screens/placement_screen.dart';
import 'package:cliff/sub_sections/placements/placements_quiz.dart';
import 'package:cliff/sub_sections/placements/placements_trainer.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cliff/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cliff/widgets/homescreenwidget/bottom_navigation_bar.dart';
import 'package:cliff/sub_sections/Merch/screens/merch_details_screen.dart';
import 'package:cliff/sub_sections/Admin/create_event_screens.dart';
import 'package:cliff/sub_sections/Admin/admin_screen.dart';
import 'package:cliff/sub_sections/Auth/auth_screen.dart';
import 'package:cliff/sub_sections/alumni/alumni_screen.dart';
import 'package:cliff/sub_sections/Merch/screens/buy_merch_screen.dart';
import 'package:cliff/sub_sections/Events/screens/event_screen.dart';
import 'package:cliff/sub_sections/food/food_screen.dart';
import 'package:cliff/sub_sections/Auth/singup_screen.dart';
import 'package:cliff/sub_sections/memories.dart';
import 'package:cliff/sub_sections/polls.dart';
import 'package:cliff/sub_sections/Admin/add_designs_screen.dart';
import 'package:cliff/sub_sections/Events/screens/event_details_screen.dart';
import 'package:cliff/sub_sections/Events/screens/registered_events_screen.dart';
import 'package:cliff/sub_sections/Merch/screens/cart_screen.dart';
import 'package:cliff/sub_sections/food/food_details_page.dart';
import 'package:cliff/sub_sections/history/history_screen.dart';

import 'sub_sections/placements/models/company_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Color brandColor = const Color(0xF1F6F9);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(realTimeUserDataProvider);
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? dark) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        final brightness = MediaQuery.of(context).platformBrightness;

        if (lightDynamic != null && dark != null) {
          lightColorScheme = lightDynamic.harmonized()..copyWith();
          lightColorScheme = lightColorScheme.copyWith(secondary: brandColor);
          darkColorScheme = dark.copyWith(secondary: brandColor);
        } else {
          lightColorScheme = ColorScheme.fromSeed(
              seedColor: brandColor, brightness: Brightness.light);
          darkColorScheme = ColorScheme.fromSeed(
              seedColor: brandColor, brightness: Brightness.dark);
        }

        final colorScheme =
            brightness == Brightness.dark ? darkColorScheme : lightColorScheme;

        return MaterialApp(
          title: 'CLIFF',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: colorScheme,
            useMaterial3: true,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const TestNavBar();
              }
              return const AuthScreen();
            },
          ),
          routes: {
            TestNavBar.routeName: (ctx) => const TestNavBar(),
            SignUpScreen.routeName: (ctx) => const SignUpScreen(),
            AuthScreen.routeName: (ctx) => const AuthScreen(),
            EventsScreen.routeName: (ctx) => const EventsScreen(),
            HistoryScreen.routeName: (ctx) => const HistoryScreen(),
            FoodScreen.routeName: (ctx) => const FoodScreen(),
            RegisteredEventsScreen.routeName: (ctx) =>
                const RegisteredEventsScreen(),
            BuyMerchScreen.routeName: (ctx) => const BuyMerchScreen(),
            AlumniScreen.routeName: (ctx) => const AlumniScreen(),
            Memories.routeName: (ctx) => const Memories(),
            Polls.routeName: (ctx) => const Polls(),
            AdminScreen.routeName: (ctx) => const AdminScreen(),
            CreateEventScreen.routeName: (ctx) => const CreateEventScreen(),
            HomePage.routeName: (ctx) => const HomePage(),
            AddDesignsScreen.routeName: (ctx) => const AddDesignsScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            CreateAnnouncement.routeName: (ctx) => const CreateAnnouncement(),
            AnnouncementScreen.routeName: (cxt) => const AnnouncementScreen(),
            AddFoodItems.routeName: (ctx) => const AddFoodItems(),
            ScheduledClasses.routeName: (ctx) => const ScheduledClasses(),
            AddClassTimeTable.routeName: (ctx) => const AddClassTimeTable(),
            PlacementsScreen.routeName: (ctx) => const PlacementsScreen(),
            PlacementsTrainer.routeName: (ctx) => const PlacementsTrainer(),
            PlacementsQuiz.routeName: (ctx) => const PlacementsQuiz(),
            AddCompanyData.routeName: (ctx) => const AddCompanyData(),
            MerchDetails.routeName: (ctx) {
              final Map<String, dynamic>? args = ModalRoute.of(ctx)!
                  .settings
                  .arguments as Map<String, dynamic>?;
              return MerchDetails(
                merchName: args?['merchName'] ?? 'Default Name',
                merchPrice: args?['merchPrice'] ?? 0,
                merchDesc: args?['merchDesc'] ?? 'Default Description',
                photoUrl: args?['photoUrl'] ?? 'Default Url',
                isForSale: args?['isForSale'] ?? false,
                merchId: args?['merchId'] ?? 'Default id',
              );
            },
            EventDetailsScreen.routeName: (ctx) {
              final Map<String, dynamic>? args = ModalRoute.of(ctx)!
                  .settings
                  .arguments as Map<String, dynamic>?;
              return EventDetailsScreen(
                eventId: args?['eventId'] ?? '',
                title: args?['title'] ?? 'Default Title',
                eventCode: args?['eventCode'] ?? 'Default Event Code',
                eventDescription:
                    args?['eventDescription'] ?? 'Default Event Description',
                eventFinishDateTime:
                    args?['eventFinishDateTime'] ?? 'Default Date and Time',
                eventImage: args?['eventImage'] ?? 'Default Url',
                eventStartDateTime:
                    args?['eventFinishStartTime'] ?? 'Default Date and Time',
                eventVenue: args?['eventVenue'] ?? 'Default Event Venue',
                club: args?['club'] ?? 'Default Club',
                clubMembersic1: args?['clubmembersic1'] ?? 'Default Sic',
                clubMembersic2: args?['clubmembersic2'] ?? 'Default Sic',
              );
            },
            FoodDetailsPage.routeName: (ctx) {
              final Map<String, dynamic>? args = ModalRoute.of(ctx)!
                  .settings
                  .arguments as Map<String, dynamic>?;
              return FoodDetailsPage(
                // id: args?['id'] ?? 0,
                name: args?['name'] ?? 'Default Name',
                category: args?['category'] ?? 'Default Category',
                imgUrl: args?['imgUrl'] ?? 'Default Url',
                price: args?['price'] ?? 0.0,
                description: args?['description'] ?? 'Default Description',
              );
            },
            PlacementDetails.routeName: (ctx) {
              final CompanyData args = ModalRoute.of(ctx)!.settings.arguments
                  as CompanyData; // a far better approch so the main looks clean and clear might do this for every thing in the future.
              return PlacementDetails(data: args);
            },
          },
        );
      },
    );
  }
}
