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
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            borderOnForeground: true,
            child: Container(
              padding: const EdgeInsets.only(
                bottom: 20,
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

                // headHeight
                headerHeight: 60,

                allowViewNavigation: true,
                showDatePickerButton: true,
                showWeekNumber: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
