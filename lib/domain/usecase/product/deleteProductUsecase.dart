//DeleteProductUseCase serait responsable de la suppression d'un produit en utilisant 
//le repository approprié.

import '../../repositories/productRepositorie.dart';

class DeleteProductUseCase {
  final ProductRepository _productRepository;

  DeleteProductUseCase(this._productRepository);

  Future<void> execute(String productId) async {
    await _productRepository.deleteProduct(productId);
  }
}
