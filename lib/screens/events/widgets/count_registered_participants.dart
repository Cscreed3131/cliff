import 'package:cliff/models/event.dart';
import 'package:cliff/provider/event_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountRegisteredParticipants extends ConsumerWidget {
  final String eventId;

  const CountRegisteredParticipants({
    super.key,
    required this.eventId,
  });

  int getParticipantsCount(List<Event> data, String eventId) {
    int participantsCount = 0;

    for (int i = 0; i < data.length; i++) {
      if (data[i].eventId == eventId) {
        participantsCount = data[i].registeredParticipants.length;
        break;
      }
    }

    return participantsCount;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsDetailProvider = ref.watch(eventDetailsStreamProvider);
    return eventsDetailProvider.when(data: (data) {
      int participantsCount = getParticipantsCount(data, eventId);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          avatar: const Icon(Icons.people),
          label: Text(
            '$participantsCount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          side: BorderSide.none,
        ),
      );
    }, error: (error, stackTrace) {
      print(error);
      print(stackTrace);
      return const Text('0');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
