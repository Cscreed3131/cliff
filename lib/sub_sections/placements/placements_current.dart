import 'package:animate_do/animate_do.dart';
import 'package:cliff/sub_sections/placements/screens/placement_details_screen.dart';
import 'package:cliff/sub_sections/placements/provider/company_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentPlacements extends ConsumerStatefulWidget {
  const CurrentPlacements({super.key});

  @override
  ConsumerState<CurrentPlacements> createState() => _CurrentPlacementsState();
}

class _CurrentPlacementsState extends ConsumerState<CurrentPlacements> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final font24 = screenHeight * 0.03;
    final companyData = ref.watch(companiesTodayProvider);

    return companyData.when(data: (data) {
      if (data.isEmpty)
        return Center(
          child: Text("No data found"),
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
              return FadeIn(
                duration: Duration(milliseconds: 100 * (index + 1)),
                child: InkWell(
                  //navigate to placements details screen
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlacementDetails(
                          data: data[index],
                        );
                      },
                    ),
                  ),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    shadowColor: Colors.transparent,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.3),
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
                                      "assets/images/image2.png", // might contain the logo of the company which is coming.
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
                                      data[index]
                                          .companyName, // this will contain the name of the company.
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
                                          "${data[index].vacancy}", // this will contain the number of students placed of the number of vacancies left;
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
                                          label: const Text(
                                            "Internship", // this will also come from the provider maybe a bool
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
                                          label: Text(
                                            index.isEven
                                                ? "Full Time"
                                                : "Part Time", // dynamicly from provider
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
      return CircularProgressIndicator.adaptive();
    });
  }
}
