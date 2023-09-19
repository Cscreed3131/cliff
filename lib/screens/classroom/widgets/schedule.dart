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
              dataSource: _getDataSource(ref),
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
      data.dayWiseTimetable.forEach(
        (day, dayWiseData) {
          dayWiseData.forEach(
            (element) {
              for (var i in element) {
                i.data.forEach(
                  (classNumber, timetableEntry) {
                    print(timetableEntry.className);
                    classes.add(
                      Appointment(
                        startTime: timetableEntry.startDateTime,
                        endTime: timetableEntry.endDateTime,
                        subject: timetableEntry.className,
                        // location: timetableEntry.classLocation,
                        color: Color(
                          int.parse(timetableEntry.color),
                        ),
                        endTimeZone: '',
                        startTimeZone: '',
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      );
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
