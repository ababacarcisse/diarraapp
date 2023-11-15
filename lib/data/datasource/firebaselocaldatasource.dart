import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entries/product_entitie.dart';

class FirebaseProductDataSource {
  final FirebaseStorage _storage = FirebaseStorage.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(ProductEntity product) async {
    try {
      // Ajoutez le produit à la base de données Firestore
      await _firestore.collection('products').add({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrls': product.imageUrls,
      });
    } catch (e) {
      print("Erreur lors de l'ajout du produit à Firestore : $e");
      rethrow;
    }
  }
  Future<List<String>> uploadImages(List<String> imagePaths) async {
    try {
      final List<String> imageUrls = [];

      for (var imagePath in imagePaths) {
        final file = File(imagePath);
        final fileName = basename(file.path);
        final storageRef = _storage.ref().child('product_images/${Uuid().v4()}_$fileName');

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
