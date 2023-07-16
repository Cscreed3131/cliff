// do not touch this file this is finished

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageItem {
  final int id;
  final AssetImage image;

  ImageItem(this.id, this.image);
}

final gridItemsProvider = Provider<List<ImageItem>>(
  (ref) {
    // Replace this with your own data fetching logic or a static list
    return [
      ImageItem(
        1,
        const AssetImage('assets/images/events.jpg'),
      ),
      ImageItem(
        2,
        const AssetImage('assets/images/history.jpg'),
      ),
      ImageItem(
        3,
        const AssetImage('assets/images/merchandise.jpg'),
      ),
      ImageItem(
        4,
        const AssetImage('assets/images/alumni.jpg'),
      ),
      ImageItem(
        5,
        const AssetImage('assets/images/p5.jpg'),
      ),
      ImageItem(
        6,
        const AssetImage('assets/images/p6.jpg'),
      ),
    ];
  },
);
