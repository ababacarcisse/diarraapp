



import '../../comon/models/product_models.dart';
import '../../domain/entries/product_entitie.dart';
import '../../domain/repositories/productRepositorie.dart';
import '../datasource/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

    @override
  Future<void> addProduct(ProductEntity product) async {
    final productModel = product as ProductModel;
    await localDataSource.addProduct(productModel);
  }
  @override
  Future<void> updateProduct(String productId, String newTitle,
  String newDescription,
  String newPrice,String newImages ) async {
    await localDataSource.updateProduct(productId, 
    newTitle,
    newDescription,
    newPrice,
    newImages
    );
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await localDataSource.deleteProduct(productId);
  }

  
  @override
  Stream<List<ProductModel>> getProducts() {
    // TODO: implement getProducts
    return localDataSource.getProducts();
  }
}