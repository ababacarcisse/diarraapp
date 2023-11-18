// ce productusecase utilisation serait responsable de la création d'un nouveau produit
// en utilisant le repository approprié.
import '../../entries/product_entitie.dart';
import '../../repositories/productRepositorie.dart';

class CreateProductUseCase {
  final ProductRepository _productRepository;

  CreateProductUseCase(this._productRepository);

  Future<void> execute(Product product) async {
    await _productRepository.createProduct(product);
  }
}
