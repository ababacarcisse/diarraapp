
import 'dart:io';

import '../../data/repository/firebase_product_repository.dart';
import '../entries/product_entitie.dart';
import '../repositories/productRepositorie.dart';

class ProductInteractor {
  final ProductRepository productRepository;

  ProductInteractor(this.productRepository);

  Future<void> addProduct(String productTitle,String productDescription,String productPrice,List<String> productImages) async {
   
   
   
   
    final newProduct = ProductEntity(
      title: productTitle,
      description: productDescription,
      price: productPrice,
      imageUrls: productImages,
    );
    await productRepository.addProduct(newProduct, productImages);
    
  }
}
