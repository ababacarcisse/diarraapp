/*
 updateProductusecase serait responsable de la mise à jour d'un produit existant en utilisant le repository approprié.
*/


import '../../entries/product_entitie.dart';
import '../../repositories/productRepositorie.dart';

class UpdateProductUseCase {
  final ProductRepository _productRepository;

  UpdateProductUseCase(this._productRepository);

  Future<void> execute(Product product) async {
    await _productRepository.updateProduct(product);
  }
}
