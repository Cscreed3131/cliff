import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:table_calendar/table_calendar.dart';

class DailyPlanWidget extends ConsumerStatefulWidget {
  const DailyPlanWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DailyPlanWidgetState();
}

class _DailyPlanWidgetState extends ConsumerState<DailyPlanWidget> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            height: screenHeight,
            child: SfCalendar(
              firstDayOfWeek: 1,
              allowedViews: const [
                CalendarView.day,
                CalendarView.month,
                CalendarView.week,
                CalendarView.schedule,
              ],

              // Initial view
              view: CalendarView.day,
              showCurrentTimeIndicator: true,

              // HeaderStyle
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontFamily: 'IBMPlexMono',
                  fontSize: 25,
                ),
              ),
              // headHeight
              headerDateFormat: 'MMM yyyy',
              headerHeight: 60,
              showNavigationArrow: true,

              //  SelectionBorderDecoration
              selectionDecoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).colorScheme.outline, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                shape: BoxShape.rectangle,
              ),

              //month view settings
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
              ),

              // some booleans
              allowViewNavigation: true,
              showDatePickerButton: true,
              showWeekNumber: true,
              showTodayButton: true,
              // set non working days
              timeSlotViewSettings: const TimeSlotViewSettings(
                nonWorkingDays: <int>[DateTime.sunday],
              ),
              dataSource: MeetingDataSource(_getDataSource()),
            ),
          ),
        ),
      ],
    );
  }
}

List<TimeTable> _getDataSource() {
  final List<TimeTable> classes = <TimeTable>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 18, 20, 0);
  final DateTime endTime = startTime.add(const Duration(minutes: 60));
  classes.add(TimeTable(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  return classes;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<TimeTable> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class TimeTable {
  TimeTable(
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
  );

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
