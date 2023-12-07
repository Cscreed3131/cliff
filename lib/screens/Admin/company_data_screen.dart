import 'package:flutter/material.dart';

class AddCompanyData extends StatefulWidget {
  const AddCompanyData({super.key});
  static const routeName = 'add-company-data';

  @override
  State<AddCompanyData> createState() => AddCompanyDataState();
}

class AddCompanyDataState extends State<AddCompanyData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add company data',
            style: TextStyle(fontFamily: 'IBMPlexMono')),
        centerTitle: true,
      ),
    );
  }
}
