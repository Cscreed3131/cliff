import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = '/event-details';

  final String title;
  const EventDetailsScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final font30 = screenHeight * 0.04;
    final font24 = screenHeight * 0.02;
    final titleStyle = TextStyle(
      fontSize: font24,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSecondaryContainer,
    );
    return Scaffold(
        // might remove this app bar it look good
        appBar: AppBar(
          title: const Text('Event Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: double.maxFinite,
                height: screenHeight * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/vikalp.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1,
                    fontSize: font30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //FilledButton for number of registered people
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FilledButton.tonalIcon(
                      onPressed: () {},
                      label: const Text('20'),
                      icon: const Icon(Icons.group),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Register'),
                    ),
                  ),
                ],
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
              ),
              //event details (includes code, venue, supervisor sic, start date, start time, end date, end time, description)

              //Card for Supervisor details
              Card(
                child: ListTile(
                  leading: IconButton.filledTonal(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  title: const Text('Supervisor '),
                  subtitle: const Text(
                    'Mr. John Doe, SIC : 1234567890',
                    overflow: TextOverflow.ellipsis,
                  ),
                  titleTextStyle: titleStyle,
                ),
              ),

              //Cards for code and venue
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        //copy code to clipboard
                        onTap: () async {
                          await Clipboard.setData(
                              const ClipboardData(text: '123456'));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Code copied to clipboard'),
                            ),
                          );
                        },

                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.code,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text('Code'),
                        subtitle: const Text('123456'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text('Venue'),
                        subtitle: const Text('Room 101'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                ],
              ),

              //Cards for Start date and start time
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.event_available,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text(
                          'Start Date',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: const Text('01/01/2021'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.task_alt,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text(
                          'Start Time',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: const Text('10:00 AM'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                ],
              ),

              //cards for end date and end time
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.event_busy,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text(
                          'End Date',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: const Text('01/01/2021'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(
                      child: ListTile(
                        leading: IconButton.filledTonal(
                            onPressed: () {},
                            icon: Icon(
                              Icons.block,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        title: const Text(
                          'End Time',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: const Text('10:00 AM'),
                        titleTextStyle: titleStyle,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquam ultricies, nunc nisl aliquet nunc, vitae aliquam nisl nisl eu nunc. Donec euismod, nisl eget aliquam ultricies, nunc nisl aliquet nunc, vitae aliquam nisl nisl eu nunc.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
