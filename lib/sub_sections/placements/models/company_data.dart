class CompanyData {
  final String companyName;
  final String companyDetails;
  final String jobDescription;
  final int vacancy;
  final List<dynamic> allowedBranches;
  final DateTime date;
  final num cgpa;
  final num backlogs;
  final num stipend;
  final num ctc;
  final num bond;

  CompanyData({
    required this.companyName,
    required this.companyDetails,
    required this.jobDescription,
    required this.vacancy,
    required this.allowedBranches,
    required this.date,
    required this.cgpa,
    required this.backlogs,
    required this.stipend,
    required this.ctc,
    required this.bond,
  });
}
