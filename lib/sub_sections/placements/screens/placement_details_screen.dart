import 'dart:ui';

import 'package:cliff/sub_sections/placements/models/company_data.dart';
import 'package:cliff/sub_sections/placements/placements_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class PlacementDetails extends StatefulWidget {
  static const routeName = '/placement-details';
  final CompanyData data;

  PlacementDetails({required this.data, Key? key}) : super(key: key);

  @override
  State<PlacementDetails> createState() => _PlacementDetailsState();
}

class _PlacementDetailsState extends State<PlacementDetails>
    with TickerProviderStateMixin {
  bool isInterested = false;
  final ScrollController _scrollController = ScrollController();
  late AnimationController _hideFabAnimation;
  @override
  void initState() {
    super.initState();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    _hideFabAnimation.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    List<String> chipItems = [
      "Flutter",
      "Dart",
      "Firebase",
      "Flutter",
      "Dart",
      "Firebase"
    ];

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.27,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/company_image.png'), // this will change according to company logo and become the background of the appbar.
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withOpacity(0.5),
                              Theme.of(context).colorScheme.surface,
                            ],
                            stops: const [0.0, 1.4],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.3,
                              //padding: const EdgeInsets.only(top: 10),
                              margin: const EdgeInsets.only(top: 120, left: 20),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  // this will also change dynamically.
                                  image: AssetImage(
                                      'assets/images/company_image.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 120),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.companyName, // this will contain the name of the company.
                                    style: TextStyle(
                                      fontFamily: 'IBMPlexMono',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${data.vacancy}',
                                    style: TextStyle(),
                                  ),
                                  const Text(
                                    'Internship with PPO',
                                  ),
                                  //Chip showing the date of the placement drive
                                  Chip(
                                    side: BorderSide.none,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                        .withOpacity(0.9),
                                    avatar: Icon(Icons.event),
                                    label: Text(
                                      '${DateFormat('dd-MMM-yyy').format(data.date)}', // date on the which the placement drive will happen
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        isInterested
                            ? OutlinedButton.icon(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {
                                  setState(() {
                                    isInterested = !isInterested;
                                  });
                                },
                                label: const Text("Interested"))
                            : ElevatedButton.icon(
                                icon: const Icon(Icons.favorite),
                                onPressed: () {
                                  setState(() {
                                    isInterested = !isInterested;
                                  });
                                },
                                label: const Text("Interested")),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton.filledTonal(
                          icon: Icon(Icons.quiz_outlined),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(PlacementsQuiz.routeName);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.language_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share_outlined,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    //About section
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'About us',
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text(data.companyDetails),

                    //Job description section
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Job Description',
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(data.jobDescription),

                    //Text stating vacancies
                    Text(
                      '\nVacancies : ${data.vacancy}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Eligibility section
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Eligibility',
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      'CGPA : ${data.cgpa}\nBacklogs : ${data.backlogs}\nBranches Allowed : ${data.allowedBranches}',
                    ),
                    const Text("Following skills will be highly appreciated: "),

                    //Chips for skills, which are in the Wrap widget
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 5,
                      children: chipItems
                          .map((item) => Chip(
                                side: BorderSide.none,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                    .withOpacity(0.7),
                                label: Text(item),
                              ))
                          .toList(),
                    ),

                    //Salary section
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Compensation',
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Stipend : ₹ ${data.stipend}\nCTC : ₹ ${data.ctc}\nBond : ${data.bond} years",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: ScaleTransition(
            scale: _hideFabAnimation,
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              elevation: 8,
              onPressed: () {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    0.0, // Scroll to the top
                    duration: const Duration(
                      milliseconds: 300,
                    ), // Adjust the duration as needed
                    curve: Curves.easeInOut, // Adjust the curve as needed
                  );
                }
              },
              child: const Icon(Icons.arrow_upward),
            )),
      ),
    );
  }
}
