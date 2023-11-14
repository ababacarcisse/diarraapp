



import 'dart:io';

import 'package:diarraapp/comon/models/product_models.dart';

import '../../domain/repositories/productRepositorie.dart';
import '../datasource/firebase_product_data_source.dart';

class FirebaseProductRepository implements ProductRepository {
  final FirebaseProductDataSource firebaseProductDataSource;
  FirebaseProductRepository(this.firebaseProductDataSource);

 @override
 
  Future addProduct(ProductModel product, List<File> images) async {
    try {
      final List<String> imageUrls = await firebaseProductDataSource.uploadImages(images);
    final updatedProduct = product.copyWith(imagePaths: imageUrls);      
      // Enregistrez le produit dans Firestore
   return   await firebaseProductDataSource.addProduct(updatedProduct);

    } catch (e) {
      throw Exception('Erreur lors de l\'ajout du produit : $e');
    }
  }
  

  
  @override
  Stream<List<ProductModel>> getProducts() {
    //get all products
    return firebaseProductDataSource.products();
   
  }
  
  @override
  Future<void> updateProduct(String productId, String title, String description, String price, String images) {
    //update product
    return firebaseProductDataSource.updateProduct(productId, title, description, price, images);
  }



  @override
  Future<void> deleteProduct(String productd) async {
    await firebaseProductDataSource.deleteProduct(productd);
  }


}