import 'package:animate_do/animate_do.dart';
import 'package:cliff/sub_sections/placements/provider/company_data_provider.dart';
import 'package:cliff/sub_sections/placements/screens/placement_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingPlacements extends ConsumerStatefulWidget {
  const UpcomingPlacements({super.key});

  @override
  ConsumerState<UpcomingPlacements> createState() => _UpcomingPlacementsState();
}

class _UpcomingPlacementsState extends ConsumerState<UpcomingPlacements> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final font24 = screenHeight * 0.03;
    final companyData = ref.watch(upcomingCompaniesDataProvider);
    return companyData.when(data: (data) {
      if (data.isEmpty)
        return Center(
          child: Text('No data found'),
        );
      else
        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              //final eventData = ongoingEvents[index];

              return FadeIn(
                duration: Duration(milliseconds: 100 * (index + 1)),
                child: InkWell(
                  //navigate to placements details screen
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PlacementDetails(
                            data: data[index],
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.transparent,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.2),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: screenHeight * 0.157,
                                width: screenWidth * 0.3,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/image2.png", // this will change according to the logo of the company
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Company name text
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Text(
                                      data[index].companyName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: font24,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        // color: textColor,
                                      ),
                                    ),
                                  ),

                                  //An person icon followed by the number of students
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Vacancies: ${data[index].vacancy}", // put the number of vacancies here.
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                            // color: textColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Two Chips saying internship and full time/part time
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 10),
                                    child: Row(
                                      children: [
                                        Chip(
                                          side: BorderSide.none,
                                          label: const Text(
                                            "Internship",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              //color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Chip(
                                          side: BorderSide.none,
                                          label: Text(
                                            index.isEven
                                                ? "Full Time"
                                                : "Part Time",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              //color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
    }, error: (error, stackTrace) {
      return Center(
        child: Text("Error Occured"),
      );
    }, loading: () {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    });
  }
}
