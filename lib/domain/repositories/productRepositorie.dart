

import 'dart:io';

import '../../comon/models/product_models.dart';

abstract class ProductRepository {
  Future<void> addProduct(ProductModel product, List<String> imageUrls);

  Future<void> updateProduct(String productId, String title,String description,String price,String images);
  Future<void> deleteProduct(String productId);
  Stream<List<ProductModel>> getProducts();

}
