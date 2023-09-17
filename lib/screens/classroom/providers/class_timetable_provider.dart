import 'package:cliff/provider/user_data_provider.dart';
import 'package:cliff/screens/classroom/models/class_timetable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeTableProvider =
    StreamProvider.autoDispose<List<TimetableDayWise>>((ref) {
  String? branch;
  String? year;
  String? section = 'J'.toUpperCase();
  final data = ref.watch(realTimeUserDataProvider);
  data.whenData((value) {
    branch = value.branch;
    year = value.year;
  });

  return fetchDayWiseTimetable(branch, year, section);
});

Stream<List<TimetableDayWise>> fetchDayWiseTimetable(
    String? branch, String? year, String section) {
  final collectionReferenceMonday = FirebaseFirestore.instance
      .collection('timetables')
      .doc(branch)
      .collection('years')
      .doc(year)
      .collection('sections')
      .doc(section)
      .collection('Monday');
  return collectionReferenceMonday.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return TimetableDayWise(
        day: "Monday",
        data: {
          doc.id: TimetableEntry(
            // classNumber: data['classNumber'],
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
