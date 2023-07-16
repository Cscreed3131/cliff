import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliderImage {
  final int id;
  final AssetImage image;

  SliderImage(this.id, this.image);
}

final imageItemsProvider = Provider<List<SliderImage>>(
  (ref) {
    // Replace this with your own data fetching logic or a static list
    return [
      SliderImage(
        1,
        const AssetImage('assets/images/p1.jpg'),
      ),
      SliderImage(
        2,
        const AssetImage('assets/images/p2.jpg'),
      ),
      SliderImage(
        3,
        const AssetImage('assets/images/p3.jpg'),
      ),
      SliderImage(
        4,
        const AssetImage('assets/images/p4.jpg'),
      ),
    ];
  },
);
