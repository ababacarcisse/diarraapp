import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/entries/product_entitie.dart';
import '../../domain/repositories/productRepositorie.dart';
/*
Implémentation  des interfaces définies ProductRepository dans 
des implémentations spécifiques à Firestore et Storage pour chaque méthode
*/
class FirebaseProductRepository implements ProductRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _selectedImages = []; // Ajoutez cette ligne pour déclarer _selectedImages

  @override
  Future<void> createProduct(Product product) async {
    try {
      
      await _firestore.collection('products').add(product.toMap());

    } catch (e) {
      if (kDebugMode) {
        print("Erreur lors de la création du produit : $e");
      }
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      await _firestore.collection('products').doc(product.id).update(product.toMap());
    } catch (e) {
      print("Erreur lors de la mise à jour du produit : $e");
      rethrow;
    }
  }
  @override
  Future<void> deleteProduct(String productId) async {
    try {
      // Implémentez la logique pour supprimer un produit depuis Firestore
      await _firestore.collection('products').doc(productId).delete();
      // Ajoutez la logique pour supprimer les images associées de Firebase Storage si nécessaire
    } catch (e) {
      print("Erreur lors de la suppression du produit : $e");
      rethrow;
    }
  }

  @override
  Future<Product?> getProductById(String productId) async {
    try {
      // Implémentez la logique pour récupérer un produit par son ID depuis Firestore
      var productDoc = await _firestore.collection('products').doc(productId).get();
      if (productDoc.exists) {
        return Product.fromMap(productDoc.data()!);
      }
      return null;
    } catch (e) {
      print("Erreur lors de la récupération du produit : $e");
      rethrow;
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    try {
      // Implémentez la logique pour récupérer tous les produits depuis Firestore
      var querySnapshot = await _firestore.collection('products').get();
      return querySnapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
    } catch (e) {
      print("Erreur lors de la récupération de tous les produits : $e");
      rethrow;
    }
  }


  // Méthode pour téléverser les images dans Firebase Storage
 Future<List<String>> uploadImages(BuildContext context, List<PlatformFile> imageFiles) async {
  List<String> imageUrls = [];

  try {
    for (var imageFile in imageFiles) {
      final storageReference = FirebaseStorage.instance.ref().child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final Uint8List fileBytes = imageFile.bytes!;
      await storageReference.putData(fileBytes);
      final String imageUrl = await storageReference.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    return imageUrls;  // Renvoyer la liste complète d'URL une fois que toutes les images sont téléchargées.
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de l\'envoi des images : $e'),
      ),
    );
    rethrow; // Lancer une exception pour indiquer qu'une erreur s'est produite.
  }
}
  // ...
}
