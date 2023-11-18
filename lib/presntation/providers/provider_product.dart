import 'package:riverpod/riverpod.dart';

import '../../data/repository/firebase_product_repository.dart';
import '../../domain/repositories/productRepositorie.dart';
import '../../domain/usecase/product/create_product_use_case.dart';
import '../../domain/usecase/product/deleteProductUsecase.dart';
import '../../domain/usecase/product/get_AllProduct_useCase.dart';
import '../../domain/usecase/product/get_productbyId_usecase.dart';
import '../../domain/usecase/product/update_product_usecase.dart';
/*
j'ai crée des providers Riverpod pour le repository (productRepositoryProvider) pour
chaque cas d'utilisation. Chaque cas d'utilisation dépend du repository,
 et Riverpod gère automatiquement les mises à jour des fournisseurs lorsqu'une dépendance change.


*/
// Fournisseur pour le repository
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return FirebaseProductRepository(); // Instanciez votre repository ici
});

// Fournisseurs pour les cas d'utilisation
final createProductUseCaseProvider = Provider<CreateProductUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return CreateProductUseCase(repository);
});

final updateProductUseCaseProvider = Provider<UpdateProductUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return UpdateProductUseCase(repository);
});

final deleteProductUseCaseProvider = Provider<DeleteProductUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return DeleteProductUseCase(repository);
});

final getProductByIdUseCaseProvider = Provider<GetProductByIdUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductByIdUseCase(repository);
});

final getAllProductsUseCaseProvider = Provider<GetAllProductsUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetAllProductsUseCase(repository);
});
