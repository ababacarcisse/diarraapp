
import 'package:diarraapp/comon/models/product_models.dart';


abstract class ProductLocalDataSource {
  Future<void> addProduct(ProductModel product);
 Future<void> updateProduct(String productId, String newTitle,String newDescription,
  String newPrice,String newImages );
  Future<void> deleteProduct(String productId);
  Stream<List<ProductModel>> getProducts();
  // Ajoutez d'autres méthodes 
}
