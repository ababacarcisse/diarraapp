import 'package:cloud_firestore/cloud_firestore.dart';

import '../../comon/models/categorie_models.dart';
import '../../domain/entries/categorie_entitie.dart';

class FirebaseCategoryDataSource {
  final CollectionReference categoriesCollection = FirebaseFirestore.instance.collection('categories');

  Future<void> addCategory(CategoryModel category) async {
    await categoriesCollection.add({
      'name': category.name,
    });
    }
  Future<void> updateCategory(String categoryId, String newName) async {
    await categoriesCollection.doc(categoryId).update({
      'name': newName,
    });
  }
    
  Future<void> deleteCategory(String categoryId) async {
    await categoriesCollection.doc(categoryId).delete();
  }
  //obtenir les categories
  Stream<List<CategoryModel>> categories() {
    return categoriesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CategoryModel.fromEntity(Category(
   id:  doc.id,
        name: doc['name'],
      ))).toList();
    });

  }
}