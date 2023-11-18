
import '../../domain/entries/categorie_entitie.dart';

class CategoryModel extends CategoryEntity {
  @override
  final String name;
  @override
  final String? id;
  const CategoryModel({required this.id ,required this.name,}) : super(name: name);

  // Créez des méthodes de conversion nécessaires ici, par exemple, fromEntity et toEntity
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(name: entity.name,id:entity.id);
  }

  // Ajoutez d'autres méthodes nécessaires ici
}