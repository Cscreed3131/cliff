import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SliderImage {
  final int id;
  final String title;
  final AssetImage image;

  SliderImage(this.id, this.image, this.title);
}

final imageItemsProvider = Provider<List<SliderImage>>(
  (ref) {
    // Replace this with your own data fetching logic or a static list

    //THE TITLES ARE SUBJECT TO CHANGE AS PER THE REQUIREMENTS
    return [
      SliderImage(
        1,
        const AssetImage('assets/images/events.png'),
        'Events'
      ),
      SliderImage(
        2,
        const AssetImage('assets/images/image2.png'),
        'Memories'
      ),
      SliderImage(
        3,
        const AssetImage('assets/images/image3.png'),
        'Polls'
      ),
      SliderImage(
        4,
        const AssetImage('assets/images/image4.png'),
        'Food'
      ),
    ];
  },
);
