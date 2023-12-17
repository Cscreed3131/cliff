import 'package:cliff/sub_sections/placements/models/company_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final companyDataProvider = FutureProvider<List<CompanyData>>(
  (ref) async {
    try {
      final companyDetailsQuery =
          await FirebaseFirestore.instance.collection('companies').get();

      if (companyDetailsQuery.docs.isNotEmpty) {
        List<CompanyData> companies = companyDetailsQuery.docs.map((doc) {
          Map<String, dynamic> data = doc.data();

          return CompanyData(
            companyName: data['companyName'], // Use the actual field name
            companyDetails: data['companyDetails'],
            jobDescription: data['jobDescription'],
            vacancy: data['vacancies'],
            allowedBranches: data['allowedBranches'],
            backlogs: data['maximumBacklogs'],
            cgpa: data['minimumCgpa'],
            stipend: data['stipend'],
            ctc: data['ctc'],
            date: DateFormat('dd-MMM-yyyy').parse(data['arrivalDate']),
            bond: data['bond'],
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
  },
);

final companiesTodayProvider = FutureProvider.autoDispose<List<CompanyData>>(
  (ref) async {
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
  },
);

final upcomingCompaniesDataProvider =
    FutureProvider.autoDispose<List<CompanyData>>(
  (ref) async {
    final companyData = ref.watch(companyDataProvider);
    final currentDate = DateTime.now();

    List<CompanyData> upcomingCompanies = [];

    companyData.whenData((doc) {
      upcomingCompanies = doc.where((data) {
        return data.date.isAfter(currentDate);
      }).toList();
    });

    return upcomingCompanies;
  },
);
