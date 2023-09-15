import 'package:cliff/screens/classroom/widgets/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduledClasses extends ConsumerStatefulWidget {
  const ScheduledClasses({Key? key}) : super(key: key);
  static const routeName = "/ScheduleClass";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScheduledClassesState();
}

class _ScheduledClassesState extends ConsumerState<ScheduledClasses> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar.large(
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text(
                  "Classroom",
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   height: screenHeight * 0.2,
                      //   width: double.infinity,
                      //   margin: const EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: Theme.of(context).colorScheme.outline,
                      //     ),
                      //     color:
                      //         Theme.of(context).colorScheme.secondaryContainer,
                      //     borderRadius: BorderRadius.circular(20),
                      //     image: const DecorationImage(
                      //       image: AssetImage('assets/images/empty.png'),
                      //       fit: BoxFit.fitWidth,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      DailyPlanWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10, // Adjust the distance from the bottom as needed
            right: 10, // Adjust the distance from the right as needed
            child: ElevatedButton.icon(
              onPressed: () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    0.0, // Scroll to the top
                    duration: const Duration(
                      milliseconds: 300,
                    ), // Adjust the duration as needed
                    curve: Curves.easeInOut, // Adjust the curve as needed
                  );
                }
              },
              icon: const Icon(Icons.arrow_upward_rounded),
              label: const Text('Move Up'),
            ),
          ),
        ],
      ),
    );
  }
}
