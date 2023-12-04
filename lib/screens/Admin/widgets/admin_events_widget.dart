import 'dart:ui';

import 'package:cliff/screens/Admin/create_event_screens.dart';
import 'package:flutter/material.dart';

class AdminEventsWidget extends StatefulWidget {
  const AdminEventsWidget({super.key});

  @override
  State<AdminEventsWidget> createState() => _AdminEventsWidgetState();
}

class _AdminEventsWidgetState extends State<AdminEventsWidget> {
  bool isCompletedSelected = false;
  bool isOngoingSelected = false;
  bool isAllSelected = true;

  String selectedFilter = 'all';

  final List<EventItem> events = [

    EventItem('The Great Gatsby', 'Completed'),
    EventItem('Quantum Quest', 'Ongoing'),
    EventItem('Cyber Spark', 'Completed'),
    EventItem('Velocity Voyage', 'Ongoing'),
    EventItem('Tech Trek Expo', 'Completed'),
    EventItem('Quantum Quest', 'Ongoing'),
    EventItem('Cyber Spark', 'Completed'),
    EventItem('Velocity Voyage', 'Ongoing'),
    EventItem('Tech Trek Expo', 'Completed'),
    EventItem('Quantum Quest', 'Ongoing'),
    EventItem('Cyber Spark', 'Completed'),
    EventItem('Velocity Voyage', 'Ongoing'),
    EventItem('Tech Trek Expo', 'Completed'),
    EventItem('Quantum Quest', 'Ongoing'),
    EventItem('Cyber Spark', 'Completed'),
    EventItem('Velocity Voyage', 'Ongoing'),
    EventItem('Tech Trek Expo', 'Completed'),
    EventItem('Tech Trek Expo', 'Completed'),
    EventItem('Tech Trek Expo', 'Completed'),
    EventItem('Tech Trek Expo', 'Completed'),
    EventItem('Tech Trek Expo', 'Completed'),
  ];

  void handleFilterChipSelection(String chipType) {
    setState(() {
      selectedFilter = chipType;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Center(
              child: Text(
                '08',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.08,
                  fontFamily: 'IBMPlexMono',
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),

            Center(
              child: Text(
                'club events this month',
                maxLines: 3,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'IBMPlexMono',
                ),
              )
            ),
            const SizedBox(height: 20),
            //a row with two elevated buttons, one saying add event and the other saying view events
            Center(
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, CreateEventScreen.routeName);
                },
                icon: Icon(Icons.add),
                label: Text(
                  'Add Event',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontFamily: 'IBMPlexMono',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Events',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontFamily: 'IBMPlexMono',
              ),
            ),
            const SizedBox(height: 20),

            //events are in the form of chips, with an edit button on the right, they are inside a wrap widget
            //3 filter chips, completed, ongoing, all
            //a search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Events',
                hintStyle: TextStyle(
                  fontFamily: 'IBMPlexMono',
                ),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                FilterChip(
                  onSelected: (bool value) {
                    handleFilterChipSelection('all');
                  },
                  selected: selectedFilter == 'all',
                  label: Text(
                    'All',
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  onSelected: (bool value) {
                    handleFilterChipSelection('Completed');
                  },
                  selected: selectedFilter == 'Completed',
                  label: Text(
                    'Completed',
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FilterChip(
                  onSelected: (bool value) {
                    handleFilterChipSelection('Ongoing');
                  },
                  selected: selectedFilter == 'Ongoing',
                  label: Text(
                    'Ongoing',
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),
            //search bar

            Wrap(
              children: [
                for(var i=1; i<=20; i++)
                  if(selectedFilter == 'all' || events[i].status == selectedFilter)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                            image: DecorationImage(
                              //random image
                              image: NetworkImage('https://picsum.photos/20$i/300'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                                      Theme.of(context).colorScheme.background,
                                    ],
                                    stops: const [0.0, 1.4],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: ListTile(
                                  isThreeLine: events[i].status == 'Ongoing' ? true : false,
                                  title: Text(
                                    events[i].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexMono',
                                    ),
                                  ),
                                  subtitle: events[i].status == 'Ongoing' ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        events[i].status,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow.shade800,
                                          fontFamily: 'IBMPlexMono',
                                        ),
                                      ),
                                      Text(
                                        'Scheduled: 20/10/2021',
                                        style: TextStyle(
                                          fontFamily: 'IBMPlexMono',
                                        ),
                                      ),
                                      Text(
                                        'Registered: 200',
                                        style: TextStyle(
                                          fontFamily: 'IBMPlexMono',
                                        ),
                                      ),
                                    ],
                                  ) :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        events[i].status,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'IBMPlexMono',
                                        ),
                                      ),
                                      Text(
                                        'Date: 20/10/2021',
                                        style: TextStyle(
                                          fontFamily: 'IBMPlexMono',
                                        ),
                                      ),
                                      Text(
                                        'Registered: 200',
                                        style: TextStyle(
                                          fontFamily: 'IBMPlexMono',
                                        ),
                                      ),
                                    ],

                                  ),
                                  trailing: events[i].status == 'Ongoing' ? IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {},
                                  ) : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ),
              ]
            )


          ],
        ),
      ),
    );
  }
}


//data list items containing the event name and the status of the event(completed or ongoing)
class EventItem {
  final String name;
  final String status;

  const EventItem(this.name, this.status);
}

