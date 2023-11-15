import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diarraapp/domain/entries/product_entitie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repositories/productRepositorie.dart';

class FirebaseProductRepository implements ProductRepository {
  
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //ajouter le produit
  Future<void> addProduct(ProductEntity product) async {
    try {
      // Téléversez d'abord les images sur Firebase Storage
      final List<String> imageUrls = await uploadImages(product.imageUrls);

      // Créez un nouvel objet ProductEntity avec les URLs des images téléchargées
      final updatedProduct = ProductEntity(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrls: imageUrls,
      );

      // Maintenant, ajoutez le produit avec les URLs des images à la base de données (Firebase Firestore par exemple)
      await _firestore.collection('products').add({
        'title': updatedProduct.title,
        'description': updatedProduct.description,
        'price': updatedProduct.price,
        'imageUrls': updatedProduct.imageUrls,
      });
    } catch (e) {
      // Gérez les erreurs appropriées ici
      print("Erreur lors de l'ajout du produit : $e");
      rethrow; // Vous pouvez gérer différemment selon vos besoins
    }
  }

  Future<List<String>> uploadImages(List<String> imagePaths) async {
    try {
      final List<String> imageUrls = [];

      for (var imagePath in imagePaths) {
        final file = File(imagePath);
        final fileName = basename(file.path);
        final storageRef = _storage.ref().child('product_images/${const Uuid().v4()}_$fileName');

        await storageRef.putFile(file);
        final imageUrl = await storageRef.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      return imageUrls;
    } catch (e) {
      print("Erreur lors du téléversement des images : $e");
      rethrow; // Vous pouvez gérer différemment selon vos besoins
    }
  }
}
