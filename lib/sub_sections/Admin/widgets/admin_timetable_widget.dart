import 'package:cliff/sub_sections/Admin/add_class_timetable.dart';
import 'package:cliff/sub_sections/Home/test_home_screen.dart';
import 'package:flutter/material.dart';

class AdminTimetableWidget extends StatefulWidget {
  const AdminTimetableWidget({super.key});

  @override
  State<AdminTimetableWidget> createState() => _AdminTimetableWidgetState();
}

class _AdminTimetableWidgetState extends State<AdminTimetableWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),

          ClassroomWidget(),

          const SizedBox(
            height: 20,
          ),
          //filled button saying add items
          Center(
            child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddClassTimeTable.routeName);
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Class',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'IBMPlexMono',
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
