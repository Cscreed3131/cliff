import 'package:cliff/screens/placements/models/company_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final companyDataProvider = FutureProvider<List<CompanyData>>((ref) async {
  try {
    final companyDetailsDoc = await FirebaseFirestore.instance
        .collection('placement')
        .doc('CompanyDetails')
        .get();

    if (companyDetailsDoc.exists) {
      Map<String, dynamic> data =
          companyDetailsDoc.data() as Map<String, dynamic>;

      List<CompanyData> companies = data.entries.map((doc) {
        return CompanyData(
          companyName: doc.key, // Use the company name as the identifier
          companyDetails: doc.value['companyDetails'],
          jobDescription: doc.value['jobDescription'],
          vacancy: doc.value['vacancies'],
          allowedBranches: doc.value['allowedBranches'],
          backlogs: doc.value['maximumBacklogs'],
          cgpa: doc.value['minimumCgpa'],
          stipend: doc.value['stipend'],
          ctc: doc.value['ctc'],
          date: DateFormat('dd-MMM-yyyy').parse(doc.value['arrivalDate']),
          bond: doc.value['bond'],
        );
      }).toList();

      return companies;
    } else {
      return [];
    }
  } catch (e) {
    // Handle errors
    print('Error fetching company details: $e');
    return [];
  }
});

final companiesTodayProvider = FutureProvider<List<CompanyData>>((ref) async {
  final companyData = ref.watch(companyDataProvider);
  final currentDate = DateTime.now();

  List<CompanyData> todayCompanies = [];

  companyData.whenData((doc) {
    todayCompanies = doc.where((data) {
      return data.date.year == currentDate.year &&
          data.date.month == currentDate.month &&
          data.date.day == currentDate.day;
    }).toList();
  });

  return todayCompanies;
});

final upcomingCompaniesDataProvider =
    FutureProvider<List<CompanyData>>((ref) async {
  final companyData = ref.watch(companyDataProvider);
  final currentDate = DateTime.now();

  List<CompanyData> upcomingCompanies = [];

  companyData.whenData((doc) {
    upcomingCompanies = doc.where((data) {
      return data.date.isAfter(currentDate);
    }).toList();
  });

  return upcomingCompanies;
});
