

import '../../../data/repository/firebase_product_repository.dart';
import '../../../domain/entries/product_entitie.dart';
import '../../../domain/usecase/product/create_product_use_case.dart';

class AddProductController {
  CreateProductUseCase createProductUseCase = CreateProductUseCase(
    FirebaseProductRepository(),
  );

  Future<void> saveProduct({
    required String title,
    required String description,
    required String price,
    required String category,
    required List<String> imageUrls,
  }) async {
    try {
      Product product = Product(
        id: '',
        title: title,
        description: description,
        price: price,
        category: category,
        imageUrls: imageUrls,
      );

      await createProductUseCase.execute(product);
    } catch (e) {
      print("Erreur lors de la création du produit : $e");
      rethrow;
    }
  }
}
