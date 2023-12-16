import 'package:cliff/sub_sections/Admin/company_data_screen.dart';
import 'package:flutter/material.dart';

class AdminAddPlacementsData extends StatefulWidget {
  const AdminAddPlacementsData({super.key});

  @override
  State<AdminAddPlacementsData> createState() => _AdminAddPlacementsDataState();
}

class _AdminAddPlacementsDataState extends State<AdminAddPlacementsData> {
  @override
  Widget build(BuildContext context) {
    //names of random companies
    List<String> companies = [
      'Google',
      'Twitter',
      'Uber',
      'Zomato',
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          //3 cards, one for highest salary offered, second amount of people placed and third for average salary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //card 1
              Card(
                elevation: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.height * 0.13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹ 10 LPA',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'IBMPlexMono',
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Highest \nSalary',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //card 2
              Card(
                elevation: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.height * 0.13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '100',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'IBMPlexMono',
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Students \nPlaced',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //card 3
              Card(
                elevation: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.height * 0.13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹ 5 LPA',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'IBMPlexMono',
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Average \nSalary',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ListTile(
            title: Text(
              '4 companies ',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontFamily: 'IBMPlexMono',
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'This month',
              style: TextStyle(
                //fontSize: MediaQuery.of(context).size.width * 0.05,
                fontFamily: 'IBMPlexMono',
                //color: Theme.of(context).colorScheme.primary,
                //fontWeight: FontWeight.bold,
              ),
            ),
            trailing: FilledButton.icon(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddCompanyData.routeName);
              },
              label: Text('Add Company'),
            ),
          ),

          //list of companies
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: companies.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  isThreeLine: true,
                  title: Text(
                    companies[index],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontFamily: 'IBMPlexMono',
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₹ 10 LPA ',
                        style: TextStyle(
                          //fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'IBMPlexMono',
                          //color: Theme.of(context).colorScheme.primary,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        radius: 1.5,
                        backgroundColor: Colors.grey,
                      ),
                      Text(
                        ' 🤵 100 ',
                        style: TextStyle(
                          //fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontFamily: 'IBMPlexMono',
                          //color: Theme.of(context).colorScheme.primary,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ],
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
