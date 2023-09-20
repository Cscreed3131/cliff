import 'package:cliff/screens/classroom/providers/class_timetable_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
            height: screenHeight * 0.85,
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
                  fontSize: 20,
                ),
              ),
              // headHeight
              headerDateFormat: 'MMM yy',
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
              dataSource: _getDataSource(ref),
              appointmentTextStyle: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

_AppointmentDataSource _getDataSource(WidgetRef ref) {
  final timetableData = ref.watch(timeTableProvider);
  return timetableData.when(
    data: (data) {
      List<Appointment> classes = <Appointment>[];
      for (var element in data) {
        classes.add(Appointment(
          startTime: element.startDateTime,
          endTime: element.endDateTime,
          color: Color(int.parse(element.color)),
          subject: element.className,
          isAllDay: element.isAllDay,
          location: element.classLocation,
        ));
      }
      print(classes);
      return _AppointmentDataSource(classes);
    },
    error: (error, stackTrace) {
      print(error);
      print(stackTrace);
      return _AppointmentDataSource([]);
    },
    loading: () {
      print('loading....');
      return _AppointmentDataSource([]);
    },
  );
}
