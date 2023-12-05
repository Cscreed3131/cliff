import 'dart:ui';

import 'package:cliff/screens/alumni/widgets/alumni_card.dart';
import 'package:flutter/material.dart';



class AlumniScreen extends StatefulWidget {
  const AlumniScreen({super.key});
  static const routeName = '/fathers';

  @override
  State<AlumniScreen> createState() => _AlumniScreenState();
}

class _AlumniScreenState extends State<AlumniScreen> {

  List<String> departments = [
    'All',
    'CSE',
    'ECE',
    'EEE',
    'MECH',
    'CIVIL',
  ];

  List<int> passoutYears = [
    2024,
    2023,
    2022,
    2021,
    2020,
    2019,
    2018,
    2017,
    2016,
    2015,
  ];

  String selectedDepartment = 'All';
  int selectedYear = 2024;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            automaticallyImplyLeading: false,
            title: const Text(
              "Alumni",
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // color: textColor,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsetsDirectional.only(
                start : 16.0,
                bottom: 16.0,
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Cliff",
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono',
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.onSurface,
                      // color: textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Connect",
                        style: TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                          // color: textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.connect_without_contact,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),

                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              expandedTitleScale: 1.2,
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/alumni_page.png'),
                    fit: BoxFit.fitWidth,
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

                    ),
                  ),
                ),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //     child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           //event image container, this will not change (probably)
          //           // Container(
          //           //     height: screenHeight * 0.2,
          //           //     width: screenWidth,
          //           //     margin: const EdgeInsets.all(10),
          //           //     decoration: BoxDecoration(
          //           //       color: Theme.of(context).colorScheme.secondaryContainer,
          //           //       border: Border.all(
          //           //         color: Theme.of(context).colorScheme.outline,
          //           //       ),
          //           //       borderRadius: BorderRadius.circular(20),
          //           //       image: const DecorationImage(
          //           //         image: AssetImage('assets/images/alumni_page.png'),
          //           //         fit: BoxFit.fitWidth,
          //           //       ),
          //           //     )
          //           // ),
          //
          //           //Drop down menus
          //           Row(
          //             children: [
          //
          //               const SizedBox(
          //                 width: 20,
          //               ),
          //               //drop down menu for departments
          //               DropdownButton<String>(
          //                 value: selectedDepartment,
          //                 icon: const Icon(Icons.arrow_downward),
          //                 iconSize: 24,
          //                 elevation: 16,
          //                 underline: Container(
          //                   height: 2,
          //                   color: Theme.of(context).colorScheme.outline,
          //                 ),
          //                 onChanged: (String? newValue) {
          //                   setState(() {
          //                     selectedDepartment = newValue!;
          //                   });
          //                 },
          //                 items: departments
          //                     .map<DropdownMenuItem<String>>((String value) {
          //                   return DropdownMenuItem<String>(
          //                     value: value,
          //                     child: Text(
          //                       value,
          //                       style: const TextStyle(
          //                         fontFamily: 'IBMPlexMono',
          //                         fontSize: 20,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   );
          //                 }).toList(),
          //               ),
          //               const SizedBox(
          //                 width: 10,
          //               ),
          //
          //               //drop down menu for passout year
          //               DropdownButton<int>(
          //                 value: selectedYear,
          //                 icon: const Icon(Icons.arrow_downward),
          //                 iconSize: 24,
          //                 elevation: 16,
          //                 underline: Container(
          //                   height: 2,
          //                   color: Theme.of(context).colorScheme.outline,
          //                 ),
          //                 onChanged: (int? newYear) {
          //                   setState(() {
          //                     selectedYear = newYear!;
          //                   });
          //                 },
          //                 items: passoutYears.map<DropdownMenuItem<int>>((int value) {
          //                   return DropdownMenuItem<int>(
          //                     value: value,
          //                     child: Text(
          //                       value.toString(),
          //                       style: const TextStyle(
          //                         fontFamily: 'IBMPlexMono',
          //                         fontSize: 20,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   );
          //                 }).toList(),
          //               ),
          //
          //
          //             ],
          //           ),
          //
          //           const SizedBox(
          //             height: 10,
          //           ),
          //
          //           //alumni grid view (with alumni details)
          //           AlumniCard(
          //              selectedDepartment: selectedDepartment,
          //              selectedYear: selectedYear,
          //          ),
          //
          //         ]
          //     )
          // )

          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AboutListTile(

                    icon: const Icon(Icons.info_outline),
                    applicationName: 'Cliff',
                    applicationVersion: '1.0.0',
                    applicationLegalese: '© 2023 Cliff',
                    aboutBoxChildren: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Cliff Connect© is enables you to connect with your alumni and get to know about their experiences and get guidance from them.",
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    child: Text(
                      "About Cliff Connect ",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    title: Text(
                      "Alumni from your department",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    trailing: Chip(
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      label: Text(
                        'CSE',
                        style: TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ),

                AlumniCard(selectedDepartment: 'CSE', selectedYear: 2024),

                const SizedBox(
                  height: 20,
                ),

                //most contacted alumni
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    title: Text(
                      "Most contacted alumni",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  )
                ),

                AlumniCard(selectedDepartment: 'All', selectedYear: 2020),

                const SizedBox(
                  height: 20,
                ),

                //view all alumni
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListTile(
                    title: Text(
                      "View all alumni",
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  )
                ),

                //drop down menus for departments and passout year
                Row(
                  children: [

                    const SizedBox(
                      width: 20,
                    ),
                    //drop down menu for departments
                    DropdownButton<String>(
                      value: selectedDepartment,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDepartment = newValue!;
                        });
                      },
                      items: departments
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    //drop down menu for passout year
                    DropdownButton<int>(
                      value: selectedYear,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      onChanged: (int? newYear) {
                        setState(() {
                          selectedYear = newYear!;
                        });
                      },
                      items: passoutYears.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            value.toString(),
                            style: const TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),]),

                AlumniCard(selectedDepartment: selectedDepartment, selectedYear: selectedYear, isVertical: true),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
