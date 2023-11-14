// product_use_case.dart
import 'package:diarraapp/domain/entries/product_entitie.dart';

import '../repositories/productRepositorie.dart';

class ProductUseCase {
  final ProductRepository productRepository;

  ProductUseCase(this.productRepository);

  Future<void> addProduct(ProductEntity product , ) async {
    await productRepository.addProduct(product);
  }
}
