
import '../../comon/models/categorie_models.dart';
import '../entries/categorie_entitie.dart';

abstract class CategoryRepository {
  Future<void> addCategory(Category category);
  Future<void> updateCategory(String categoryId, String newName);
  Future<void> deleteCategory(String categoryId);
  Stream<List<CategoryModel>> getCategories();

}
