class UserDetails {
  String name;
  String sic;
  String branch;
  String email;
  String year;
  int? phoneNumber;
  String imageUrl;
  List likedProducts;
  List registeredEvents;
  List<String> cart;

  UserDetails(
      this.name,
      this.sic,
      this.branch,
      this.email,
      this.year,
      this.phoneNumber,
      this.imageUrl,
      this.likedProducts,
      this.registeredEvents,
      this.cart);
}
