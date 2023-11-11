
import '../../comon/models/categorie_models.dart';
import '../../domain/repositories/categorieRepositorie.dart';
import '../datasource/categorie.dart';
import '../../domain/entries/categorie_entitie.dart';


class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<void> addCategory(Category category) async {

    final categoryModel = CategoryModel.fromEntity(category);
    await localDataSource.addCategory(categoryModel);
  }
  @override
  Future<void> updateCategory(String categoryId, String newName) async {
    await localDataSource.updateCategory(categoryId, newName);
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await localDataSource.deleteCategory(categoryId);
  }

  @override
  Stream<List<CategoryModel>> getCategories() {
    return localDataSource.getCategories();
  }
}