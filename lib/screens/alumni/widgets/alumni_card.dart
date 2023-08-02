import 'package:animate_do/animate_do.dart';
import 'package:cliff/global_varibales.dart';
import 'package:flutter/material.dart';

class AlumniCard extends StatefulWidget {
  final String selectedDepartment;
  final int selectedYear;
  const AlumniCard({super.key, required this.selectedDepartment, required this.selectedYear});

  @override
  State<AlumniCard> createState() => _AlumniCardState();
}

class _AlumniCardState extends State<AlumniCard> {
  int start = 200;
  int delay = 100;



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: alumniDetails.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return widget.selectedDepartment == 'All' && widget.selectedYear == alumniDetails[index].year
                || widget.selectedDepartment == alumniDetails[index].branch && widget.selectedYear == alumniDetails[index].year
                ?

            FadeIn(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: screenHeight * 0.165,
                        width: screenHeight * 0.165,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(alumniDetails[index].imgUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              alumniDetails[index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                alumniDetails[index].branch,
                                style: const TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 15,
                                ),
                              ),
                              CircleAvatar(
                                radius: 2,
                                backgroundColor: Theme.of(context).colorScheme.outline,
                              ),
                              Text(
                                alumniDetails[index].year.toString(),
                                style: const TextStyle(
                                  fontFamily: 'IBMPlexMono',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          //const Spacer(),
                          FilledButton.icon(
                            onPressed: (){},
                            label: const Text('LinkedIn'),
                            icon: const Icon(Icons.link),
                          ),

                          FilledButton.icon(
                            onPressed: (){},
                            label: const Text('Mail'),
                            icon: const Icon(Icons.link),
                          ),
                        ],
                      ),

                    ],
                  ),
                )
            ) : const SizedBox();
          },
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



