import 'package:animate_do/animate_do.dart';
import 'package:cliff/global_varibales.dart';
import 'package:flutter/material.dart';

class AlumniCard extends StatefulWidget {
  final String selectedDepartment;
  final int selectedYear;
  final bool? isVertical;
  const AlumniCard(
      {super.key,
      required this.selectedDepartment,
      required this.selectedYear, this.isVertical});

  @override
  State<AlumniCard> createState() => _AlumniCardState();
}

class _AlumniCardState extends State<AlumniCard> {
  int start = 200;
  int delay = 100;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Visibility(
        visible: hasAlumnis(),
        replacement: const Center(
          heightFactor: 10,
          child: Text(
            'No alumni found',
            style: TextStyle(
              fontFamily: 'IBMPlexMono',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: SizedBox(
          height: widget.isVertical == null ? screenHeight * 0.22 : alumniDetails.length * 40.0,
          child: widget.isVertical == null ?
          ListView.builder(
            shrinkWrap: true,
            itemCount: alumniDetails.length,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return widget.selectedDepartment == 'All' &&
                          widget.selectedYear == alumniDetails[index].year ||
                      widget.selectedDepartment == alumniDetails[index].branch &&
                          widget.selectedYear == alumniDetails[index].year
                  ? FadeIn(
                      child: Container(
                          width: 170,
                          height: 100,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      padding: const EdgeInsets.only(left : 10),
                      // decoration: BoxDecoration(
                      //   color: Theme.of(context).colorScheme.secondaryContainer,
                      //   border: Border.all(
                      //     color: Theme.of(context).colorScheme.outline,
                      //   ),
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                  alumniDetails[index].imgUrl,
                                ),
                              ),
                              Text(
                                alumniDetails[index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    alumniDetails[index].branch,
                                    style: const TextStyle(
                                      fontFamily: 'IBMPlexMono',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  CircleAvatar(
                                    radius: 2,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .outline,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    alumniDetails[index].year.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'IBMPlexMono',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                      ),
                        )
                    )))
                  : const SizedBox();
            },
          ) :
          ListView.builder(
            itemCount: alumniDetails.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return widget.selectedDepartment == 'All' &&
                          widget.selectedYear == alumniDetails[index].year ||
                      widget.selectedDepartment == alumniDetails[index].branch &&
                          widget.selectedYear == alumniDetails[index].year
                  ? FadeIn(
                      child: Container(
                          width: screenWidth * 0.9,
                          height: 100,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                      padding: const EdgeInsets.only(left : 10),
                      // decoration: BoxDecoration(
                      //   color: Theme.of(context).colorScheme.secondaryContainer,
                      //   border: Border.all(
                      //     color: Theme.of(context).colorScheme.outline,
                      //   ),
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                  alumniDetails[index].imgUrl,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    alumniDetails[index].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontFamily: 'IBMPlexMono',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        alumniDetails[index].branch,
                                        style: const TextStyle(
                                          fontFamily: 'IBMPlexMono',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        alumniDetails[index].year.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'IBMPlexMono',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),]),
                            ],
                          ),
                        )
                    )))
                  : const SizedBox();

            },

          ),
        ),
      ),
    );
  }

  bool hasAlumnis() {
    // Implement the logic to check if there are any alumnis based on the selectedDepartment and selectedYear.
    for (var alumni in alumniDetails) {
      if (widget.selectedDepartment == 'All' &&
              widget.selectedYear == alumni.year ||
          widget.selectedDepartment == alumni.branch &&
              widget.selectedYear == alumni.year) {
        return true;
      }
    }
    return false;
  }
}
