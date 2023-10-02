import 'package:cliff/screens/classroom/scheduled_classes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/classroom/providers/class_timetable_provider.dart';

class ClassroomWidget extends ConsumerStatefulWidget {
  const ClassroomWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClassroomWidgetState();
}

class _ClassroomWidgetState extends ConsumerState<ClassroomWidget> {
  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    int numberOfClassesToday = 0;

    List<TodaysScheduledClass> getTodaysScheduledClass(WidgetRef ref) {
      final timetableData = ref.watch(timeTableProvider);
      final List<TodaysScheduledClass> todaysScheduledClass = [];
      timetableData.when(data: (data) {

        for (var element in data) {
          if(element.className != "Lunch"){
            numberOfClassesToday++;
            todaysScheduledClass.add(
              TodaysScheduledClass(
                className: element.className,
                classStartTime: element.startDateTime,
                classEndTime: element.endDateTime,
                classRoom: element.classLocation,
                classColor: Color(int.parse(element.color)),
              ),
            );
          }
        }
      }, error: (error, stackTrace) {
        if (kDebugMode) {
          print(error);
          print(stackTrace);
        }

      }, loading: () {
        if (kDebugMode) {
          print('loading');
        }
      });
      // print("PRINTING FROM SCHEDULED CLASSESD");
      // print(_todaysScheduledClass);
      return todaysScheduledClass;

    }

    getTodaysScheduledClass(ref);


    return Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: SizedBox(
          //height: screenHeight * 0.23,
          width: screenWidth * 0.87,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            //shadowColor: Colors.transparent,
            color: Theme.of(context)
                .colorScheme
                .primaryContainer
                .withOpacity(0.5),
            child: Container(
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Theme.of(context).colorScheme.primary,
                    // ),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () => Navigator.of(context).pushNamed(ScheduledClasses.routeName),
                      leading: Icon(
                        Icons.person_pin_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        'Classroom',
                        style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: screenWidth * 0.05,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        numberOfClassesToday > 0 ?
                        'You have $numberOfClassesToday classes' :
                        'No classes. Enjoy your day!',
                        style: TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: screenWidth * 0.04,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    //A list of chips consisting of items from the getTodaysScheduledClass() function, wrapped
                    numberOfClassesToday > 0 ?  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(bottom: 10),
                      child: Wrap(
                        spacing: 10,
                        children: [
                          for (var element in getTodaysScheduledClass(ref))
                            Chip(
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(50),
                              // ),
                              label: Text(
                                element.className,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: element.classColor.withOpacity(0.8),
                            ),
                        ],),
                    ) : const SizedBox(),

                  ],
                )
            ),
          ),
        )
    );
  }


}

class TodaysScheduledClass {
  final String className;
  final DateTime classStartTime;
  final DateTime classEndTime;
  final String classRoom;
  final Color classColor;

  TodaysScheduledClass({
    required this.className,
    required this.classStartTime,
    required this.classEndTime,
    required this.classRoom,
    required this.classColor,
  });
}