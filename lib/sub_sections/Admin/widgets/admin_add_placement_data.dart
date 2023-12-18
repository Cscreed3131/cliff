import 'package:cliff/sub_sections/Admin/company_data_screen.dart';
import 'package:cliff/sub_sections/placements/provider/company_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminAddPlacementsData extends ConsumerStatefulWidget {
  const AdminAddPlacementsData({super.key});

  @override
  ConsumerState<AdminAddPlacementsData> createState() =>
      _AdminAddPlacementsDataState();
}

class _AdminAddPlacementsDataState
    extends ConsumerState<AdminAddPlacementsData> {
  @override
  Widget build(BuildContext context) {
    final companyData = ref.watch(companyDataProvider);
    final numberOfCompanies = companyData.when(
      data: (data) {
        return "${data.length} companies";
      },
      error: (error, stackTrace) {
        print(error);
        print(stackTrace);
        return 'Error loading data';
      },
      loading: () {
        return 'Loading...';
      },
    );
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
              numberOfCompanies, // this will contain the number of companies fetched from the provider.
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
                //add company data screen
                Navigator.of(context).pushNamed(AddCompanyData.routeName);
              },
              label: Text('Add Company'),
            ),
          ),

          //list of companies
          companyData.when(data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Text('No data available'),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        data[index].companyName,
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
                            '₹ ${data[index].ctc} ', // this will contain the ctc of the company fetched from the provider.
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
                            ' Vac: ${data[index].vacancy}  ', // this will contain the students who are placed in the company.
                            // for now this contain the number of vacancies in the company.
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
              );
            }
          }, error: (error, stackTrace) {
            return Text(error.toString());
          }, loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          }),

          //list of companies
        ],
      ),
    );
  }
}
