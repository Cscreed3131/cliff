// do not touch this file this is finished

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageItem {
  final int id;
  final String title;
  final IconData icon;

  ImageItem(this.id, this.title, this.icon);
}

final gridItemsProvider = Provider<List<ImageItem>>(
  (ref) {
    // Replace this with your own data fetching logic or a static list
    return [
      ImageItem(
        1,
        "Events",
        Icons.event_outlined,
      ),
      ImageItem(
        2,
        "Food",
        Icons.dining_outlined,
      ),
      ImageItem(
        3,
        "Merchandise",
        Icons.checkroom_outlined,
      ),
      ImageItem(
        4,
        "Alumni",
        Icons.person_outline,
      ),
      ImageItem(
        5,
        "Memories",
        Icons.photo_album_outlined,
      ),
    ];
  },
);
