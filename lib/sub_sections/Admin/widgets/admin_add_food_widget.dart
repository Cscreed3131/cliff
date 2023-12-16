import 'package:cliff/sub_sections/Admin/add_food_item_screen.dart';
import 'package:flutter/material.dart';

class AdminAddFoodWidget extends StatefulWidget {
  const AdminAddFoodWidget({super.key});

  @override
  State<AdminAddFoodWidget> createState() => _AdminAddFoodWidgetState();
}

class _AdminAddFoodWidgetState extends State<AdminAddFoodWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),

          Center(
            child: Text(
              '₹ 1,000',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.06,
                fontFamily: 'IBMPlexMono',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          Center(
              child: Text(
            'revenue this month',
            maxLines: 3,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              fontFamily: 'IBMPlexMono',
            ),
          )),

          Center(
              child: Text(
            '+₹800 from last month',
            maxLines: 3,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.02,
              fontFamily: 'IBMPlexMono',
            ),
          )),

          const SizedBox(
            height: 20,
          ),

          //FilledButton saying add items
          Center(
            child: FilledButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AddFoodItems.routeName);
              },
              icon: const Icon(Icons.add),
              label: Text(
                'Add Items',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontFamily: 'IBMPlexMono',
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          //Text saying items
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Current Menu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontFamily: 'IBMPlexMono',
              ),
            ),
          ),

          //List of items
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      //random image
                      image:
                          NetworkImage('https://picsum.photos/200$index/300'),
                      fit: BoxFit.cover,
                    ),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  'Item $index',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontFamily: 'IBMPlexMono',
                  ),
                ),
                trailing: Text(
                  '₹ 100',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontFamily: 'IBMPlexMono',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
