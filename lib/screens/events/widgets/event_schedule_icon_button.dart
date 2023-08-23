import 'package:cliff/provider/registered_events_data_provider.dart';
import 'package:cliff/screens/Events/registered_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class EventScheduleIconButton extends ConsumerWidget {
  const EventScheduleIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registeredEventData = ref.watch(notCompletedEventsProvider);

    return registeredEventData.when(
      data: (value) {
        return IconButton(
          onPressed: () {
            Navigator.of(context).push(
              PageAnimationTransition(
                page: const RegisteredEventsScreen(),
                pageAnimationType: RightToLeftFadedTransition(),
              ),
            );
          },
          icon: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.event_note, size: 32),
              ),
              if (value.isNotEmpty)
                Positioned(
                  right: 8,
                  bottom: 20,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      value.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      loading: () {
        return const CircularProgressIndicator(); // Show loading indicator
      },
      error: (error, stackTrace) {
        return const Text('Loading');
      },
    );
  }
}
