class TimetableEntry {
  final String classNumber;
  final String timeSlot;
  final String className;
  final String classLocation;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final DateTime repeatUntil;
  final String day;
  final String color;
  bool isAllDay = false;

  TimetableEntry({
    required this.classNumber,
    required this.timeSlot,
    required this.className,
    required this.classLocation,
    required this.startDateTime,
    required this.endDateTime,
    required this.day,
    required this.repeatUntil,
    required this.color,
  });
}

class TimetableDayWise {
  final String day;
  final Map<String, TimetableEntry> data;
  TimetableDayWise({
    required this.day,
    required this.data,
  });
}

class Timetable {
  Map<String, Stream<List<TimetableDayWise>>> dayWiseTimetable;
  Timetable({
    required this.dayWiseTimetable,
  });
}
