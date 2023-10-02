import 'dart:ui';

import 'package:flutter/material.dart';

class PlacementsTrainer extends StatelessWidget {
  static const routeName = '/placements-trainer';
  const PlacementsTrainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: screenHeight * 0.27,

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Trainer",
                style: TextStyle(
                  fontFamily: 'IBMPlexMono',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              expandedTitleScale: 1.2,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/company_image.png'),
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
                            Theme.of(context).colorScheme.surface.withOpacity(0.5),
                            Theme.of(context).colorScheme.surface.withOpacity(0.6),
                            Theme.of(context).colorScheme.surface,
                          ],
                          stops: const [0.0, 0.5 ,1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Icon(
                        Icons.stars_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const Text(
                      "AI powered Cliff Trainer will help you prepare for your dream job.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(
                          Icons.stars_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    Card(
                      elevation: 10,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          //put a common coding interview question here
                          child: const Text(
                            "What is the difference between a list and a tuple?",
                            style: TextStyle(
                              //fontSize: 20,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      elevation: 10,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          //answer to the question
                          child: const Text(
                            "Lists are mutable, tuples are immutable.",
                            style: TextStyle(
                              //fontSize: 20,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          "Y",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                      ),
                    ),
                    const SizedBox(width: 10),

                  ],
                ),


              ],
            ),
          )
        ],
      ),

      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

        ),

        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              hintText: "Type your answer here",
              hintStyle: TextStyle(
                //color: Theme.of(context).colorScheme.onPrimary,
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
