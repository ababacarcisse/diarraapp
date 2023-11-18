//GetAllProductsUseCase serait responsable de la récupération de tous les produits en utilisant
// le repository approprié.
import '../../repositories/productRepositorie.dart';
import '../../entries/product_entitie.dart';

class GetAllProductsUseCase {
  final ProductRepository _productRepository;

  GetAllProductsUseCase(this._productRepository);

  Future<List<Product>> execute() async {
    return await _productRepository.getAllProducts();
  }
}
