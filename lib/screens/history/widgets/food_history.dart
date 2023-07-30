import 'package:flutter/material.dart';

class FoodHistory extends StatelessWidget {
  const FoodHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.5),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/image4.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    title: Text(
                      'Food Name',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'IBMPlexMono',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '\$Food Price',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontFamily: 'IBMPlexMono',
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
