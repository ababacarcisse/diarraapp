

import '../../domain/entries/product_entitie.dart';
import '../../domain/repositories/productRepositorie.dart';
import '../datasource/firebaselocaldatasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseProductDataSource _dataSource;

  ProductRepositoryImpl(this._dataSource);

  @override
  Future<void> addProduct(ProductEntity product) async {
    try {
      // Téléversez d'abord les images sur Firebase Storage
      final List<String> imageUrls = await _dataSource.uploadImages(product.imageUrls);

      // Créez un nouvel objet ProductEntity avec les URLs des images téléchargées
      final updatedProduct = ProductEntity(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrls: imageUrls,
      );

      // Maintenant, ajoutez le produit avec les URLs des images à la base de données (Firebase Firestore par exemple)
      await _dataSource.addProduct(updatedProduct);
    } catch (e) {
      // Gérez les erreurs appropriées ici
      print("Erreur lors de l'ajout du produit : $e");
      rethrow; // Vous pouvez gérer différemment selon vos besoins
    }
  }
}
