class TimetableEntry {
  final String classid;
  final String timeDuration;
  final String className;
  final String classLocation;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final DateTime repeatUntil;
  final String day;
  final String color;
  bool isAllDay = false;

  TimetableEntry({
    required this.classid,
    required this.timeDuration,
    required this.className,
    required this.classLocation,
    required this.startDateTime,
    required this.endDateTime,
    required this.day,
    required this.repeatUntil,
    required this.color,
  });
}
