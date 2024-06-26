import 'package:cliff/provider/user_data_provider.dart';
import 'package:cliff/sub_sections/classroom/models/class_timetable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeTableProvider =
    StreamProvider.autoDispose<List<TimetableEntry>>((ref) {
  String? branch;
  String? year;
  String? section = 'J'.toUpperCase();
  final data = ref.watch(realTimeUserDataProvider);
  branch = data.value!.branch;
  year = data.value!.year;
  return FirebaseFirestore.instance
      .collection('timetables')
      .doc(branch)
      .collection('years')
      .doc(year)
      .collection('sections')
      .doc(section)
      .collection('timetable')
      .doc('classes')
      .snapshots()
      .map((documentSnapshot) {
    Map<String, dynamic> doc = documentSnapshot.data()!;
    Map<String, dynamic> classMap =
        doc['classes'] != null ? Map<String, dynamic>.from(doc['classes']) : {};

    List<TimetableEntry> classDaily = [];
    classMap.forEach((key, value) {
      classDaily.add(TimetableEntry(
        classid: key,
        timeDuration: value['classDuration'],
        className: value['className'],
        classLocation: value['classLocation'],
        startDateTime: (value['startDateTime'] as Timestamp).toDate(),
        endDateTime: (value['endDateTime'] as Timestamp).toDate(),
        day: value['day'],
        repeatUntil: (value['repeatTill'] as Timestamp).toDate(),
        color: value['color'],
      ));
    });
    return classDaily;
  });
});

// Stream<List<TimetableDayWise>> fetchDayWiseTimetable(
//     String? branch, String? year, String section, String day) {
//   final collectionReference = FirebaseFirestore.instance
//       .collection('timetables')
//       .doc(branch)
//       .collection('years')
//       .doc(year)
//       .collection('sections')
//       .doc(section)
//       .collection(day); // Use the 'day' parameter here

//   return collectionReference.snapshots().map((querySnapshot) {
//     return querySnapshot.docs.map((doc) {
//       Map<String, dynamic> data = doc.data();
//       return TimetableDayWise(
//         day: day, // Use the 'day' parameter here
//         data: {
//           doc.id: TimetableEntry(
//             classNumber: doc.id,
//             timeSlot: data['classDuration'],
//             className: data['className'],
//             classLocation: data['classLocation'],
//             startDateTime: (data['startDateTime'] as Timestamp).toDate(),
//             endDateTime: (data['endDateTime'] as Timestamp).toDate(),
//             repeatUntil: (data['repeatTill'] as Timestamp).toDate(),
//             day: data['day'],
//             color: data['color'],
//           ),
//         },
//       );
//     }).toList();
//   });
// }


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
