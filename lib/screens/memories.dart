import 'package:cliff/global_varibales.dart';
import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';


class Memories extends StatelessWidget {
  const Memories({super.key});
  static const routeName = '/memories';
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final font20 = screenHeight * 0.02;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text(
              "Memories",
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // color: textColor,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    //event image container, this will not change (probably)
                    Container(
                    height: screenHeight * 0.2,
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/image2.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    )),

                    const SizedBox(
                      height: 20,
                    ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Event 1",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: font20, //should use media querry;
                            fontWeight: FontWeight.bold,
                            // color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GalleryImage(
                          key: const ValueKey("Event 1"),
                          numOfShowImages: 6,
                          titleGallery: "Event 1",
                          imageUrls: listOfUrls,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        indent: 16,
                        endIndent: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Event 2",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: font20, //should use media querry;
                            fontWeight: FontWeight.bold,
                            // color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GalleryImage(
                          key: const ValueKey("Event 2"),
                          numOfShowImages: 6,
                          titleGallery: "Event 2",
                          imageUrls: listOfUrls,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        indent: 16,
                        endIndent: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Event 3",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: font20, //should use media querry;
                            fontWeight: FontWeight.bold,
                            // color: textColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GalleryImage(
                          key: const ValueKey("Event 3"),
                          numOfShowImages: 6,
                          titleGallery: "Event 3",
                          imageUrls: listOfUrls,
                        ),
                      ),
                      const Divider(
                        indent: 16,
                        endIndent: 16,
                      ),


              ]
            )
          )
          )
        ],
      ),
    );
  }
}
