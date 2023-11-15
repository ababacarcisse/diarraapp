import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../comon/models/product_models.dart';
import '../data/datasource/firebaselocaldatasource.dart';
import '../data/repository/product_repository_impl.dart';
import '../domain/entries/product_entitie.dart';
import '../domain/repositories/productRepositorie.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    FirebaseProductDataSource(),
  ),
);


final productControllerProvider = StateNotifierProvider<ProductController, AsyncValue<List<ProductModel>>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductController(repository);
});

class ProductController extends StateNotifier<AsyncValue<List<ProductModel>>> {
  final ProductRepository _repository;

  ProductController(this._repository) : super(AsyncValue.loading());

Future<void> addProduct(ProductEntity product) async {
  state = AsyncValue.loading();
  try {
    await _repository.addProduct(product);
    state = AsyncValue.data(
      [...state.when(data: (data) => data ?? [], loading: () => [], error: (error, _) => []) ?? [], ProductModel(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrls: product.imageUrls,
      )]
    );
  } catch (e, s) {
  state = AsyncValue.error(e, s);
  }
}

}
