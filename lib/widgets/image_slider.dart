import 'package:cliff/provider/image_slider_images.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSlider extends ConsumerWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageItems = ref.watch(imageItemsProvider);

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 10),
        enlargeCenterPage: false,
        aspectRatio: 16 / 9,
        // enlargeFactor:,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 0.85,

        // animateToClosest: true,
      ),
      items: imageItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline
                  ),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: item.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 30,
                      height: 2,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
