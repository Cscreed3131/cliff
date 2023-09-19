import 'package:cliff/provider/user_data_provider.dart';
import 'package:cliff/screens/classroom/models/class_timetable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeTableProvider = StreamProvider.autoDispose<Timetable>((ref) {
  String? branch;
  String? year;
  String? section = 'J'.toUpperCase();
  final data = ref.watch(realTimeUserDataProvider);
  data.whenData((value) {
    branch = value.branch;
    year = value.year;
  });

  // Define a list of days for which you want to fetch data
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final Map<String, Stream<List<TimetableDayWise>>> timetableData = {};

  for (final day in days) {
    timetableData[day] = fetchDayWiseTimetable(branch, year, section, day);
  }

  return Stream.value(Timetable(dayWiseTimetable: timetableData));
});

Stream<List<TimetableDayWise>> fetchDayWiseTimetable(
    String? branch, String? year, String section, String day) {
  final collectionReference = FirebaseFirestore.instance
      .collection('timetables')
      .doc(branch)
      .collection('years')
      .doc(year)
      .collection('sections')
      .doc(section)
      .collection(day); // Use the 'day' parameter here

  return collectionReference.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return TimetableDayWise(
        day: day, // Use the 'day' parameter here
        data: {
          doc.id: TimetableEntry(
            classNumber: doc.id,
            timeSlot: data['classDuration'],
            className: data['className'],
            classLocation: data['classLocation'],
            startDateTime: (data['startDateTime'] as Timestamp).toDate(),
            endDateTime: (data['endDateTime'] as Timestamp).toDate(),
            repeatUntil: (data['repeatTill'] as Timestamp).toDate(),
            day: data['day'],
            color: data['color'],
          ),
        },
      );
    }).toList();
  });
}


// final dayWiseTimetableData = Provider<Map<String, List<TimetableEntry>>>((ref) {
//   return {
//     'Monday': [],
//     'Tuesday': [],
//     'Wednessday': [],
//     'Thursday': [],
//     'Friday': [],
//     'Saturday': [],
//   };
// });
