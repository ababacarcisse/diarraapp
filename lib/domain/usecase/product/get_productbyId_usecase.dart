/*
GetProductByIdUseCase serait responsable de la récupération d'un produit par son ID en utilisant
 le repository approprié.
*/


import '../../entries/product_entitie.dart';
import '../../repositories/productRepositorie.dart';

class GetProductByIdUseCase {
  final ProductRepository _productRepository;

  GetProductByIdUseCase(this._productRepository);

  Future<Product?> execute(String productId) async {
    return await _productRepository.getProductById(productId);
  }
}
