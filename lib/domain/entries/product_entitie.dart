class ProductEntity {
  final String title;
  final String description;
  final double price;
  final List<String> imageUrls;

  ProductEntity({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrls,
  });
}
