
import '../entries/product_entitie.dart';
import '../repositories/productRepositorie.dart';

class ProductInteractor {
  final ProductRepository _repository;

  ProductInteractor(this._repository);

  Future<void> addProduct(ProductEntity product) async {
    await _repository.addProduct(product);
  }
}
