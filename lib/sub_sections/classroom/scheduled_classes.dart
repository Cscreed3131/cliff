import 'dart:ui';

import 'package:cliff/sub_sections/classroom/providers/class_timetable_provider.dart';
import 'package:cliff/sub_sections/classroom/widgets/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduledClasses extends ConsumerStatefulWidget {
  const ScheduledClasses({Key? key}) : super(key: key);
  static const routeName = "/ScheduleClass";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScheduledClassesState();
}

class _ScheduledClassesState extends ConsumerState<ScheduledClasses>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _hideFabAnimation;
  final CalendarView _calendarView = CalendarView.day;

  @override
  void initState() {
    super.initState();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final data1 = ref.watch(timeTableProvider);
    data1.when(data: (data) {
      for (var element in data) {
        print(element.className);
      }
    }, error: (error, stackTrace) {
      print(error);
      print(stackTrace);
    }, loading: () {
      print('loading');
    });
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        /*endDrawer: NavigationDrawer(
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
          indicatorShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  'assets/images/empty.png',
                ),
              ),
              title: Text(
                'Calender',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            //navigation drawer destinations here
            //they include schedule, day, week, month, year
            const NavigationDrawerDestination(
              label: Text('Schedule'),
              icon: Icon(Icons.calendar_view_day_outlined),
            ),
            const NavigationDrawerDestination(
              label:Text('Day'),
              icon: Icon(Icons.calendar_today),
            ),
            const NavigationDrawerDestination(
              label: Text('Week'),
              icon: Icon(Icons.calendar_view_week),
            ),
            const NavigationDrawerDestination(
              label:Text('Month'),
              icon: Icon(Icons.calendar_view_month),
            ),
          ]
        ),*/
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar.large(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              // leading: ,
              // title: const Text(
              //   "Classroom",
              //   style: TextStyle(
              //     fontFamily: 'IBMPlexMono',
              //     fontSize: 30,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Classroom",
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                expandedTitleScale: 1.2,
                background: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/empty.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.5),
                              Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.6),
                              Theme.of(context).colorScheme.surface,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    // height: screenHeight * 0.2,
                    // width: double.infinity,
                    // margin: const EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     color: Theme.of(context).colorScheme.outline,
                    //   ),
                    //   color:
                    //   Theme.of(context).colorScheme.secondaryContainer,
                    //   borderRadius: BorderRadius.circular(20),
                    //   image: const DecorationImage(
                    //     image: AssetImage('assets/images/empty.png'),
                    //     fit: BoxFit.fitWidth,
                    //     ),
                    //   )
                    // ),
                    //A card showing all the classes that are scheduled for the day
                    const SizedBox(
                      height: 0,
                    ),

                    DailyPlanWidget(
                      _calendarView,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: ScaleTransition(
            scale: _hideFabAnimation,
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              elevation: 8,
              onPressed: () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    0.0, // Scroll to the top
                    duration: const Duration(
                      milliseconds: 300,
                    ), // Adjust the duration as needed
                    curve: Curves.easeInOut, // Adjust the curve as needed
                  );
                }
              },
              child: const Icon(Icons.arrow_upward),
            )),
      ),
    );
  }
}
