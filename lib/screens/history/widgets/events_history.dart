import 'package:cliff/provider/event_details_provider.dart';
import 'package:cliff/provider/registered_events_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EventsHistoryWidget extends ConsumerWidget {
  const EventsHistoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ref.watch(completedEventListProvider).when(
      data: (data) {
        int itemCount = data.length;
        return itemCount > 0
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemCount,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final registeredEvents =
                              ref.watch(eventDetailsStreamProvider);
                          return registeredEvents.when(
                            data: (value) {
                              for (var element in value) {
                                if (element.eventId == data[index]) {
                                  return Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        height: screenHeight * 0.1,
                                        width: screenWidth * 0.25,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer
                                              .withOpacity(0.5),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(element.imageUrl),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        element.eventName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontFamily: 'IBMPlexMono',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        DateFormat('dd-MM-yy ').format(
                                          element.eventFinishDateTime,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontFamily: 'IBMPlexMono',
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                              return null;
                            },
                            error: (Object error, StackTrace stackTrace) {
                              return const Center(
                                child: Text('cannot fetch data at the moment'),
                              );
                            },
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty.png',
                      height: screenHeight * 0.5,
                      width: screenWidth * 0.5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'No Events History',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'IBMPlexMono',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
      },
      error: (error, stackTrace) {
        print(error);
        print(stackTrace);
        return const Center(
          child: Text('Unable to fetch data at the moment'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // int itemCount = 7;
    // return itemCount > 0
    //     ? SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             MediaQuery.removePadding(
    //               context: context,
    //               removeTop: true,
    //               child: ListView.builder(
    //                 physics: const NeverScrollableScrollPhysics(),
    //                 itemCount: itemCount,
    //                 shrinkWrap: true,
    //                 itemBuilder: (context, index) {
    //                   return Container(
    //                     margin: const EdgeInsets.all(10),
    //                     decoration: BoxDecoration(
    //                       color:
    //                           Theme.of(context).colorScheme.secondaryContainer,
    //                       border: Border.all(
    //                         color: Theme.of(context).colorScheme.outline,
    //                       ),
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                     child: ListTile(
    //                       leading: Container(
    //                         height: screenHeight * 0.1,
    //                         width: screenWidth * 0.25,
    //                         decoration: BoxDecoration(
    //                           color: Theme.of(context)
    //                               .colorScheme
    //                               .primaryContainer
    //                               .withOpacity(0.5),
    //                           border: Border.all(
    //                             color: Theme.of(context).colorScheme.outline,
    //                           ),
    //                           borderRadius: BorderRadius.circular(20),
    //                           image: const DecorationImage(
    //                             image: AssetImage('assets/images/events.png'),
    //                             fit: BoxFit.fitWidth,
    //                           ),
    //                         ),
    //                       ),
    //                       title: Text(
    //                         'Event Name',
    //                         overflow: TextOverflow.ellipsis,
    //                         maxLines: 2,
    //                         style: TextStyle(
    //                           color: Theme.of(context).colorScheme.onSurface,
    //                           fontFamily: 'IBMPlexMono',
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                       subtitle: Text(
    //                         'Event Date',
    //                         overflow: TextOverflow.ellipsis,
    //                         style: TextStyle(
    //                           color: Theme.of(context).colorScheme.onSurface,
    //                           fontFamily: 'IBMPlexMono',
    //                         ),
    //                       ),
    //                       trailing: IconButton(
    //                         onPressed: () {},
    //                         icon: const Icon(
    //                           Icons.arrow_forward_ios,
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //           ],
    //         ),
    //       )
    //     : Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Image.asset(
    //               'assets/images/empty.png',
    //               height: screenHeight * 0.5,
    //               width: screenWidth * 0.5,
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             Text(
    //               'No Events History',
    //               style: TextStyle(
    //                 color: Theme.of(context).colorScheme.onSurface,
    //                 fontFamily: 'IBMPlexMono',
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
  }
}
