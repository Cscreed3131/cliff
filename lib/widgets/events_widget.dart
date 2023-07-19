import 'package:flutter/material.dart';

class EventsWidget extends StatelessWidget {
  final String title;
  final String imgPath;
  final bool isOngoing;
  final int itemCount;
  const EventsWidget({super.key, required this.title, required this.imgPath, required this.isOngoing, required this.itemCount});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index){
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: GridTile(
                  child: Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(imgPath),
                            fit: BoxFit.cover,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.5),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: screenHeight * 0.09,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.1),
                                    Colors.black.withOpacity(0.5),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(Icons.group),
                                      ),
                                      const SizedBox(width: 5,),
                                      CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Colors.grey.shade900,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "20 Registered",
                                          )
                                      ),
                                    ],
                                  )

                                ],
                              )
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                            label: Text(
                                isOngoing ? "Ongoing" : "24.7.2023",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                )
                            ),
                            avatar: const Icon(
                              Icons.calendar_today,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
