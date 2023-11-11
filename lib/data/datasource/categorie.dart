
import '../../comon/models/categorie_models.dart';

abstract class CategoryLocalDataSource {
  Future<void> addCategory(CategoryModel category);
 Future<void> updateCategory(String categoryId, String newName);
  Future<void> deleteCategory(String categoryId);
  Stream<List<CategoryModel>> getCategories();
  // Ajoutez d'autres méthodes nécessaires ici
}
