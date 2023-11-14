// product_providers.dart
import 'package:diarraapp/data/datasource/firebase_product_data_source.dart';
import 'package:diarraapp/data/repository/firebase_product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/repositories/productRepositorie.dart';
import '../domain/usecase/Product_use_case.dart';

// Data sources
final firebaseProductDataSourceProvider =
    Provider<FirebaseProductDataSource>((ref) {
  return FirebaseProductDataSource();
});

// Repositories
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final firebaseDataSource = ref.watch(firebaseProductDataSourceProvider);
  return FirebaseProductRepository(firebaseDataSource);
});

// Use cases
final productUseCaseProvider = Provider<ProductUseCase>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductUseCase(productRepository);
});
