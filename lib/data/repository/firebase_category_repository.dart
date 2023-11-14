
import '../../comon/models/categorie_models.dart';
import '../../domain/entries/categorie_entitie.dart';
import '../../domain/repositories/categorieRepositorie.dart';
import '../datasource/firebase_category_data_source.dart';



class FirebaseCategoryRepository implements CategoryRepository {
  final FirebaseCategoryDataSource firebaseCategoryDataSource;

  FirebaseCategoryRepository(this.firebaseCategoryDataSource);

  @override
  Future<void> addCategory(CategoryEntity category) async {
    final categoryModel = category as CategoryModel;
    await firebaseCategoryDataSource.addCategory(categoryModel);
  }

  @override
  Future<void> updateCategory(String categoryId, String newName) async {
    await firebaseCategoryDataSource.updateCategory(categoryId, newName);
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await firebaseCategoryDataSource.deleteCategory(categoryId);
  }

  @override
  Stream<List<CategoryModel>> getCategories() {
    return firebaseCategoryDataSource.categories();
  }
}