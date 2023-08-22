import 'package:cliff/provider/event_details_provider.dart';
import 'package:cliff/provider/registered_events_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RegisteredEventsScreen extends StatelessWidget {
  const RegisteredEventsScreen({super.key});
  static const routeName = 'registered-events';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final font38 = screenWidth * 0.07;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text(
            'Registered Events',
            style: TextStyle(
              fontSize: font38,
              fontWeight: FontWeight.bold,
              fontFamily: 'IBMPlexMono',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: RegisteredEventsListTile(
              screenHeight: screenHeight, screenWidth: screenWidth),
        )
      ],
    ));
  }
}

class RegisteredEventsListTile extends ConsumerStatefulWidget {
  const RegisteredEventsListTile({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisteredEventsListTileState();
}

class _RegisteredEventsListTileState
    extends ConsumerState<RegisteredEventsListTile> {
  @override
  Widget build(BuildContext context) {
    final eventsData = ref.watch(registeredEventsDataProvider);
    return eventsData.when(
      data: (data) {
        List<dynamic> userRegisteredEventsList = data;
        int itemCount = userRegisteredEventsList.length;
        return userRegisteredEventsList.isNotEmpty
            ? MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemCount: itemCount,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final eventsDataProvider =
                        ref.watch(eventDetailsStreamProvider);
                    return eventsDataProvider.when(
                      data: (data) {
                        for (var element in data) {
                          if (element.eventId ==
                              userRegisteredEventsList[index]) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                leading: Container(
                                  height: widget.screenHeight * 0.2,
                                  width: widget.screenWidth * 0.25,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .withOpacity(0.4),
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    // shows the image of the event
                                    image: DecorationImage(
                                      image: NetworkImage(element.imageUrl),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  element.eventName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontFamily: 'IBMPlexMono',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text(
                                  DateFormat('dd-MM-yy \thh:mm a').format(
                                    element.eventStartDateTime,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontFamily: 'IBMPlexMono',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // trailing: IconButton(
                                //   onPressed: () {},
                                //   icon: const Icon(Icons.arrow_forward_ios),
                                // ),
                              ),
                            );
                          }
                        }
                        return null;
                      },
                      error: (error, stackTrace) {
                        return Center(
                          child: Text(
                            'Unable to load you registered events at the moment',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontFamily: 'IBMPlexMono',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      loading: () {
                        return const CircularProgressIndicator();
                      },
                    );
                    // return Container(
                    //   margin: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     color: Theme.of(context).colorScheme.secondaryContainer,
                    //     border: Border.all(
                    //       color: Theme.of(context).colorScheme.outline,
                    //     ),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: ListTile(
                    //     leading: Container(
                    //       height: widget.screenHeight * 0.2,
                    //       width: widget.screenWidth * 0.25,
                    //       decoration: BoxDecoration(
                    //         color: Theme.of(context)
                    //             .colorScheme
                    //             .primaryContainer
                    //             .withOpacity(0.5),
                    //         border: Border.all(
                    //           color: Theme.of(context).colorScheme.outline,
                    //         ),
                    //         borderRadius: BorderRadius.circular(20),
                    //         image: const DecorationImage(
                    //           image: AssetImage('assets/images/events.png'),
                    //           fit: BoxFit.fitWidth,
                    //         ),
                    //       ),
                    //     ),
                    //     title: Text(
                    //       userRegisteredEventsList[index] ?? '',
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 2,
                    //       style: TextStyle(
                    //         color: Theme.of(context).colorScheme.onSurface,
                    //         fontFamily: 'IBMPlexMono',
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     subtitle: Text(
                    //       'Event date',
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 2,
                    //       style: TextStyle(
                    //         color: Theme.of(context).colorScheme.onSurface,
                    //         fontFamily: 'IBMPlexMono',
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     trailing: IconButton(
                    //       onPressed: () {},
                    //       icon: const Icon(Icons.arrow_forward_ios),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              )
            : Center(
                child: Text(
                  'No events registered',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontFamily: 'IBMPlexMono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
      },
      error: (error, stackTrace) {
        return const Text('Error in fetching data');
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
