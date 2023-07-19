import 'package:flutter/material.dart';


class AlumniScreen extends StatelessWidget {
  const AlumniScreen({super.key});
  static const routeName = '/fathers';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text(
              "Alumni",
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                // color: textColor,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //event image container, this will not change (probably)
                        Container(
                            height: screenHeight * 0.2,
                            width: double.infinity,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondaryContainer,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/alumni_page.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            )),

                        const SizedBox(
                          height: 20,
                        ),
                      ]
                  )
              )
          )
        ],
      ),
    );
  }
}
