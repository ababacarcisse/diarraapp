
import '../../../comon/models/categorie_models.dart';
import '../../repositories/categorieRepositorie.dart';

class CategoryUseCase {
  final CategoryRepository categoryRepository;

  CategoryUseCase(this.categoryRepository);

  Future<void> addCategory(CategoryModel category) async {
    await categoryRepository.addCategory(category);
  }
}
