import 'package:cliff/screens/Admin/company_data_screen.dart';
import 'package:flutter/material.dart';

class AdminAddPlacementsData extends StatefulWidget {
  const AdminAddPlacementsData({super.key});

  @override
  State<AdminAddPlacementsData> createState() => _AdminAddPlacementsDataState();
}

class _AdminAddPlacementsDataState extends State<AdminAddPlacementsData> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddCompanyData.routeName);
              },
              child: Text('Add Data'),
            ),
          ),
        ],
      ),
    );
  }
}
