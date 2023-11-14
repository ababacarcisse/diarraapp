// domain/product.dart
import '../../domain/entries/product_entitie.dart';

class ProductModel {
    final String id;

  final String title;
  final String description;
  final String price;
  final List<String> imagePaths;

  ProductModel({required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePaths,
  });
   factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(id: entity.id ?? '',
    title: entity.title,
    description: entity.description,
    price: entity.price,
    imagePaths: entity.imageUrls);
  }
  //copier un product
  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    List<String>? imagePaths,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imagePaths: imagePaths ?? this.imagePaths,
    );
  }
}
