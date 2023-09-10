class FoodItem {
  final int id;
  final String name;
  final String category;
  final String imgUrl;
  final double price;
  final String description;
  final bool available;

  FoodItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imgUrl,
    required this.price,
    required this.description,
    required this.available,
  });
}
