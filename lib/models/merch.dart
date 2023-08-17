class Merchandise {
  final String id;
  final String addedBy;
  final String createdBy;
  final String imageUrl;
  final String isForSale;
  final String productDescription;
  final String productName;
  final double productPrice;
  final List<dynamic> likes;

  Merchandise({
    required this.id,
    required this.addedBy,
    required this.createdBy,
    required this.imageUrl,
    required this.isForSale,
    required this.productDescription,
    required this.productName,
    required this.productPrice,
    required this.likes,
  });
}
