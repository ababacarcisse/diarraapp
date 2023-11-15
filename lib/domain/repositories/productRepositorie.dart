import '../entries/product_entitie.dart';

abstract class ProductRepository {
  Future<void> addProduct(ProductEntity product);
}
