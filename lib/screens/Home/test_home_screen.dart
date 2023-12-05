import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cliff/screens/Events/event_screen.dart';
import 'package:cliff/screens/placements/placement_screen.dart';
import 'package:cliff/widgets/homescreenwidget/announcements_icon_button.dart';
import 'package:cliff/widgets/homescreenwidget/image_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/image_slider_images.dart';
import '../../widgets/homescreenwidget/classroom_widget.dart';
import '../../widgets/homescreenwidget/test_profile_dialog.dart';
import '../Admin/admin_screen.dart';
import '../Merch/buy_merch_screen.dart';
import '../classroom/providers/class_timetable_provider.dart';
import '../classroom/scheduled_classes.dart';
import '../food/food_screen.dart';



class TestHomeScreen extends StatefulWidget {
  static const routeName = '/test-home-screen';
  const TestHomeScreen({super.key});

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen> {



  @override
  Widget build(BuildContext context) {

    bool showHintText = true;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        // title: const Text(
        //   'Cliff',
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontFamily: 'IBMPlexMono',
        //   ),
        // ),

        //Title will be a search bar with the text "Cliff" in it
        title: SafeArea(
          child: Container(

            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: TextFormField(
                textAlign: TextAlign.center,
                onTap: () {
                  setState(() {
                    showHintText = false;
                  });
                },

                decoration: InputDecoration(
                  hintText: showHintText ? 'Cliff' : '',
                  hintStyle: TextStyle(
                    fontFamily: 'IBMPlexMono',
                    fontWeight: FontWeight.bold,
                  ),

                  border: InputBorder.none,



                  prefixIcon: AnnouncementIconButton(),
                 // suffixIcon: Icon(Icons.account_circle, color: Colors.teal, size: 40,),
                  //show a dialog box when pressed

                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(

                            insetPadding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.15
                                ),
                                Center(
                                  child: const Text(
                                    'Cliff',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'IBMPlexMono',
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ProfileDialog(),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Privacy Policy', style: TextStyle(color: Colors.grey.shade400),),
                                    const SizedBox(width: 10,),
                                    CircleAvatar(radius: 1, foregroundColor: Colors.grey, backgroundColor: Colors.grey,),
                                    const SizedBox(width: 10,),
                                    Text('Terms of Service', style: TextStyle(color: Colors.grey.shade400),),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.account_circle, color: Colors.lightBlueAccent, size: 30,),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
              child: ImageSlider()
            ),

            //Classroom widget for viewing the classes today
            ClassroomWidget(),

            //two card, one with placements another with food
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: Card(
                      child: ListTile(
                        onTap: () => {
                          Navigator.of(context).pushNamed(PlacementsScreen.routeName),
                        },
                        leading: Icon(Icons.work_outline, color: Theme.of(context).colorScheme.primary),
                        title: const Text('Placements', style: TextStyle(fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w700),),
                        subtitle: const Text('See more', style: TextStyle(fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w500),),
                        //trailing: const Icon(Icons.arrow_forward),
                      ),

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Card(
                      child: ListTile(
                        onTap: () => {
                          Navigator.of(context).pushNamed(FoodScreen.routeName),
                        },
                        leading: Icon(Icons.food_bank_outlined, color: Theme.of(context).colorScheme.primary),
                        title: const Text('Food', style: TextStyle(fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w700),),
                        subtitle: const Text('See more', style: TextStyle(fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w500),),
                        //trailing: const Icon(Icons.arrow_forward),
                      ),

                    ),
                  ),
                ),
              ],
            ),

            //A card with the title "Events" and a horizontal list of the recent events
            ListTile(

              title: const Text('Events', style: TextStyle(fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w700),),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => {
                Navigator.of(context).pushNamed(EventsScreen.routeName),
              }

            ),
            //A horizontal list of random images from the internet
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,

                shrinkWrap: true,
                itemBuilder: (context, index) {

                  //the container should be a rectangle with a width of 200 and height of 150
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 170,
                        height: 100,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://picsum.photos/20$index/300'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      const Text(
                        '   Event Title',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w500),),
                    ],
                  );
                },
              ),
            ),

            //A card with the title "Merch" and a horizontal list of the recent merch, will contain 2 items
            Card(
              elevation: 5,
              margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () => {
                      Navigator.of(context).pushNamed(BuyMerchScreen.routeName),
                    },
                    title: Text(
                      'Merch',
                      style: TextStyle(
                          fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    subtitle: Text(
                      'Hot designs this week',
                      style: TextStyle(
                          fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),

                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,

                      shrinkWrap: true,
                      itemBuilder: (context, index) {

                        //the container should be a rectangle with a width of 200 and height of 150
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: 120,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(

                                image: DecorationImage(
                                  image: NetworkImage('https://picsum.photos/30$index/300'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            const Text(
                              '   Merch Title',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontFamily: 'IBMPlexMono', fontWeight: FontWeight.w500),),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

          ]
        ),
      )
    );


  }
}


//Image Carousel
class ImageSlider extends ConsumerStatefulWidget {

  const ImageSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImageSliderState();
}

class _ImageSliderState extends ConsumerState<ImageSlider> {

  @override
  Widget build(BuildContext context) {
    final imageItems = ref.watch(imageItemsProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final containerBorderRadius = BorderRadius.circular(screenHeight * 0.02);
    final font30 = screenHeight * 0.03;

    int _current = 0;

    return Stack(
      children: [



        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                 _current = index;
              });
            },

            height: screenHeight * 0.25,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 10),
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            // enlargeFactor:,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            viewportFraction: 1,

            // animateToClosest: true,
          ),
          items: imageItems.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
                      // border: Border.all(
                      //     color: Theme.of(context).colorScheme.outline
                      // ),
                      borderRadius: BorderRadius.zero,
                      image: DecorationImage(
                        image: item.image,
                        fit: BoxFit.cover,
                      ),

                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.zero,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).colorScheme.surface,

                            Theme.of(context).colorScheme.surface.withOpacity(0.1),
                           Theme.of(context).colorScheme.surface.withOpacity(0.8),
                           Theme.of(context).colorScheme.surface,
                          ],
                          stops: const [0.0, 0.2, 0.8, 1.0],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0, left: 15.0),
                          child: ListTile(
                            title: Text(
                                item.title,
                              style: TextStyle(
                                fontSize: font30,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            //random gibberish
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Lorem ipsum dolor sit amet"),
                                //a filled button
                                FilledButton(
                                  onPressed: () {},
                                  child: const Text('Register Now'),
                                ),
                              ],
                            ),

                          )
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),

        //indicator
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageItems.map((image) {
              int index = imageItems.indexOf(image);
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: _current == index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primaryContainer,
                ),
              );
            }).toList(),
          ),
        ),



      ],
    );
  }
}

