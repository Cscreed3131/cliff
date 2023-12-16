import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlacementsQuiz extends StatefulWidget {
  static const routeName = '/placements-quiz';
  const PlacementsQuiz({super.key});

  @override
  State<PlacementsQuiz> createState() => _PlacementsQuizState();
}

class _PlacementsQuizState extends State<PlacementsQuiz> with SingleTickerProviderStateMixin{

  final ScrollController _scrollController = ScrollController();
  late final AnimationController _hideFabAnimation;


  List<bool> leetIsChecked = [false, false, false, false, false];
  List<bool> geeksIsChecked = [false, false, false, false, false];
  List<bool> interviewBitIsChecked = [false, false, false, false, false];
  List<String> questionNames = ["Two Sum", "Add Two Numbers", "Longest Substring Without Repeating Characters", "Median of Two Sorted Arrays", "Longest Palindromic Substring"];


  @override
  void initState() {
    super.initState();
    _hideFabAnimation = AnimationController(vsync: this, duration: kThemeAnimationDuration);

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
    //This page will a series of cards with questions on them and the link to them in a button
    return NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              title: const Text('Mock Questions', style: TextStyle(fontFamily: 'IBMPlexMono')),
              pinned: true,
            ),

            SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text listing out how many sections and questions there are
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "There are 3 sections with 5 questions each.",
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Leetcode Questions: 5",
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "GeeksForGeeks Questions: 5",
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "InterviewBit Questions: 5",
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //Leetcode Questions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Leetcode Questions",
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  //only display the first two lines of the column and then add a button to view the rest of the question
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        itemBuilder: (ctx, index) => Column(
                                          children: [
                                            CheckboxListTile(
                                              isThreeLine: true,
                                              subtitle: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  ElevatedButton.icon(
                                                    onPressed: (){},
                                                    icon: Icon(Icons.link),
                                                    label: Text("View Question"),
                                                  ),
                                                  IconButton(
                                                    onPressed: (){},
                                                    icon: Icon(Icons.link),
                                                    //label: Text("View Solution"),
                                                  ),
                                                ],
                                              ),

                                              value: leetIsChecked[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  leetIsChecked[index] = value!;
                                                });
                                              },
                                              title: Text(
                                                "${index + 1}. ${questionNames[index]}",
                                                style: TextStyle(
                                                  fontFamily: 'IBMPlexMono',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    //GeeksForGeeks Questions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "GeeksForGeeks Questions",
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),

                                  //only display the first two lines of the column and then add a button to view the rest of the question
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        itemBuilder: (ctx, index) => Column(
                                          children: [
                                            CheckboxListTile(
                                              isThreeLine: true,
                                              subtitle: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  ElevatedButton.icon(
                                                    onPressed: (){},
                                                    icon: Icon(Icons.link),
                                                    label: Text("View Question"),
                                                  ),
                                                  IconButton(
                                                    onPressed: (){},
                                                    icon: Icon(Icons.link),
                                                    //label: Text("View Solution"),
                                                  ),
                                                ],
                                              ),

                                              value: geeksIsChecked[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  geeksIsChecked[index] = value!;
                                                });
                                              },
                                              title: Text(
                                                "${index + 1}. ${questionNames[index]}",
                                                style: TextStyle(
                                                  fontFamily: 'IBMPlexMono',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    //InterviewBit Questions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "InterviewBit Questions",
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),

                                  //only display the first two lines of the column and then add a button to view the rest of the question
                                  child: MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: 5,
                                        itemBuilder: (ctx, index) => Column(
                                          children: [
                                            CheckboxListTile(
                                              isThreeLine: true,
                                              subtitle: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  ElevatedButton.icon(
                                                    onPressed: (){},
                                                    icon: Icon(Icons.link),
                                                    label: Text("View Question"),
                                                  ),
                                                  IconButton(
                                                    onPressed: (){},
                                                    icon: Icon(Icons.link),
                                                    //label: Text("View Solution"),
                                                  ),
                                                ],
                                              ),

                                              value: interviewBitIsChecked[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  interviewBitIsChecked[index] = value!;
                                                });
                                              },
                                              title: Text(
                                                "${index + 1}. ${questionNames[index]}",
                                                style: TextStyle(
                                                  fontFamily: 'IBMPlexMono',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const Divider(),
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
            )
        ),
      )
    );
  }
}
