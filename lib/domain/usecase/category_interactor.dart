
import '../entries/categorie_entitie.dart';
import '../repositories/categorieRepositorie.dart';

class CategoryInteractor {
  final CategoryRepository categoryRepository;

  CategoryInteractor(this.categoryRepository);

  Future<void> addCategory(String categoryName) async {
    final newCategory = Category(name: categoryName);
    await categoryRepository.addCategory(newCategory);
  }
}