//ClassroomWidget()
class ClassroomWidget extends ConsumerStatefulWidget {
  const ClassroomWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClassroomWidgetState();
}

class _ClassroomWidgetState extends ConsumerState<ClassroomWidget> {
  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    int numberOfClassesToday = 0;

    List<TodaysScheduledClass> getTodaysScheduledClass(WidgetRef ref) {
      final timetableData = ref.watch(timeTableProvider);
      final List<TodaysScheduledClass> todaysScheduledClass = [];
      timetableData.when(data: (data) {

        for (var element in data) {
          if(element.className != "Lunch"){
            numberOfClassesToday++;
            todaysScheduledClass.add(
              TodaysScheduledClass(
                className: element.className,
                classStartTime: element.startDateTime,
                classEndTime: element.endDateTime,
                classRoom: element.classLocation,
                classColor: Color(int.parse(element.color)),
              ),
            );
          }
        }
      }, error: (error, stackTrace) {
        if (kDebugMode) {
          print(error);
          print(stackTrace);
        }

      }, loading: () {
        if (kDebugMode) {
          print('loading');
        }
      });
      // print("PRINTING FROM SCHEDULED CLASSESD");
      // print(_todaysScheduledClass);
      return todaysScheduledClass;

    }

    getTodaysScheduledClass(ref);


    return SizedBox(
      //height: screenHeight * 0.23,
      width: screenWidth * 0.95,
      child: Card(

        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //shadowColor: Colors.transparent,
        color: Theme.of(context)
            .colorScheme
            .primaryContainer
            .withOpacity(1),
        child: Container(
            decoration: BoxDecoration(
              // border: Border.all(
              //   color: Theme.of(context).colorScheme.primary,
              // ),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () => Navigator.of(context).pushNamed(ScheduledClasses.routeName),
                  leading: Icon(
                    Icons.person_pin_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    'Classroom',
                    style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: screenWidth * 0.05,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    numberOfClassesToday > 0 ?
                    'You have $numberOfClassesToday classes' :
                    'No classes. Enjoy your day!',
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: screenWidth * 0.04,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                //A list of chips consisting of items from the getTodaysScheduledClass() function, wrapped
                numberOfClassesToday > 0 ?  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(bottom: 10),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      for (var element in getTodaysScheduledClass(ref))
                        Chip(
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(50),
                          // ),
                          label: Text(
                            element.className,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: element.classColor.withOpacity(0.8),
                        ),
                    ],),
                ) : const SizedBox(),

              ],
            )
        ),
      ),
    );
  }


}

class TodaysScheduledClass {
  final String className;
  final DateTime classStartTime;
  final DateTime classEndTime;
  final String classRoom;
  final Color classColor;

  TodaysScheduledClass({
    required this.className,
    required this.classStartTime,
    required this.classEndTime,
    required this.classRoom,
    required this.classColor,
  });
}