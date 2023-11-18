class Product {
  String id;
  String title;
  String description;
String price;
  String category;
  List<String> imageUrls;

  Product({
    required this.id,required this.price,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrls,
  });

  // Ajoutez des constructeurs ou méthodes supplémentaires si nécessaire

  // Méthode pour convertir les données de la classe en une Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'imageUrls': imageUrls,
      'price':price,
    };
  }

  // Fabrique pour créer une instance de la classe à partir d'une Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      category: map['category'],
      imageUrls: List<String>.from(map['imageUrls']),
    );
  }
}
