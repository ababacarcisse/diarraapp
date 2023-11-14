

import 'package:diarraapp/data/repository/firebase_category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/firebase_category_data_source.dart';
import '../domain/repositories/categorieRepositorie.dart';
import '../domain/usecase/category_use_case.dart';

// Data sources
final firebaseCategoryDataSourceProvider = Provider<FirebaseCategoryDataSource>((ref) {
  return FirebaseCategoryDataSource();
});




// Repositories
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final firebaseDataSource = ref.read(firebaseCategoryDataSourceProvider);
  return FirebaseCategoryRepository(firebaseDataSource);
});

// Use cases
final categoryUseCaseProvider = Provider<CategoryUseCase>((ref) {
  final categoryRepository = ref.read(categoryRepositoryProvider);
  return CategoryUseCase(categoryRepository);
});
