class UserDetails {
  final String name;
  final String sic;
  final String branch;
  final String email;
  final String year;
  final int? phoneNumber;
  final String imageUrl;
  final List likedProducts;
  final List<dynamic> registeredEvents;
  final Map<String, dynamic> cart;
  final List<dynamic> roles;

  UserDetails({
    required this.name,
    required this.sic,
    required this.branch,
    required this.email,
    required this.year,
    required this.phoneNumber,
    required this.imageUrl,
    required this.likedProducts,
    required this.registeredEvents,
    required this.cart,
    required this.roles,
  });
}
