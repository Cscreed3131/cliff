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
    final font24 = screenHeight * 0.03;

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
              childAspectRatio: 1.46,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index){
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                ),
                child: SizedBox(
                  width: double.maxFinite,
                  height: screenHeight * 0.3,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(imgPath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 8.0),
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: font24,
                              ),
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0).copyWith(top: 0),
                                  child: Icon(Icons.group)
                                ),
                                CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.outline,
                                  radius: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                                  child: Text(
                                    "100 Registered",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
