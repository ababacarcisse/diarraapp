
// Interface pour le Repository
import 'package:file_picker/file_picker.dart';

import '../entries/product_entitie.dart';

//  interface ProductRepository avec des méthodes pour effectuer les opérations CRUD
abstract class ProductRepository {
  Future<void> createProduct(Product product, );
  Future<Product?> getProductById(String productId);
  Future<List<Product>> getAllProducts();
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String productId);
}
