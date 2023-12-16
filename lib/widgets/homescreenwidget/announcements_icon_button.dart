import 'package:cliff/models/announcements.dart';
import 'package:cliff/provider/announcements_provider.dart';
import 'package:cliff/sub_sections/Home/announcements_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class AnnouncementIconButton extends ConsumerWidget {
  const AnnouncementIconButton({super.key});

  List<Announcements>? getAnnouncements(WidgetRef ref) {
    final updates = ref.watch(announcementsStreamProvider);
    List<Announcements>? list;
    updates.whenData((value) => list = value);
    return list;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updatesList = getAnnouncements(ref);
    final updatesCount = updatesList?.length ?? 0;
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          PageAnimationTransition(
            page: const AnnouncementScreen(),
            pageAnimationType: RightToLeftFadedTransition(),
          ),
        );
      },
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            const Icon(
              Icons.campaign,
              size: 35,
            ),
            if (updatesCount > 0)
              Badge(
                backgroundColor: Colors.red,
                label: Text(
                  updatesCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
                child: const Icon(
                  Icons.campaign,
                  size: 35,
                ),
              ),
            // if (updatesList!.isNotEmpty)
            // Positioned(
            //   right: 0,
            //   bottom: 10,
            //   child: Container(
            //     padding: const EdgeInsets.all(2),
            //     decoration: BoxDecoration(
            //       color: Colors.red,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     constraints: const BoxConstraints(
            //       minWidth: 16,
            //       minHeight: 16,
            //     ),
            //     child: Text(
            //       updatesCount.toString(),
            //       style: const TextStyle(
            //         color: Colors.white,
            //         fontSize: 10,
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
